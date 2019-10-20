# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'
use_frameworks!
workspace 'ChallengeProject'

def core_pods
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'Swinject'
end

target 'RoomsFeature' do
  project 'RoomsFeature/RoomsFeature.xcodeproj'
  core_pods
  
  target 'RoomsFeatureTests' do
    inherit! :search_paths
    core_pods
    pod 'RxTest'
  end
  
end

target 'PeopleFeature' do
  project 'PeopleFeature/PeopleFeature.xcodeproj'
  core_pods
  
  target 'PeopleFeatureTests' do
    inherit! :search_paths
    core_pods
    pod 'RxTest'
  end
  
end

target 'Bank Challenge' do
  core_pods
end
