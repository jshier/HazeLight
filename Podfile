platform :ios, '9.0'

use_frameworks!
inhibit_all_warnings!

target :'HazeLight', :exclusive => true do
  pod 'Alamofire', :git => 'https://github.com/Alamofire/Alamofire.git', :branch => 'feature/double_generic_results'
  pod 'Argo'
  pod 'Operations'
  pod 'Curry'
end

target :'HazeLightTests', :exclusive => true do
  pod 'OHHTTPStubs/Core'
  pod 'OHHTTPStubs/NSURLSession'
  pod 'OHHTTPStubs/JSON'
  pod 'OHHTTPStubs/OHPathHelpers'
  pod 'OHHTTPStubs/Swift'
end

target :'HazeLightUITests', :exclusive => true do
  pod 'OHHTTPStubs/Core'
  pod 'OHHTTPStubs/NSURLSession'
  pod 'OHHTTPStubs/JSON'
  pod 'OHHTTPStubs/OHPathHelpers'
  pod 'OHHTTPStubs/Swift'
end

plugin 'cocoapods-keys', {
  :project => "HazeLight",
  :target => "HazeLight",
  :keys => [
    "CloudFlareAPIKey"
]}
