source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'

use_frameworks!

target 'CountrySelectTest' do

#HandyJSON
pod 'HandyJSON',:inhibit_warnings => true

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 10.0
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '10.0'
      end
    end
  end
end
