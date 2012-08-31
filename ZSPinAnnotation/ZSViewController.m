//
//  ZSViewController.m
//  ZSPinAnnotation
//
//  Created by Nicholas Hubbard on 12/6/11.
//  Copyright (c) 2011 Zed Said Studio. All rights reserved.
//

#import "ZSViewController.h"
#import "ZSPinAnnotation.h"
#import "Annotation.h"

#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

@implementation ZSViewController

@synthesize mapView;

#pragma mark - View lifecycle

/**
 * Rotation Support
 *
 * @version $Revision: 0.1
 */
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}//end


/**
 * View Loaded
 *
 * @version $Revision: 0.1
 */
- (void)viewDidLoad {
    [super viewDidLoad];
	
	// Array
	NSMutableArray *annotationArray = [[[NSMutableArray alloc] init] autorelease];
	
	// Create some annotations
	Annotation *annotation = nil;
	
	annotation = [[Annotation alloc] init];
	annotation.coordinate = CLLocationCoordinate2DMake(45.570, -122.695);
	annotation.color = RGB(13, 0, 182);
	annotation.title = @"Color Annotation";
	[annotationArray addObject:annotation];
	[annotation release];
	
	annotation = [[Annotation alloc] init];
	annotation.coordinate = CLLocationCoordinate2DMake(45.492, -122.798);
	annotation.color = RGB(0, 182, 146);
	annotation.title = @"Color Annotation";
	[annotationArray addObject:annotation];
	[annotation release];
	
	annotation = [[Annotation alloc] init];
	annotation.coordinate = CLLocationCoordinate2DMake(45.524, -122.704);
	annotation.color = RGB(182, 154, 0);
	annotation.title = @"Color Annotation";
	[annotationArray addObject:annotation];
	[annotation release];
	
	annotation = [[Annotation alloc] init];
	annotation.coordinate = CLLocationCoordinate2DMake(45.591, -122.617);
	annotation.color = RGB(88, 88, 88);
	annotation.title = @"Color Annotation";
	[annotationArray addObject:annotation];
	[annotation release];
	
	annotation = [[Annotation alloc] init];
	annotation.coordinate = CLLocationCoordinate2DMake(45.497, -122.634);
	annotation.color = [UIColor redColor];
	annotation.title = @"Color Annotation";
	[annotationArray addObject:annotation];
	[annotation release];
	
	annotation = [[Annotation alloc] init];
	annotation.coordinate = CLLocationCoordinate2DMake(45.553, -122.607);
	annotation.color = [UIColor purpleColor];
	annotation.title = @"Color Annotation";
	[annotationArray addObject:annotation];
	[annotation release];
	
	annotation = [[Annotation alloc] init];
	annotation.coordinate = CLLocationCoordinate2DMake(45.520, -122.618);
	annotation.color = [UIColor greenColor];
	annotation.title = @"Color Annotation";
	[annotationArray addObject:annotation];
	[annotation release];
	
	annotation = [[Annotation alloc] init];
	annotation.coordinate = CLLocationCoordinate2DMake(45.540, -122.618);
	annotation.color = [UIColor magentaColor];
	annotation.title = @"Color Annotation";
	[annotationArray addObject:annotation];
	[annotation release];
	
	// Center map
	self.mapView.visibleMapRect = [self makeMapRectWithAnnotations:annotationArray];
	
	// Add to map
	[self.mapView addAnnotations:annotationArray];
	
}//end


#pragma mark - MapKit

/**
 * Creates a MKMapRect with the provided annotations
 *
 * @version $Revision: 0.1
 */
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
	
}//end


/**
 * Annotation Views
 *
 * @version $Revision: 0.1
 */
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
		pinView.centerOffset=CGPointMake(6.5,-16);
		pinView.calloutOffset = CGPointMake(-11,0);
	}
	
	pinView.canShowCallout = YES;
	
	return pinView;
	
}//end


/**
 * Added Annotation Views
 *
 * @version $Revision: 0.1
 */
- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    
	MKAnnotationView *aV; 
	
    for (aV in views) {
		
        // Don't pin drop if annotation is user location
        if ([aV.annotation isKindOfClass:[MKUserLocation class]]) {
            continue;
        }
		
        // Check if current annotation is inside visible map rect, else go to next one
        MKMapPoint point =  MKMapPointForCoordinate(aV.annotation.coordinate);
        if (!MKMapRectContainsPoint(self.mapView.visibleMapRect, point)) {
            continue;
        }
		
        CGRect endFrame = aV.frame;
		
        // Move annotation out of view
        aV.frame = CGRectMake(aV.frame.origin.x, aV.frame.origin.y - self.view.frame.size.height, aV.frame.size.width, aV.frame.size.height);
		
        // Animate drop
        [UIView animateWithDuration:0.5 delay:0.04*[views indexOfObject:aV] options:UIViewAnimationCurveLinear animations:^{
			
            aV.frame = endFrame;
			
			// Animate squash
        }completion:^(BOOL finished){
            if (finished) {
                [UIView animateWithDuration:0.05 animations:^{
                    aV.transform = CGAffineTransformMakeScale(1.0, 0.8);
					
                }completion:^(BOOL finished){
                    if (finished) {
                        [UIView animateWithDuration:0.1 animations:^{
                            aV.transform = CGAffineTransformIdentity;
                        }];
                    }
                }];
            }
        }];
    }
}//end

#pragma mark - Memory Management

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[mapView release];
	[super dealloc];
}

@end
