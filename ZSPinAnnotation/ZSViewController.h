//
//  ZSViewController.h
//  ZSPinAnnotation
//
//  Created by Nicholas Hubbard on 12/6/11.
//  Copyright (c) 2013 Zed Said Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ZSViewController : UIViewController <MKMapViewDelegate>

/// The mapView
@property (nonatomic, strong) IBOutlet MKMapView *mapView;

/**
 * Creates a MKMapRect with the provided annotations
 *
 * @param annotations The annotations that we use to build the map rect
 */
- (MKMapRect)makeMapRectWithAnnotations:(NSArray *)annotations;

@end
