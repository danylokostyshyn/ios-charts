Pod::Spec.new do |s|
  s.name = "Charts-MTP-Extended"
  s.version = "3.1.3"
  s.summary          = 'MTP extension of Daniel Cohen Gindi\'s ios-charts'
# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description      = <<-DESC
MTP extension adds support for Current Price Line in Candle charts, even/odd chart background colors and Area bands.
                       DESC
  s.homepage = "https://github.com/MobileTradingPartnersLLP/ios-charts"
  s.license          = 'PROPRIETARY'
  s.author           = { "Romano Bayol" => "romano@socialmobiletrading.com" }
  s.ios.deployment_target = "8.0"
  s.source = { :git => "https://github.com/MobileTradingPartnersLLP/ios-charts", :tag => "mtp.#{s.version.to_s}" }
  s.default_subspec = "Core"
  s.swift_version = '4.2'
  s.cocoapods_version = '>= 1.5.0'

  s.subspec "Core" do |ss|
    ss.source_files  = "Source/Charts/**/*.swift"
  end
end
