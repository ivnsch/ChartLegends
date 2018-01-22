Pod::Spec.new do |s|
  s.name = "ChartLegends"
  s.version = "0.0.4"
  s.summary = "Powerful customizable legends for all kind of charts"
  s.homepage = "https://github.com/i-schuetz/SwiftCharts"
  s.license = { :type => "Apache License, Version 2.0", :file => "LICENSE" }
  s.authors = { "Ivan Schuetz" => "ivanschuetz@gmail.com"} 
  s.ios.deployment_target = "8.0"
  s.source = { :git => "https://github.com/i-schuetz/ChartLegends.git", :tag => s.version, :branch => 'master' }
  s.source_files = 'ChartLegends/*.swift', 'ChartLegends/**/*.swift'
  s.frameworks = "Foundation", "UIKit"
  s.resource_bundles = {
   'ChartLegends' => [
       'ChartLegends/**/*.xib'
   ]
 }
end
