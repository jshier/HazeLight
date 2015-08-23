platform :ios, '9.0'

inhibit_all_warnings!

use_frameworks!

target 'HazeLight' do
  pod 'Alamofire', :git => 'https://github.com/Alamofire/Alamofire.git', :branch => 'swift-2.0'
  pod 'Argo', :git => 'https://github.com/jshier/Argo.git', :branch => 'td-swift-2'
  pod 'Operations', :git => 'https://github.com/danthorpe/Operations.git', :branch => 'swift_2/OPR-53_update_swift_2'
  pod 'Curry'
end

target 'HazeLightTests' do 
  pod 'OHHTTPStubs'
end

target 'HazeLightUITests' do 
  pod 'OHHTTPStubs'
end

plugin 'cocoapods-keys', {
  :project => "HazeLight",
  :target => "HazeLight",
  :keys => [
    "CloudFlareAPIKey"
]}
