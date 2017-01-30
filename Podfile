platform :ios, '10.0'

use_frameworks!
inhibit_all_warnings!

def stubs
  pod 'OHHTTPStubs/Core'
  pod 'OHHTTPStubs/NSURLSession'
  pod 'OHHTTPStubs/JSON'
  pod 'OHHTTPStubs/OHPathHelpers'
  pod 'OHHTTPStubs/Swift'
end

target 'HazeLight' do
  pod 'Alamofire'
  pod 'Argo'
  pod 'Curry'
  pod 'Runes'
  
  target 'HazeLightTests' do
    inherit! :search_paths
    
    stubs
  end
  
  target 'HazeLightUITests' do
    inherit! :search_paths
    
    stubs
  end
end

plugin 'cocoapods-keys', {
  :project => "HazeLight",
  :target => "HazeLight",
  :keys => [
    "CloudFlareAPIKey"
]}
