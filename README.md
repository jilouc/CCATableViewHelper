# CCATableViewHelper
A set of helper classes to declutter UITableView's delegate and datasource

It is designed to reduce the amount of code you need to implement `UITableViewDelegate` and `UITableViewDatasource`.

It provides base classes for `UITableViewCell` and `UITableViewHeaderFooterView`, unifying the way a cell or reusable view is registered, created or updated.

This way, **section** and **cell descriptors** become the place where the work is done. They are the mapping between your model and the table view.
