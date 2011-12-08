ZSPinAnnotation
=============

Have you ever felt limited by the three Annotation pin colors that Apple provides with MapKit? Have you ever thought it was a pain to have to create custom images in photoshop every time you wanted to change the color?  `ZSPinAnnotation` solves these problems by building the pin image on the fly.  All you have to do is specify a `UIColor` and you get back a `UIImage`.

![ZSPinAnnotation](http://f.cl.ly/items/223W1a0d0s3m3S0h3K37/Screen%20Shot%202011-12-06%20at%203.59.23%20PM.png "ZSPinAnnotation")

How It Works
---

Create a ZSPinAnnotation:

```objective-c
UIImage *img = [ZSPinAnnotation pinAnnotationWithColor:[UIColor blueColor]];
```

Use a ZSPinAnnotation on a MapView:

```objective-c
- (MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:(id <MKAnnotation>)annotation {
	
	if(![annotation isKindOfClass:[Annotation class]]) // Don't mess user location
        return nil;
	
	static NSString *defaultPinID = @"StandardIdentifier";
	MKAnnotationView *pinView = (MKAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
	if (pinView == nil){
		pinView = [[[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:defaultPinID] autorelease];
		//pinView.animatesDrop = YES;
	}
	
	// Build our annotation
	if ([annotation isKindOfClass:[Annotation class]]) {
		Annotation *a = (Annotation *)annotation;
		pinView.image = [ZSPinAnnotation pinAnnotationWithColor:a.color];// ZSPinAnnotation Being Used
		pinView.annotation = a;
		pinView.enabled = YES;
		pinView.calloutOffset = CGPointMake(-11,0);
	}
	
	pinView.canShowCallout = YES;
	
	return pinView;
	
}//end
```

How to use in your App
---
`ZSPinAnnotation` requires the `QuartzCore.framework`.

Take a look at the demo project in the download to see how you can easily use the `UIImages` as `MKMapView` annotation images.

Notes
---

If you would like to help make `ZSPinAnnotation` even better feel free to contribute code or tweaked images.