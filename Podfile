# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

workspace 'CampApp.xcworkspace'

target 'CampApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for CampApp
  pod 'XCoordinator'
  pod 'Localize'
  pod 'Carbon'
  pod 'SnapKit'

  #firebase
  pod 'Firebase/Analytics'
  pod 'Firebase/Auth'
  pod 'Firebase/Firestore'
  pod 'FirebaseFirestoreSwift'
  pod 'SPPermissions/LocationWhenInUse'
  pod 'SDWebImage'
end

target 'YTUI' do
  use_frameworks!

  project 'UI/YTUI.xcodeproj'

  pod 'XCoordinator'
  pod 'Localize'
  pod 'Carbon'
  pod 'SnapKit'

  pod 'SPPermissions/LocationWhenInUse'
  pod 'SDWebImage'
end

target 'Common' do
  use_frameworks!

  project 'Common/Common.xcodeproj'

  pod 'Localize'

end

target 'YTNetwork' do
  use_frameworks!

  project 'YTNetwork/YTNetwork.xcodeproj'
  

end


