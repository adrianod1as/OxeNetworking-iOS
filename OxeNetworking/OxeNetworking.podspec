#
# Be sure to run `pod lib lint OxeNetworking.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'OxeNetworking'
    s.version          = '0.1.5'
    s.summary          = 'OxeNetworking is a Networking layer helper.'

    # This description is used swito generate tags and improve search results.
    #   * Think: What does it do? Why did you write it? What is the focus?
    #   * Try to keep it short, snappy and to the point.
    #   * Write the description between the DESC delimiters below.
    #   * Finally, don't worry about the indent, CocoaPods strips it!

    s.description      = <<-DESC
    TODO: Add long description of the pod here.
    DESC

    s.homepage         = 'https://bitbucket.org/ioasys/oxe-networking-ios/src/master/'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Adriano Dias' => 'adrianodiasx93@gmail.com' }
    s.source           = { :git => 'git@bitbucket.org:ioasys/oxe-networking-ios.git', :tag => s.version.to_s }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '11.0'
    s.swift_version = '5.0'

    s.source_files = 'OxeNetworking/OxeNetworking/Classes/**/*'
    s.ios.source_files = 'OxeNetworking/Classes/**/*'
    # s.resource_bundles = {
    #   'OxeNetworking' => ['OxeNetworking/Assets/*.png']
    # }

    # s.public_header_files = 'Pod/Classes/**/*.h'
    # s.frameworks = 'UIKit', 'MapKit'
    s.dependency 'Moya', '~> 14.0'
    s.dependency 'SwiftyJSON', '~> 5.0'
    s.dependency 'Result', '~> 5.0'
end
