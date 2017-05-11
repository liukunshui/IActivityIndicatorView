
Pod::Spec.new do |s|

    s.name         = "IActivityIndicatorView"
  s.version      = "0.0.1"
  s.summary      = "A short description of IActivityIndicatorView."

 
  s.description  = <<-DESC
                 this project provide all kinds of IActivityIndicatorView for iOS developer 
                   DESC

  s.homepage     = "https://github.com/liukunshui/IActivityIndicatorView"



  s.license      = "MIT"
  
   s.authors            = { "liukunshui" => "272795906@qq.com" }
 
   s.platform     = :ios, "5.0"

 
 

  s.source       = { :git => "https://github.com/liukunshui/IActivityIndicatorView.git", :tag => "#{s.version}" }

  s.source_files  = "Classes", "IActivityIndicator/**/*.{h,m}"
  s.exclude_files = "Classes/ios”

  s.frameworks = "Foundation", "UIKit"

   s.requires_arc = true


end
