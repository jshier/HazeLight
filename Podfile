platform :ios, '12.0'

install! 'cocoapods',
         :generate_multiple_pod_projects => true,
         :incremental_installation => true

pod 'SwiftLint'

target 'HazeLight' do
  # use_frameworks!
  
  pod 'Alamofire', '~> 5.0.0.beta.3'
  pod 'Valet'

  target 'HazeLightTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'HazeLightUITests' do
    inherit! :search_paths
    # Pods for testing
  end
end
