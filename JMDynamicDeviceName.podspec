#
# Be sure to run `pod lib lint JMDynamicDeviceName.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JMDynamicDeviceName'
  s.version          = '0.9.1'
  s.summary          = 'JMDynamicDeviceName is a library to avoid application update for each new Apple devices.'
  s.description      = <<-DESC
Each devices has a id (like "iPad6,7") when doing analytics it's more simple to manipulate real names (like "iPad Pro (WiFi)")
If you keep hard coded values your analytics is going to be a mix of device references and names.
And it's my first Swift lib !
                       DESC

  s.homepage         = 'https://github.com/leverdeterre/JMDynamicDeviceName'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jerome Morissard' => 'morissardj@gmail.com' }
  s.source           = { :git => 'https://github.com/leverdeterre/JMDynamicDeviceName.git', :tag => '0.9.1' }
  # s.social_media_url = 'https://twitter.com/leverdeterre'

  s.ios.deployment_target = '8.0'
  s.source_files = 'JMDynamicDeviceName/Classes/**/*'
  s.resource_bundles = {
    'JMDynamicDeviceName' => ['JMDynamicDeviceName/Assets/*.json']
  }
  s.frameworks = 'UIKit'
end
