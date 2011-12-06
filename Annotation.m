//
//  EndAnnotation.m
//  Ride
//
//  Created by Nic Hubbard on 6/22/10.
//  Copyright 2010 Zed Said Studio. All rights reserved.
//

#import "Annotation.h"

@implementation Annotation

@synthesize coordinate, title, subtitle, color;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coord {
    coordinate = coord;
	return nil;
}

-(void)dealloc {
	[title release];
	[subtitle release];
	[color release];
	[super dealloc];
}

@end