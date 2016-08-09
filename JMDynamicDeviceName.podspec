#
# Be sure to run `pod lib lint JMDynamicDeviceName.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JMDynamicDeviceName'
  s.version          = '0.1.0'
  s.summary          = 'A short description of JMDynamicDeviceName.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/leverdeterre/JMDynamicDeviceName'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jerome Morissard' => 'morissardj@gmail.com' }
  s.source           = { :git => 'https://github.com/leverdeterre/JMDynamicDeviceName.git', :tag => '0.1.0' }
  # s.social_media_url = 'https://twitter.com/leverdeterre'

  s.ios.deployment_target = '8.0'

  s.source_files = 'JMDynamicDeviceName/Classes/**/*'
  
  s.resource_bundles = {
    'JMDynamicDeviceName' => ['JMDynamicDeviceName/Assets/*.json']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
end
