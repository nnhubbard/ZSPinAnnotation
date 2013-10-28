//
//  ZSPinAnnotation.h
//  ZSPinAnnotation
//
//  Created by Nicholas Hubbard on 12/6/11.
//  Copyright (c) 2013 Zed Said Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreImage/CoreImage.h>
#import <MapKit/MapKit.h>

typedef enum {
    ZSPinAnnotationTypeStandard,
    ZSPinAnnotationTypeDisc,
    ZSPinAnnotationTypeTag
} ZSPinAnnotationType;

@interface ZSPinAnnotation : MKAnnotationView

/// The annotation type to draw
@property (nonatomic) ZSPinAnnotationType annotationType;

/// The color to draw the annotation
@property (nonatomic, strong) UIColor *annotationColor;

@end
