//
//  ZSViewController.h
//  ZSPinAnnotation
//
//  Created by Nicholas Hubbard on 12/6/11.
//  Copyright (c) 2011 Zed Said Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ZSViewController : UIViewController <MKMapViewDelegate> {
	MKMapView *mapView;
}

@property (nonatomic, retain) IBOutlet MKMapView *mapView;

- (MKMapRect)makeMapRectWithAnnotations:(NSArray *)annotations;

@end
