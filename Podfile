# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'
use_frameworks!
workspace 'ChallengeProject'

def core_pods
  pod 'RxSwift'
  pod 'RxCocoa'
end

target 'RoomsFeature' do
  project 'RoomsFeature/RoomsFeature.xcodeproj'
  core_pods
end

target 'PeopleFeature' do
  project 'PeopleFeature/PeopleFeature.xcodeproj'
  core_pods
end

target 'Bank Challenge' do
  core_pods
end
