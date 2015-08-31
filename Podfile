platform :ios, '9.0'

inhibit_all_warnings!

use_frameworks!

target :'HazeLight', :exclusive => true do
  pod 'Alamofire', '~> 2.0.0-beta.3'
  pod 'Argo', :git => 'https://github.com/jshier/Argo.git', :branch => 'td-swift-2'
  pod 'Operations', :git => 'https://github.com/danthorpe/Operations.git', :branch => 'swift_2.0'
  pod 'Curry'
end

target :'HazeLightTests', :exclusive => true do
  pod 'OHHTTPStubs'
end

target :'HazeLightUITests', :exclusive => true do
  pod 'OHHTTPStubs'
end

plugin 'cocoapods-keys', {
  :project => "HazeLight",
  :target => "HazeLight",
  :keys => [
    "CloudFlareAPIKey"
]}
