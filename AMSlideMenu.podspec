Pod::Spec.new do |s|
  s.name          = "AMSlideMenu"
  s.version       = "2.0.2"
  s.swift_version = '5.1'
  s.summary       = "Easy slide menu with high customization for ios"
  s.platform      = :ios, '10.0'
  s.source        = { :git => "https://github.com/arturdev/AMSlideMenu.git", :tag => "2.0.1" }
  s.social_media_url = 'https://www.linkedin.com/in/arturdev/'
  s.description   = <<-DESC
                     This is a simple library to create sliding menus that can be used in storyboards.

With this library you can create 3 types of sliding menus: 
1. Slide menu with right menu only. 
2. Slide menu with left menu only. 
3. Slide menu with both left and right menus. 

This repo contains project that demonstrate a usage of AMSlideMenu.
Works for both iPhone and iPad and macCatalyst.
                    DESC
  s.homepage     = "https://github.com/arturdev/AMSlideMenu"
  s.license      = 'MIT'
  s.author       = { "Artur Mkrtchyan" => "mkrtarturdev@gmail.com" }
  s.source_files = 'AMSlideMenu/**/*.{swift}'
end
