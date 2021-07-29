# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Bebelo' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  pod 'NVActivityIndicatorView'
  pod 'JGProgressHUD'
  pod 'IQKeyboardManagerSwift'
  pod 'Alamofire'
  pod 'AlamofireImage'
  pod 'SwiftyJSON'
  pod 'STPopup'
  pod 'PhoneNumberKit'
  pod 'ChameleonFramework/Swift'
 # pod 'MapboxAnnotationExtension', '0.0.1-beta.2'
 # pod 'Mapbox-iOS-SDK'
  pod 'Firebase/Core'
  pod 'Firebase/Messaging'
  pod 'Firebase/Analytics'
  pod 'Firebase/Auth'
  pod 'Firebase/Crashlytics'
  pod 'Firebase/Storage'
  pod 'Firebase/Firestore'
  pod 'FirebaseFirestoreSwift'
  #pod 'MapboxMaps', '10.6.0'
#pod 'MapboxCoreMaps'
#pod 'MapboxCommon'
#pod 'MapboxMobileEvents'
#pod 'Turf'
#pod 'CocoaImageHashing'
#pod 'mapbox-maps-ios'
#pod 'search-ios'
#pod 'atlantis'
  #pod 'MapboxSearchUI', "1.0.0-beta.5"
  #pod 'MapboxSearch', "1.0.0-beta.5"
  #pod 'MapboxSearchUI', ">= 1.0.0-beta.21", "< 2.0"
  #pod 'MapboxSearch', ">= 1.0.0-beta.21", "< 2.0"
  pod 'MapboxGeocoder.swift'
  #pod 'FloatingPanel'
  pod "DKChainableAnimationKit"
  pod 'DropDown'
  pod 'LGSideMenuController'
  pod 'WXImageCompress'
  pod 'SwiftyGif'
  pod 'Localize-Swift'
  pod 'SQLite.swift'
end
post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
            end
        end
    end
end
