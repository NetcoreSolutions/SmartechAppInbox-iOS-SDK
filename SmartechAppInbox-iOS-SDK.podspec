Pod::Spec.new do |s|
  s.name                    = 'SmartechAppInbox-iOS-SDK'
  s.version                 = '3.2.4'
  s.summary                 = 'The SmartechAppInbox iOS SDK for User Engagement.'
  s.description             = <<-DESC
                                Netcore Customer Engagement platform is a omni channel platform that delivers everything you need to drive mobile engagement and create valuable consumer relationships on mobile. The SmartechAppInbox iOS SDK enables your native iOS app to use app inbox feature. This guide contains all the information you need to integrate the SmartechAppInbox iOS SDK into your app.
                              DESC
  s.homepage                = "https://netcoresmartech.com"  
  s.documentation_url       = 'https://docs.netcoresmartech.com/docs/android-app-inbox-integration'
  s.license                 = { :type => "Commercial", :file => "LICENSE"}  
  s.author                  = { "Shankar Thorve" => "shankar.thorve@netcorecloud.com" } 
  s.source                  = { :git => 'https://github.com/NetcoreSolutions/SmartechAppInbox-iOS-SDK.git', :tag => "v#{s.version.to_s}" }
  s.ios.deployment_target   = '10.0'
  s.ios.vendored_frameworks = 'Frameworks/SmartechAppInbox/SmartechAppInbox.xcframework'
  s.frameworks              = 'Foundation', 'UIKit', 'SystemConfiguration', 'Security', 'CoreData'
  s.weak_framework          = 'UserNotifications'
  s.pod_target_xcconfig     = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  s.user_target_xcconfig    = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
end
