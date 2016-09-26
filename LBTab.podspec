Pod::Spec.new do |s|
s.name         = "LBTab"
s.summary      = "低耦合集成TabBarController,只需要两个数组即可快速搭建主流App框架."
s.version      = '0.0.1'
s.homepage     = "https://github.com/kingly09/LBinTabBarController"
s.license      = { :type => "MIT", :file => "LICENSE" }
s.author       = { "kingly" => "libintm@163.com" }
s.platform     = :ios, "7.0"
s.source       = { :git => "https://github.com/kingly09/LBinTabBarController.git", :tag => s.version.to_s }
s.social_media_url   = "https://github.com/kingly09"
s.source_files = 'LBTab/*.{h,m}'
s.framework    = "UIKit"
s.requires_arc = true
end
