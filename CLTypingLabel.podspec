#
# Be sure to run `pod lib lint CLTypingLabel.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "CLTypingLabel"
  s.version          = "0.3.0"
  s.summary          = "UILabel with character by character typing animation in swift iOS/OSX"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = "iOS/OSX UILabel with character by character typewriter like animation"

  s.homepage         = "https://github.com/l800891/CLTypingLabel"
  # s.screenshots     = "https://raw.githubusercontent.com/l800891/CLTypingLabel/master/Files/demogiff.gif"
  s.license          = 'MIT'
  s.author           = { "Chenglin" => "l800891@me.com" }
  s.source           = { :git => "https://github.com/l800891/CLTypingLabel.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '9.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/*'


end
