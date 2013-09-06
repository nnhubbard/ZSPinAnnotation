Pod::Spec.new do |s|
  s.name         = "ZSPinAnnotation"
  s.version      = "2.0"
  s.platform        = :ios
  s.summary      = "Builds MKMapView Pin Annotations on the fly with any UIColor."
  s.homepage     = "https://github.com/nnhubbard/ZSPinAnnotation"
  s.screenshots  = "http://f.cl.ly/items/1e3K2G3L380s082E2P2u/zspinannotation.png"
  s.author       = { "Nic Hubbard" => "nic@zedsaid.com" }
  s.source       = { :git => "https://github.com/nnhubbard/ZSPinAnnotation.git"}
  s.source_files = 'ZSPinAnnotation/src/*.{h,m}'
  s.frameworks = 'QuartzCore', 'CoreGraphics', 'MapKit', 'CoreImage'
  s.requires_arc = true
end
