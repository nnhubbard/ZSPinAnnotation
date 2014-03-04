//
//  ZSPinAnnotation.m
//  ZSPinAnnotation
//
//  Created by Nicholas Hubbard on 12/6/11.
//  Copyright (c) 2013 Zed Said Studio. All rights reserved.
//

#import "ZSPinAnnotation.h"

@interface ZSPinAnnotation ()
@property (nonatomic, strong) NSCache *imageCache;
+ (id)sharedCache;
@end

#define iOS7orLater ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

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
        // Defaults
        self.annotationColor = [UIColor redColor];
        self.annotationType = ZSPinAnnotationTypeStandard;
        
        //Correct position of callout accessory view
        self.calloutOffset = CGPointMake(1, 10);
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
        
        CGSize size = CGSizeMake(102, 94);
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
        CGFloat buttonGradientLocations[] = {0, iOS7orLater ? 0 : 0.31};
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
                                            (id)[UIColor colorWithRed: 0.5 green: 0 blue: 0 alpha: 0.154].CGColor,
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
        CGSize pinGroupShadowColorOffset = CGSizeMake(87.1, 6.1);
        CGFloat pinGroupShadowColorBlurRadius = 5;
        
        //// Full Pin
        {
            //// ZSSAnnotation Pin
            {
                //// Below Pin Circle Drawing
                UIBezierPath* belowPinCirclePath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(49.5, 46.5, 5, 2.5)];
                [bottomCircle setFill];
                [belowPinCirclePath fill];
                
                
                //// Main Pin Stick Drawing
                UIBezierPath* mainPinStickPath = [UIBezierPath bezierPathWithRect: CGRectMake(50.5, 25, 3, 23)];
                CGContextSaveGState(context);
                [mainPinStickPath addClip];
                CGContextDrawLinearGradient(context, stickGradient, CGPointMake(53.5, 36.5), CGPointMake(50.5, 36.5), 0);
                CGContextRestoreGState(context);
                
                
                //// Pin Ball Drawing
                UIBezierPath* pinBallPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(44, 10, 15.5, 15.5)];
                CGContextSaveGState(context);
                [pinBallPath addClip];
                CGContextDrawRadialGradient(context, buttonGradient,
                                            CGPointMake(49.47, 14.59), 0.42,
                                            CGPointMake(51.75, 17.75), 8.35,
                                            kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
                CGContextRestoreGState(context);
                
                if(iOS7orLater)
                {
                    UIBezierPath* whitePinGlance = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(47, 13, 3.5, 3.5)];
                    [[UIColor whiteColor] setFill];
                    [whitePinGlance fill];
                    
                    [[UIColor whiteColor] setStroke];
                    pinBallPath.lineWidth = 0.1;
                    [pinBallPath stroke];
                }
                
                ////// Pin Ball Inner Shadow
                if(!iOS7orLater)
                {
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
                    UIBezierPath* pinGradiantOverlayPath = [UIBezierPath bezierPathWithRect: CGRectMake(50.5, 25, 3, 23)];
                    CGContextSaveGState(context);
                    [pinGradiantOverlayPath addClip];
                    CGContextDrawLinearGradient(context, vertStickGradient, CGPointMake(52, 25), CGPointMake(52, 48), 0);
                    CGContextRestoreGState(context);
                }
            }
            
            
            //// Pin Group Shadow Drawing
            UIBezierPath* pinGroupShadowPath = [UIBezierPath bezierPath];
            [pinGroupShadowPath moveToPoint: CGPointMake(-36, 41)];
            [pinGroupShadowPath addLineToPoint: CGPointMake(-33, 41)];
            [pinGroupShadowPath addLineToPoint: CGPointMake(-22.64, 29.2)];
            [pinGroupShadowPath addCurveToPoint: CGPointMake(-12.59, 24.35) controlPoint1: CGPointMake(-22.64, 29.2) controlPoint2: CGPointMake(-14.49, 29)];
            [pinGroupShadowPath addCurveToPoint: CGPointMake(-22.64, 19) controlPoint1: CGPointMake(-10.69, 19.7) controlPoint2: CGPointMake(-18.36, 18.25)];
            [pinGroupShadowPath addCurveToPoint: CGPointMake(-30.11, 24.35) controlPoint1: CGPointMake(-26.92, 19.75) controlPoint2: CGPointMake(-30.18, 20.91)];
            [pinGroupShadowPath addCurveToPoint: CGPointMake(-25.72, 28.47) controlPoint1: CGPointMake(-30.03, 27.79) controlPoint2: CGPointMake(-25.72, 28.47)];
            [pinGroupShadowPath addLineToPoint: CGPointMake(-36, 41)];
            [pinGroupShadowPath closePath];
            pinGroupShadowPath.lineJoinStyle = kCGLineJoinRound;
            
            CGContextSaveGState(context);
            CGContextSetShadowWithColor(context, pinGroupShadowColorOffset, pinGroupShadowColorBlurRadius, pinGroupShadowColor.CGColor);
            [fillColor2 setFill];
            [pinGroupShadowPath fill];
            CGContextRestoreGState(context);
            
        }
        
        
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
        
        CGSize size = CGSizeMake(35, 34);
        UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
        
        //// General Declarations
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        //// Color Declarations
        UIColor* fillColor = color;
        UIColor* strokeColor = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
        UIColor* shadowColor2 = [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 1];
        
        //// Shadow Declarations
        UIColor* shadow = [shadowColor2 colorWithAlphaComponent: 0.8];
        CGSize shadowOffset = CGSizeMake(0.1, -0.1);
        CGFloat shadowBlurRadius = 6;
        UIColor* shadow2 = shadowColor2;
        CGSize shadow2Offset = CGSizeMake(0.1, -0.1);
        CGFloat shadow2BlurRadius = 3;
        
        //// Disc Drawing
        UIBezierPath* discPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(6.5, 6, 21, 21)];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
        [fillColor setFill];
        [discPath fill];
        
        ////// Disc Inner Shadow
        CGRect discBorderRect = CGRectInset([discPath bounds], -shadow2BlurRadius, -shadow2BlurRadius);
        discBorderRect = CGRectOffset(discBorderRect, -shadow2Offset.width, -shadow2Offset.height);
        discBorderRect = CGRectInset(CGRectUnion(discBorderRect, [discPath bounds]), -1, -1);
        
        UIBezierPath* discNegativePath = [UIBezierPath bezierPathWithRect: discBorderRect];
        [discNegativePath appendPath: discPath];
        discNegativePath.usesEvenOddFillRule = YES;
        
        CGContextSaveGState(context);
        {
            CGFloat xOffset = shadow2Offset.width + round(discBorderRect.size.width);
            CGFloat yOffset = shadow2Offset.height;
            CGContextSetShadowWithColor(context,
                                        CGSizeMake(xOffset + copysign(0.1, xOffset), yOffset + copysign(0.1, yOffset)),
                                        shadow2BlurRadius,
                                        shadow2.CGColor);
            
            [discPath addClip];
            CGAffineTransform transform = CGAffineTransformMakeTranslation(-round(discBorderRect.size.width), 0);
            [discNegativePath applyTransform: transform];
            [[UIColor grayColor] setFill];
            [discNegativePath fill];
        }
        CGContextRestoreGState(context);
        
        CGContextRestoreGState(context);
        
        [strokeColor setStroke];
        discPath.lineWidth = 2;
        [discPath stroke];
        
        UIImage* result = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        // Save to cache
        [pn.imageCache setObject:result forKey:colorString];
        
        //return the image
        return result;
        
    }  else if (type == ZSPinAnnotationTypeTag) {
        
        CGSize size = CGSizeMake(57, 88);
        UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
        
        //// Color Declarations
        UIColor* fillColor = color;
        
        //// Tag Drawing
        UIBezierPath* tagPath = [UIBezierPath bezierPath];
        [tagPath moveToPoint: CGPointMake(23.76, 24.38)];
        [tagPath addCurveToPoint: CGPointMake(23.76, 15.81) controlPoint1: CGPointMake(21.41, 22.01) controlPoint2: CGPointMake(21.41, 18.17)];
        [tagPath addCurveToPoint: CGPointMake(32.24, 15.81) controlPoint1: CGPointMake(26.1, 13.44) controlPoint2: CGPointMake(29.9, 13.44)];
        [tagPath addCurveToPoint: CGPointMake(32.24, 24.38) controlPoint1: CGPointMake(34.59, 18.17) controlPoint2: CGPointMake(34.59, 22.01)];
        [tagPath addCurveToPoint: CGPointMake(23.76, 24.38) controlPoint1: CGPointMake(29.9, 26.74) controlPoint2: CGPointMake(26.1, 26.74)];
        [tagPath closePath];
        [tagPath moveToPoint: CGPointMake(28, 45.5)];
        [tagPath addCurveToPoint: CGPointMake(38, 20.6) controlPoint1: CGPointMake(27.99, 45.51) controlPoint2: CGPointMake(38, 26.17)];
        [tagPath addCurveToPoint: CGPointMake(28, 10.5) controlPoint1: CGPointMake(38, 15.02) controlPoint2: CGPointMake(33.52, 10.5)];
        [tagPath addCurveToPoint: CGPointMake(18, 20.6) controlPoint1: CGPointMake(22.48, 10.5) controlPoint2: CGPointMake(18, 15.02)];
        [tagPath addCurveToPoint: CGPointMake(28, 45.5) controlPoint1: CGPointMake(18, 26.17) controlPoint2: CGPointMake(28, 45.5)];
        [tagPath addLineToPoint: CGPointMake(28, 45.5)];
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
    
    CGFloat r, g, b, a;
    if ([c getRed:&r green:&g blue:&b alpha:&a])
        return [UIColor colorWithRed:MAX(r - 0.2, 0.0)
                               green:MAX(g - 0.2, 0.0)
                                blue:MAX(b - 0.2, 0.0)
                               alpha:a];
    return c;
    
}//end

#pragma mark Overrides


//To change the size of the tappable area that will show the callout accessory view
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event
{
    if(point.x > 30 && point.x < 80 && point.y > 0 && point.y < 50)
    {
        self.enabled = YES;
    }
    else
    {
        self.enabled = NO;
    }
    return self.enabled;
}

@end
