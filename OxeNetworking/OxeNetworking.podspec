#
# Be sure to run `pod lib lint OxeNetworking.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'OxeNetworking'
    s.version          = '0.1.9'
    s.summary          = 'OxeNetworking is a Networking layer helper.'

    # This description is used swito generate tags and improve search results.
    #   * Think: What does it do? Why did you write it? What is the focus?
    #   * Try to keep it short, snappy and to the point.
    #   * Write the description between the DESC delimiters below.
    #   * Finally, don't worry about the indent, CocoaPods strips it!

    s.description      = <<-DESC
    TODO: Add long description of the pod here.
    DESC

    s.homepage         = 'https://github.com/adrianodiasx93/OxeNetworking-iOS'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Adriano Dias' => 'adrianodiasx93@gmail.com' }
    s.source           = { :git => 'https://github.com/adrianodiasx93/OxeNetworking-iOS.git', :tag => s.version.to_s }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '11.0'
    s.swift_version = '5.0'

    s.default_subspec = "Core"

    s.subspec "Core" do |ss|
        ss.source_files  = 'OxeNetworking/Sources/Core/**/*'
        ss.ios.source_files = 'Sources/Core/**/*'
        s.dependency 'Moya', '~> 14.0'
        s.dependency 'SwiftyJSON', '~> 5.0'
    end

    s.subspec "Rx" do |ss|
        ss.source_files = "OxeNetworking/Sources/Rx/**/*"
        ss.ios.source_files = "Sources/Rx/**/*"
        ss.dependency "OxeNetworking/Core"
        ss.dependency "RxSwift", "~> 5.0"
    end
end
