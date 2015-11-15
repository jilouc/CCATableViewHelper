
Pod::Spec.new do |s|

  s.name         = "CCATableViewHelper"
  s.version      = "0.0.1"
  s.summary      = "A set of helper classes to declutter UITableView's delegate and datasource."

  s.description  = <<-DESC
                  CCATableViewHelper is designed to reduce the amount of code you need to implement UITableViewDelegate and UITableViewDatasource. 
                  It provides base classes for UITableViewCell and UITableViewHeaderFooterView, unifying the way a cell or reusable view is registered, created or updated.
                  This way, section and cell descriptors become the place where the work is done. They are the mapping between your model and the table view. 
                   DESC

  s.homepage     = "https://github.com/jilouc/CCATableViewHelper"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Jean-Luc Dagon" => "jldagon@cocoapps.fr" }
  
  s.platform     = :ios, "8.0"
  
  s.source       = { :git => "https://github.com/jilouc/CCATableViewHelper.git", :tag => "0.0.1" }
  s.source_files  = "CCATableViewHelper/*.{h,m}"
  s.requires_arc = true

end
