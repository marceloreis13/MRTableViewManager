#
# Be sure to run `pod lib lint MRTableViewManager.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MRTableViewManager'
  s.version          = '0.1.3'
  s.summary          = 'MRTableViewManager is a nice lib.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
This is a lib to help handle tableviewcontrollers and viewcellcontrollers
                       DESC

  s.homepage         = 'https://github.com/marceloreis13/MRTableViewManager'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Marcelo Reis' => 'marcello@marcelloreis.com' }
  s.source           = { :git => 'https://github.com/marceloreis13/MRTableViewManager.git', :commit  => "cb6d38423a9887da3e00da1b6f4f3636ab4bf332" }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'MRTableViewManager/Classes/**/*'
  
  # s.resource_bundles = {
  #   'MRTableViewManager' => ['MRTableViewManager/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
