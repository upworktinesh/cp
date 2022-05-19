#
# Be sure to run `pod lib lint cp.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'cp'
  s.version          = '0.1.3'
  s.summary          = 'This pod is developed to demostrate a POC.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
    This pod is just a POC of a concept. latter it will be refectered to use publically.
                       DESC

  s.homepage         = 'https://github.com/upworktinesh/cp'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'upworktinesh' => 'upworktinesh@gmail.com' }
  s.source           = { :git => 'https://github.com/upworktinesh/cp.git', :tag => s.version.to_s }
 

  # s.ios.deployment_target = :ios ,'12.0'
  s.platform = :ios, '9'
  s.swift_versions = '4'
  
  s.source_files = 'cp/Classes/**/*'
  
  # s.resource_bundles = {
  #   'cp' => ['cp/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'ObjectMapper', '~> 3.5'
  s.dependency 'Alamofire', '~> 4.4'
#  s.dependency 'PromiseKit', '4.0'
  s.dependency 'SwiftyJSON'
end
