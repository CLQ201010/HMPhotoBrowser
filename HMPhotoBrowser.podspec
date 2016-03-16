Pod::Spec.new do |s|
  s.name         = "HMPhotoBrowser"
  s.version      = "1.0.6"
  s.summary      = "轻量级图片浏览器"
  s.homepage     = "https://github.com/itheima-developer/HMPhotoBrowser"
  s.license      = "MIT"
  s.author       =  { "Fan Liu" => "liufan321@gamil.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/itheima-developer/HMPhotoBrowser.git", :tag => "#{s.version}" }
  s.source_files  = "HMPhotoBrowser/PhotoBrowser/*.{h,m}"
  s.requires_arc = true
  s.dependency "YYWebImage"
end
