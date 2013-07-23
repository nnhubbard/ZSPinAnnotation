ZSPinAnnotation
=============

Have you ever felt limited by the three Annotation pin colors that Apple provides with MapKit? Have you ever thought it was a pain to have to create custom images in photoshop every time you wanted to change the color?  `ZSPinAnnotation` solves these problems by building the pin annotation on the fly and caching them for performance. All pin annotations use `CoreGraphics` to draw the pin images so you get super sharp and beautiful annotation sof any color.  All you have to do is specify a `UIColor` and you get back a `UIImage` to be used in `mapView:viewForAnnotation:`.

![ZSPinAnnotation](http://f.cl.ly/items/1e3K2G3L380s082E2P2u/zspinannotation.png "ZSPinAnnotation")

How It Works
---

Create a ZSPinAnnotation:

```objective-c
UIImage *img = [ZSPinAnnotation pinAnnotationWithColor:[UIColor blueColor]];
```

Use a ZSPinAnnotation on a MapView:

```objective-c
- (MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:(id <MKAnnotation>)annotation {
	
	if(![annotation isKindOfClass:[ZSAnnotation class]]) // Don't mess user location
        return nil;
    
    ZSAnnotation *a = (ZSAnnotation *)annotation;
	
	static NSString *defaultPinID = @"StandardIdentifier";
	MKAnnotationView *pinView = (MKAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
	if (pinView == nil){
		pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:defaultPinID];
	}
	
	// Build our annotation
	if ([annotation isKindOfClass:[ZSAnnotation class]]) {
        
		pinView.image = [ZSPinAnnotation pinAnnotationWithColor:a.color type:a.type];// ZSPinAnnotation Being Used
		pinView.annotation = a;
		pinView.enabled = YES;
        pinView.canShowCallout = YES;
        
        // Offset to correct placement
        pinView.centerOffset = CGPointMake(16, -12);
        pinView.calloutOffset = CGPointMake(-16, 0);
        
	}//end
	
	return pinView;
	
}
```

How to use in your App
---
`ZSPinAnnotation` requires the `QuartzCore.framework`, `CoreImage.framework` and `CoreGraphics.framework`.

Take a look at the demo project in the download to see how you can easily use the `UIImages` as `MKMapView` annotation images.

Pin Types
---
ZSPinAnnotation provides three different types of pin images: `ZSPinAnnotationTypeStandard`, `ZSPinAnnotationTypeDisc` and `ZSPinAnnotationTypeTag`. The default is `ZSPinAnnotationTypeStandard`.

You can set the `ZSPinAnnotationType` using the following method:

```objective-c
[ZSPinAnnotation setPinAnnotationType:ZSPinAnnotationTypeStandard];
```

Different Methods of Pin Creation
---
You can use the following methods to create a pin image with the color of your choice:

```objective-c
+ (UIImage *)pinAnnotationWithColor:(UIColor *)color;
+ (UIImage *)pinAnnotationWithColor:(UIColor *)color type:(ZSPinAnnotationType)type;
+ (UIImage *)pinAnnotationWithRed:(int)red green:(int)green blue:(int)blue;
+ (UIImage *)pinAnnotationWithRed:(int)red green:(int)green blue:(int)blue type:(ZSPinAnnotationType)type;
+ (UIImage *)pinAnnotationWithHexString:(NSString *)hexString;
+ (UIImage *)pinAnnotationWithHexString:(NSString *)hexString type:(ZSPinAnnotationType)type;
```

Offsetting Pin For Correct Placement
---
Because of the way annotations are added to the `MKMapView` we need to offset the `ZSPinAnnotation` so that it will be placed correctly. In your `mapView:viewForAnnotation:` method make sure to add:
```objective-c
pinView.centerOffset = CGPointMake(16, -12);
pinView.calloutOffset = CGPointMake(-16, 0);
```

__Note:__ These offset have been adjusted for `ZSPinAnnotationTypeStandard` only.
