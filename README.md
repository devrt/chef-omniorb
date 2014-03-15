omniORB Cookbook
================

This cookbook will install omniORB a robust high performance CORBA ORB for C++.

Requirements
------------

- `build-essential` - omniORB requires c++ compiler.
- `python` - omniORB requires python.

Attributes
----------

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['omniorb']['version']</tt></td>
    <td>String</td>
    <td>which version to install</td>
    <td><tt>4.1.7</tt></td>
  </tr>
</table>

Usage
-----

Just include `omniorb` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[omniorb]"
  ]
}
```

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------

Apache 2.0

Author: Yosuke Matsusaka
