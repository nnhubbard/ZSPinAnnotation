Pod::Spec.new do |s|
  s.name         = "ZSPinAnnotation"
  s.version      = "1.5"
  s.summary      = "ZSPinAnnotation allows you to build custom MKMapView pin annotations from any UIColor."
  s.homepage     = "http://www.zedsaid.com"
  s.license      = 'MIT (example)'
  s.author       = { "Nic Hubbard" => "nic@zedsaid.com" }
  s.source       = { :git => "https://github.com/nnhubbard/ZSPinAnnotation.git", :tag => "1.5"}
  s.frameworks = 'QuartzCore', 'CoreImage', 'CoreGraphics'
  s.requires_arc = true
end
