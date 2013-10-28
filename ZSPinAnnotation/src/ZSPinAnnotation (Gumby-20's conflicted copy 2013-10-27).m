//
//  ZSPinAnnotation.m
//  ZSPinAnnotation
//
//  Created by Nicholas Hubbard on 12/6/11.
//  Copyright (c) 2011 Zed Said Studio. All rights reserved.
//

#import "ZSPinAnnotation.h"

@interface ZSPinAnnotation ()
@property (nonatomic, strong) NSCache *imageCache;
+ (id)sharedCache;
@end

@implementation ZSPinAnnotation

/**
 * Singleton to handle caching of images
 *
 * @version $Revision: 0.1
 */
+ (id)sharedCache {
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}//end


/**
 * Init
 *
 * @version $Revision: 0.1
 */
- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) {
        
        // Offset to correct placement
        self.centerOffset = CGPointMake(16, -12);
        self.calloutOffset = CGPointMake(-16, 0);
        self.annotationColor = [UIColor redColor];
        self.annotationType = ZSPinAnnotationTypeStandard;// Set a default for the user
    }
    return self;
}


#pragma mark - Setters

/**
 * Set the annotation color
 *
 * @version $Revision: 0.1
 */
- (void)setAnnotationColor:(UIColor *)annotationColor {
    self.image = [self pinAnnotationWithColor:annotationColor];
}//end


#pragma mark - Drawing

/**
 * Draw the pin
 *
 * @version $Revision: 0.1
 */
- (UIImage *)pinAnnotationWithColor:(UIColor *)color {
    
    // Shared object
    ZSPinAnnotation *pn = [ZSPinAnnotation sharedCache];
    ZSPinAnnotationType type = self.annotationType;
    
    // Color String
    CGColorRef colorRef = color.CGColor;
    NSString *colorString = [[CIColor colorWithCGColor:colorRef].stringRepresentation stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    // Type Name
    NSString *typeName = @"";
    if (type == ZSPinAnnotationTypeStandard) {
        typeName = @"_standard";
    } else if (type == ZSPinAnnotationTypeDisc) {
        typeName = @"_disc";
    } else if (type == ZSPinAnnotationTypeTag) {
        typeName = @"_tag";
    }
    
    colorString = [colorString stringByAppendingString:typeName];
    
    // Caching
    if (!pn.imageCache) pn.imageCache = [[NSCache alloc] init];
    if ([pn.imageCache objectForKey:colorString]) {
        return [pn.imageCache objectForKey:colorString];
    }
    
    // What type of pin are we drawing?
    if (type == ZSPinAnnotationTypeStandard) {
        
        CGSize size = CGSizeMake(50, 50);
        UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
        
        //// General Declarations
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        //// Color Declarations
        UIColor* fillColor = color;
        UIColor* strokeColor = [self darkerColorForColor:color];
        UIColor* shadowColor2 = [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 0.221];
        UIColor* color2 = [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 0];
        UIColor* color5 = [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 0.141];
        UIColor* buttonColor = [UIColor colorWithRed: 0 green: 0.272 blue: 0.883 alpha: 1];
        CGFloat buttonColorRGBA[4];
        [buttonColor getRed: &buttonColorRGBA[0] green: &buttonColorRGBA[1] blue: &buttonColorRGBA[2] alpha: &buttonColorRGBA[3]];
        
        UIColor* buttonBottomColor = [UIColor colorWithRed: (buttonColorRGBA[0] * 0 + 1) green: (buttonColorRGBA[1] * 0 + 1) blue: (buttonColorRGBA[2] * 0 + 1) alpha: (buttonColorRGBA[3] * 0 + 1)];
        UIColor* strokeColor2 = [UIColor colorWithRed: 0.792 green: 0.804 blue: 0.82 alpha: 1];
        UIColor* color6 = [UIColor colorWithRed: 0.455 green: 0.459 blue: 0.467 alpha: 1];
        UIColor* color7 = [UIColor colorWithRed: 0.635 green: 0.651 blue: 0.667 alpha: 1];
        UIColor* gradientColor = [UIColor colorWithRed: 0.635 green: 0.651 blue: 0.667 alpha: 1];
        UIColor* color8 = [UIColor colorWithRed: 0.412 green: 0.42 blue: 0.431 alpha: 1];
        UIColor* stickGradiantColor = [fillColor colorWithAlphaComponent:0.309];
        UIColor* bottomCircle = [UIColor colorWithRed: 0.359 green: 0.359 blue: 0.359 alpha: 1];
        UIColor* fillColor2 = [UIColor colorWithRed: 0.5 green: 0.5 blue: 0.5 alpha: 1];
        UIColor* color9 = [UIColor colorWithRed: 0.001 green: 0.001 blue: 0.001 alpha: 0.511];
        
        //// Gradient Declarations
        NSArray* buttonGradientColors = [NSArray arrayWithObjects:
                                         (id)buttonBottomColor.CGColor,
                                         (id)fillColor.CGColor, nil];
        CGFloat buttonGradientLocations[] = {0, 0.31};
        CGGradientRef buttonGradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)buttonGradientColors, buttonGradientLocations);
        NSArray* stickGradientColors = [NSArray arrayWithObjects:
                                        (id)color8.CGColor,
                                        (id)[UIColor colorWithRed: 0.524 green: 0.535 blue: 0.549 alpha: 1].CGColor,
                                        (id)gradientColor.CGColor,
                                        (id)[UIColor colorWithRed: 0.714 green: 0.727 blue: 0.743 alpha: 1].CGColor,
                                        (id)strokeColor2.CGColor,
                                        (id)[UIColor colorWithRed: 0.714 green: 0.727 blue: 0.743 alpha: 1].CGColor,
                                        (id)color7.CGColor,
                                        (id)[UIColor colorWithRed: 0.545 green: 0.555 blue: 0.567 alpha: 1].CGColor,
                                        (id)color6.CGColor, nil];
        CGFloat stickGradientLocations[] = {0.16, 0.24, 0.31, 0.39, 0.5, 0.59, 0.69, 0.81, 0.89};
        CGGradientRef stickGradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)stickGradientColors, stickGradientLocations);
        NSArray* vertStickGradientColors = [NSArray arrayWithObjects:
                                            (id)stickGradiantColor.CGColor,
                                            (id)[fillColor colorWithAlphaComponent:0.154].CGColor,
                                            (id)color2.CGColor,
                                            (id)[UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 0.07].CGColor,
                                            (id)color5.CGColor, nil];
        CGFloat vertStickGradientLocations[] = {0, 0.13, 0.3, 0.65, 1};
        CGGradientRef vertStickGradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)vertStickGradientColors, vertStickGradientLocations);
        
        //// Shadow Declarations
        UIColor* shadow2 = shadowColor2;
        CGSize shadow2Offset = CGSizeMake(-4.1, -2.1);
        CGFloat shadow2BlurRadius = 5;
        UIColor* pinGroupShadowColor = color9;
        CGSize pinGroupShadowColorOffset = CGSizeMake(53.1, 6.1);
        CGFloat pinGroupShadowColorBlurRadius = 5;
        
        //// ZSSAnnotation Pin
        {
            //// Below Pin Circle Drawing
            UIBezierPath* belowPinCirclePath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(6.5, 37.5, 5, 2.5)];
            [bottomCircle setFill];
            [belowPinCirclePath fill];
            
            
            //// Main Pin Stick Drawing
            UIBezierPath* mainPinStickPath = [UIBezierPath bezierPathWithRect: CGRectMake(7.5, 16, 3, 23)];
            CGContextSaveGState(context);
            [mainPinStickPath addClip];
            CGContextDrawLinearGradient(context, stickGradient, CGPointMake(10.5, 27.5), CGPointMake(7.5, 27.5), 0);
            CGContextRestoreGState(context);
            
            
            //// Pin Ball Drawing
            UIBezierPath* pinBallPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(1, 1, 15.5, 15.5)];
            CGContextSaveGState(context);
            [pinBallPath addClip];
            CGContextDrawRadialGradient(context, buttonGradient,
                                        CGPointMake(6.47, 5.59), 0.42,
                                        CGPointMake(8.75, 8.75), 8.35,
                                        kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
            CGContextRestoreGState(context);
            
            ////// Pin Ball Inner Shadow
            CGRect pinBallBorderRect = CGRectInset([pinBallPath bounds], -shadow2BlurRadius, -shadow2BlurRadius);
            pinBallBorderRect = CGRectOffset(pinBallBorderRect, -shadow2Offset.width, -shadow2Offset.height);
            pinBallBorderRect = CGRectInset(CGRectUnion(pinBallBorderRect, [pinBallPath bounds]), -1, -1);
            
            UIBezierPath* pinBallNegativePath = [UIBezierPath bezierPathWithRect: pinBallBorderRect];
            [pinBallNegativePath appendPath: pinBallPath];
            pinBallNegativePath.usesEvenOddFillRule = YES;
            
            CGContextSaveGState(context);
            {
                CGFloat xOffset = shadow2Offset.width + round(pinBallBorderRect.size.width);
                CGFloat yOffset = shadow2Offset.height;
                CGContextSetShadowWithColor(context,
                                            CGSizeMake(xOffset + copysign(0.1, xOffset), yOffset + copysign(0.1, yOffset)),
                                            shadow2BlurRadius,
                                            shadow2.CGColor);
                
                [pinBallPath addClip];
                CGAffineTransform transform = CGAffineTransformMakeTranslation(-round(pinBallBorderRect.size.width), 0);
                [pinBallNegativePath applyTransform: transform];
                [[UIColor grayColor] setFill];
                [pinBallNegativePath fill];
            }
            CGContextRestoreGState(context);
            
            [strokeColor setStroke];
            pinBallPath.lineWidth = 0.5;
            [pinBallPath stroke];
            
            
            //// Pin Gradiant Overlay Drawing
            UIBezierPath* pinGradiantOverlayPath = [UIBezierPath bezierPathWithRect: CGRectMake(7.5, 16, 3, 23)];
            CGContextSaveGState(context);
            [pinGradiantOverlayPath addClip];
            CGContextDrawLinearGradient(context, vertStickGradient, CGPointMake(9, 16), CGPointMake(9, 39), 0);
            CGContextRestoreGState(context);
        }
        
        //// Pin Group Shadow Drawing
        UIBezierPath* pinGroupShadowPath = [UIBezierPath bezierPath];
        [pinGroupShadowPath moveToPoint: CGPointMake(-43, 32)];
        [pinGroupShadowPath addLineToPoint: CGPointMake(-40, 32)];
        [pinGroupShadowPath addLineToPoint: CGPointMake(-29.64, 20.2)];
        [pinGroupShadowPath addCurveToPoint: CGPointMake(-19.59, 15.35) controlPoint1: CGPointMake(-29.64, 20.2) controlPoint2: CGPointMake(-21.49, 20)];
        [pinGroupShadowPath addCurveToPoint: CGPointMake(-29.64, 10) controlPoint1: CGPointMake(-17.69, 10.7) controlPoint2: CGPointMake(-25.36, 9.25)];
        [pinGroupShadowPath addCurveToPoint: CGPointMake(-37.11, 15.35) controlPoint1: CGPointMake(-33.92, 10.75) controlPoint2: CGPointMake(-37.18, 11.91)];
        [pinGroupShadowPath addCurveToPoint: CGPointMake(-32.72, 19.47) controlPoint1: CGPointMake(-37.03, 18.79) controlPoint2: CGPointMake(-32.72, 19.47)];
        [pinGroupShadowPath addLineToPoint: CGPointMake(-43, 32)];
        [pinGroupShadowPath closePath];
        pinGroupShadowPath.lineJoinStyle = kCGLineJoinRound;
        
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, pinGroupShadowColorOffset, pinGroupShadowColorBlurRadius, pinGroupShadowColor.CGColor);
        [fillColor2 setFill];
        [pinGroupShadowPath fill];
        CGContextRestoreGState(context);
        
        //// Cleanup
        CGGradientRelease(buttonGradient);
        CGGradientRelease(stickGradient);
        CGGradientRelease(vertStickGradient);
        CGColorSpaceRelease(colorSpace);
        
        // Draw the image
        UIImage* result = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        // Save to cache
        [pn.imageCache setObject:result forKey:colorString];
        
        //return the image
        return result;
        
    } else if (type == ZSPinAnnotationTypeDisc) {
        
        CGSize size = CGSizeMake(50, 50);
        UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
        
        //// General Declarations
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        //// Color Declarations
        UIColor* fillColor = color;
        UIColor* strokeColor = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
        UIColor* shadowColor2 = [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 1];
        
        //// Shadow Declarations
        UIColor* shadow = shadowColor2;
        CGSize shadowOffset = CGSizeMake(0.1, 1.1);
        CGFloat shadowBlurRadius = 12;
        UIColor* shadow2 = shadowColor2;
        CGSize shadow2Offset = CGSizeMake(0.1, -0.1);
        CGFloat shadow2BlurRadius = 8.5;
        
        //// Oval 2 Drawing
        UIBezierPath* oval2Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(16, 12, 22.5, 22.5)];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
        [fillColor setFill];
        [oval2Path fill];
        
        ////// Oval 2 Inner Shadow
        CGRect oval2BorderRect = CGRectInset([oval2Path bounds], -shadow2BlurRadius, -shadow2BlurRadius);
        oval2BorderRect = CGRectOffset(oval2BorderRect, -shadow2Offset.width, -shadow2Offset.height);
        oval2BorderRect = CGRectInset(CGRectUnion(oval2BorderRect, [oval2Path bounds]), -1, -1);
        
        UIBezierPath* oval2NegativePath = [UIBezierPath bezierPathWithRect: oval2BorderRect];
        [oval2NegativePath appendPath: oval2Path];
        oval2NegativePath.usesEvenOddFillRule = YES;
        
        CGContextSaveGState(context);
        {
            CGFloat xOffset = shadow2Offset.width + round(oval2BorderRect.size.width);
            CGFloat yOffset = shadow2Offset.height;
            CGContextSetShadowWithColor(context,
                                        CGSizeMake(xOffset + copysign(0.1, xOffset), yOffset + copysign(0.1, yOffset)),
                                        shadow2BlurRadius,
                                        shadow2.CGColor);
            
            [oval2Path addClip];
            CGAffineTransform transform = CGAffineTransformMakeTranslation(-round(oval2BorderRect.size.width), 0);
            [oval2NegativePath applyTransform: transform];
            [[UIColor grayColor] setFill];
            [oval2NegativePath fill];
        }
        CGContextRestoreGState(context);
        
        CGContextRestoreGState(context);
        
        [strokeColor setStroke];
        oval2Path.lineWidth = 2.5;
        [oval2Path stroke];
        
        
        
        UIImage* result = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        // Save to cache
        [pn.imageCache setObject:result forKey:colorString];
        
        //return the image
        return result;
        
    }  else if (type == ZSPinAnnotationTypeTag) {
        
        CGSize size = CGSizeMake(50, 50);
        UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
        
        //// General Declarations
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        //// Color Declarations
        UIColor* fillColor = color;
        
        //// Tag Drawing
        UIBezierPath* tagPath = [UIBezierPath bezierPath];
        [tagPath moveToPoint: CGPointMake(11.76, 18.38)];
        [tagPath addCurveToPoint: CGPointMake(11.76, 9.81) controlPoint1: CGPointMake(9.41, 16.01) controlPoint2: CGPointMake(9.41, 12.17)];
        [tagPath addCurveToPoint: CGPointMake(20.24, 9.81) controlPoint1: CGPointMake(14.1, 7.44) controlPoint2: CGPointMake(17.9, 7.44)];
        [tagPath addCurveToPoint: CGPointMake(20.24, 18.38) controlPoint1: CGPointMake(22.59, 12.17) controlPoint2: CGPointMake(22.59, 16.01)];
        [tagPath addCurveToPoint: CGPointMake(11.76, 18.38) controlPoint1: CGPointMake(17.9, 20.74) controlPoint2: CGPointMake(14.1, 20.74)];
        [tagPath closePath];
        [tagPath moveToPoint: CGPointMake(16, 39.5)];
        [tagPath addCurveToPoint: CGPointMake(26, 14.6) controlPoint1: CGPointMake(15.99, 39.51) controlPoint2: CGPointMake(26, 20.17)];
        [tagPath addCurveToPoint: CGPointMake(16, 4.5) controlPoint1: CGPointMake(26, 9.02) controlPoint2: CGPointMake(21.52, 4.5)];
        [tagPath addCurveToPoint: CGPointMake(6, 14.6) controlPoint1: CGPointMake(10.48, 4.5) controlPoint2: CGPointMake(6, 9.02)];
        [tagPath addCurveToPoint: CGPointMake(16, 39.5) controlPoint1: CGPointMake(6, 20.17) controlPoint2: CGPointMake(16, 39.5)];
        [tagPath addLineToPoint: CGPointMake(16, 39.5)];
        [tagPath closePath];
        [fillColor setFill];
        [tagPath fill];
        
        UIImage* result = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        // Save to cache
        [pn.imageCache setObject:result forKey:colorString];
        
        //return the image
        return result;
        
    }
    
    return nil;
	
}//end


/**
 * Returns a darker variant of the provided color
 *
 * @version $Revision: 0.1
 */
- (UIColor *)darkerColorForColor:(UIColor *)c {
    
    float r, g, b, a;
    if ([c getRed:&r green:&g blue:&b alpha:&a])
        return [UIColor colorWithRed:MAX(r - 0.2, 0.0)
                               green:MAX(g - 0.2, 0.0)
                                blue:MAX(b - 0.2, 0.0)
                               alpha:a];
    return c;
    
}//end

@end
