//
//  ZSPinAnnotation.h
//  ZSPinAnnotation
//
//  Created by Nicholas Hubbard on 12/6/11.
//  Copyright (c) 2011 Zed Said Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface ZSPinAnnotation : NSObject

+ (UIImage *)pinAnnotationWithColor:(UIColor *)color;
+ (UIImage *)pinAnnotationWithRed:(int)red green:(int)green blue:(int)blue;

@end
