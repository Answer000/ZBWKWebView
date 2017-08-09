Pod::Spec.new do |s|
   s.name         = 'ZBWKWebView'
   s.version      = '0.0.2'
   s.license      = { :type => "MIT", :file => "LICENSE" } 
   s.homepage     = 'https://github.com/AnswerXu/ZBWKWebView.git'
   s.author       = { "AnswerXu" => "zhengbo073017@163.com" }
   s.summary      = 'WKWebView自定义头部视图和尾部视图'
   s.platform     = :ios, '8.0'
   s.source       = { :git => 'https://github.com/AnswerXu/ZBWKWebView.git', :tag => s.version.to_s }
   s.source_files = 'ZBWKWebView/ZBWKWebView/*.{h,m}',
   s.frameworks   =  'UIKit'
   s.requires_arc = true
end
