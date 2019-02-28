#
# Be sure to run `pod lib lint BarcodeEasyScan.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BarcodeEasyScan'
  s.version          = '0.2.0'
  s.summary          = 'Scan barcode and QR code with few lines of swift. No xib or storyboards'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'Scan your barcode by implementing a delegate which provides the string result. No need to write boilerplate codes. Just install the pod, and implement a delegate.'

  s.homepage         = 'https://github.com/harshalrj25/BarcodeEasyScan'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'harshalrj25' => 'harshalrj25@gmail.com' }
  s.source           = { :git => 'https://github.com/harshalrj25/BarcodeEasyScan.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.swift_version = '4.2'
  s.ios.deployment_target = '10.0'

  s.source_files = 'BarcodeEasyScan/Classes/**/*'
  
  # s.resource_bundles = {
  #   'BarcodeEasyScan' => ['BarcodeEasyScan/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
