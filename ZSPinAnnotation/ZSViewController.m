//
//  ZSViewController.m
//  ZSPinAnnotation
//
//  Created by Nicholas Hubbard on 12/6/11.
//  Copyright (c) 2011 Zed Said Studio. All rights reserved.
//

#import "ZSViewController.h"
#import "ZSPinAnnotation.h"
#import "ZSAnnotation.h"

#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

@implementation ZSViewController

@synthesize mapView;

#pragma mark - View lifecycle


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"ZSPinAnnotation";
	
	// Array
	NSMutableArray *annotationArray = [[NSMutableArray alloc] init];
	
	// Create some annotations
	ZSAnnotation *annotation = nil;
	
	annotation = [[ZSAnnotation alloc] init];
	annotation.coordinate = CLLocationCoordinate2DMake(45.570, -122.695);
	annotation.color = RGB(13, 0, 182);
	annotation.title = @"Color Annotation";
    annotation.type = ZSPinAnnotationTypeTag;
	[annotationArray addObject:annotation];
	
	annotation = [[ZSAnnotation alloc] init];
	annotation.coordinate = CLLocationCoordinate2DMake(45.492, -122.798);
	annotation.color = RGB(0, 182, 146);
    annotation.type = ZSPinAnnotationTypeTag;
	annotation.title = @"Color Annotation";
	[annotationArray addObject:annotation];
	
	annotation = [[ZSAnnotation alloc] init];
	annotation.coordinate = CLLocationCoordinate2DMake(45.524, -122.704);
	annotation.color = RGB(182, 154, 0);
    annotation.type = ZSPinAnnotationTypeTag;
	annotation.title = @"Color Annotation";
	[annotationArray addObject:annotation];
	
	annotation = [[ZSAnnotation alloc] init];
	annotation.coordinate = CLLocationCoordinate2DMake(45.591, -122.617);
	annotation.color = RGB(88, 88, 88);
	annotation.title = @"Color Annotation";
	[annotationArray addObject:annotation];
	
	annotation = [[ZSAnnotation alloc] init];
	annotation.coordinate = CLLocationCoordinate2DMake(45.497, -122.634);
	annotation.color = [UIColor redColor];
	annotation.title = @"Color Annotation";
	[annotationArray addObject:annotation];
	
	annotation = [[ZSAnnotation alloc] init];
	annotation.coordinate = CLLocationCoordinate2DMake(45.553, -122.607);
	annotation.color = [UIColor purpleColor];
	annotation.title = @"Color Annotation";
	[annotationArray addObject:annotation];
	
	annotation = [[ZSAnnotation alloc] init];
	annotation.coordinate = CLLocationCoordinate2DMake(45.520, -122.618);
	annotation.color = [UIColor greenColor];
	annotation.title = @"Color Annotation";
	[annotationArray addObject:annotation];
	
	annotation = [[ZSAnnotation alloc] init];
	annotation.coordinate = CLLocationCoordinate2DMake(45.540, -122.618);
	annotation.color = [UIColor magentaColor];
	annotation.title = @"Color Annotation";
	[annotationArray addObject:annotation];
    
    annotation = [[ZSAnnotation alloc] init];
	annotation.coordinate = CLLocationCoordinate2DMake(45.5490, -122.7382);
	annotation.color = [UIColor blueColor];
	annotation.title = @"Color Annotation";
	[annotationArray addObject:annotation];
    
    annotation = [[ZSAnnotation alloc] init];
	annotation.coordinate = CLLocationCoordinate2DMake(45.5745, -122.7173);
	annotation.color = [UIColor whiteColor];
	annotation.title = @"Color Annotation";
	[annotationArray addObject:annotation];
    
    annotation = [[ZSAnnotation alloc] init];
	annotation.coordinate = CLLocationCoordinate2DMake(45.5383, -122.7302);
	annotation.color = [UIColor blueColor];
	annotation.title = @"Color Annotation";
	[annotationArray addObject:annotation];
	
	// Center map
	self.mapView.visibleMapRect = [self makeMapRectWithAnnotations:annotationArray];
	
	// Add to map
	[self.mapView addAnnotations:annotationArray];
	
}


#pragma mark - MapKit

- (MKMapRect)makeMapRectWithAnnotations:(NSArray *)annotations {
	
	MKMapRect flyTo = MKMapRectNull;
    for (id <MKAnnotation> annotation in annotations) {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
        if (MKMapRectIsNull(flyTo)) {
            flyTo = pointRect;
        } else {
            flyTo = MKMapRectUnion(flyTo, pointRect);
        }
    }
	
	return flyTo;
	
}


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
    pinView.annotationType = ZSPinAnnotationTypeTagStroke;
    pinView.annotationColor = a.color;
    pinView.canShowCallout = YES;
    
    return pinView;
	
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
