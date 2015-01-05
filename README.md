ZSPinAnnotation
=============

Have you ever felt limited by the three Annotation pin colors that Apple provides with MapKit? Have you ever thought it was a pain to have to create custom images in photoshop every time you wanted to change the color?  `ZSPinAnnotation` solves these problems by building the pin annotation on the fly and caching them for performance. All pin annotations use `CoreGraphics` to draw the pins so you get super sharp and beautiful annotations of any color.  `ZSPinAnnotation` is a `MKAnnotationView` subclass, so you can easily use it in your `mapView:viewForAnnotation:` method.

![ZSPinAnnotation](http://f.cl.ly/items/1e3K2G3L380s082E2P2u/zspinannotation.png "ZSPinAnnotation")

How It Works
---

Use a ZSPinAnnotation on a MapView:

```objective-c
- (MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:(id <MKAnnotation>)annotation {
	
    // Don't mess with user location
	if(![annotation isKindOfClass:[ZSAnnotation class]])
        return nil;
    
    ZSAnnotation *a = (ZSAnnotation *)annotation;
    static NSString *defaultPinID = @"StandardIdentifier";
    
    // Create the ZSPinAnnotation object and reuse it
    ZSPinAnnotation *pinView = (ZSPinAnnotation *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
    if (pinView == nil){
        pinView = [[ZSPinAnnotation alloc] initWithAnnotation:annotation reuseIdentifier:defaultPinID];
    }
    
    // Set the type of pin to draw and the color
    pinView.annotationType = ZSPinAnnotationTypeStandard;
    pinView.annotationColor = a.color;
    pinView.canShowCallout = YES;
    
    return pinView;
	
}
```

How to use in your App
---
`ZSPinAnnotation` requires the `QuartzCore.framework`, `CoreImage.framework` and `CoreGraphics.framework`.

Take a look at the demo project in the download for an example of how to use `ZSPinAnnotation`.

Pin Types
---
ZSPinAnnotation provides three different types of pin images: `ZSPinAnnotationTypeStandard`, `ZSPinAnnotationTypeDisc`, `ZSPinAnnotationTypeTag` and `ZSPinAnnotationTypeTagStroke`. The default is `ZSPinAnnotationTypeStandard` which defaults to the color `red`.

![Annotation Types](http://cl.ly/image/3A1P0h2F1h39/types.png "Annotation Types")