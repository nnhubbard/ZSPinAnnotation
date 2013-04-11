//
//  EndAnnotation.h
//  Ride
//
//  Created by Nicholas Hubbard on 5/2/10.
//  Copyright 2010 Zed Said Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>

@interface Annotation : NSObject <MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, strong) UIColor *color;

// add an init method so you can set the coordinate property on startup
- (id)initWithCoordinate:(CLLocationCoordinate2D)coord;

@end