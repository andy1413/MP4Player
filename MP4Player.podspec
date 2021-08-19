#
# Be sure to run `pod lib lint MP4Player.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MP4Player'
  s.version          = '0.1.0'
  s.summary          = 'A short description of MP4Player.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/wangfangshuai/MP4Player'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'wangfangshuai' => 'wangfangshuai@apusapps.com' }
  s.source           = { :git => 'https://github.com/wangfangshuai/MP4Player.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'

  s.source_files = 'MP4Player/Classes/**/*'
  
  s.dependency 'FileDownloadKit'
  
end
