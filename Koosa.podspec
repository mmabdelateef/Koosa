Pod::Spec.new do |s|

  s.name         = "Koosa"
  s.version      = "1.0.1"
  s.summary      = "Attributed Role-based Access Control For Swift"

  s.description  = "A simple Attributed Role-based Access Control For Swift"

  s.homepage     = "https://github.com/mmabdelateef/Koosa"

  s.license      = "MIT"



  s.author             = { "mabdellateef" => "mmabdelateef@gmail.com" }
  s.social_media_url   = "https://twitter.com/mmabdellateef"

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/mmabdelateef/Koosa.git", :tag => "1.0.1" }

  s.source_files  = "Koosa", "Koosa/**/*.{h,m,swift}"
  s.swift_version = "4.1"

end