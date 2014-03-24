#
# Cookbook Name:: omniorb
# Recipe:: default
#
# Copyright 2014, Yosuke Matsusaka
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'build-essential'
include_recipe 'python'

install_path = '/usr/local/bin/omniidl'

remote_file "#{Chef::Config[:file_cache_path]}/omniORB-#{node["omniorb"]["version"]}.tar.bz2" do
  source "http://downloads.sourceforge.net/project/omniorb/omniORB/omniORB-#{node["omniorb"]["version"]}/omniORB-#{node["omniorb"]["version"]}.tar.bz2"
  not_if { ::File.exists?(install_path) }
end

bash 'compile_omniorb' do
  cwd Chef::Config['file_cache_path']
  code <<-EOH
      tar xvfi omniORB-#{node["omniorb"]["version"]}.tar.bz2
      cd omniORB-#{node["omniorb"]["version"]}
      ./configure
      make clean && make && make install
      ldconfig
  EOH
  not_if { ::File.exists?(install_path) }
end

service 'omninames' do
  supports :restart => true, :start => true, :stop => true, :reload => true
  action :nothing
end

template 'omniorb' do
  path '/etc/init.d/omninames'
  source 'omninames.erb'
  owner 'root'
  group 'root'
  mode '0755'
  variables({
              :platform => node['platform']
            })
  notifies :enable, 'service[omninames]'
  notifies :start, 'service[omninames]'
end

if node['platform'] == 'centos'
  template '/etc/ld.so.conf.d/omniorb.conf' do
    source  'ld.so.conf.erb'
    mode    '0644'
  end
  execute 'ldconfig'
end
