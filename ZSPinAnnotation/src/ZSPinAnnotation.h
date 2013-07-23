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

typedef enum {
    ZSPinAnnotationTypeStandard,
    ZSPinAnnotationTypeDisc,
    ZSPinAnnotationTypeTag
} ZSPinAnnotationType;

@interface ZSPinAnnotation : NSObject

@property (nonatomic) ZSPinAnnotationType annotationType;

+ (UIImage *)pinAnnotationWithColor:(UIColor *)color;
+ (UIImage *)pinAnnotationWithColor:(UIColor *)color type:(ZSPinAnnotationType)type;
+ (UIImage *)pinAnnotationWithRed:(int)red green:(int)green blue:(int)blue;
+ (UIImage *)pinAnnotationWithRed:(int)red green:(int)green blue:(int)blue type:(ZSPinAnnotationType)type;
+ (UIImage *)pinAnnotationWithHexString:(NSString *)hexString;
+ (UIImage *)pinAnnotationWithHexString:(NSString *)hexString type:(ZSPinAnnotationType)type;

+ (void)setPinAnnotationType:(ZSPinAnnotationType)type;

@end
