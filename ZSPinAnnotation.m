//
//  ZSPinAnnotation.m
//  ZSPinAnnotation
//
//  Created by Nicholas Hubbard on 12/6/11.
//  Copyright (c) 2011 Zed Said Studio. All rights reserved.
//

#import "ZSPinAnnotation.h"

@implementation ZSPinAnnotation

+ (UIImage *)pinAnnotationWithColor:(UIColor *)color {
	
	// Color Ball
	UIImage *img = [UIImage imageNamed:@"color.png"];
	
	// Shading
	UIImage *shading = [UIImage imageNamed:@"shading.png"];
	
	// Annotation Pin
	UIImage *stick = [UIImage imageNamed:@"stick.png"];
	
	// begin a new image context, to draw our colored image onto
    UIGraphicsBeginImageContext(img.size);
    
    // get a reference to that context we created
    CGContextRef context = UIGraphicsGetCurrentContext();
	
    // set the fill color
    [color setFill];
    
    // translate/flip the graphics context (for transforming from CG* coords to UI* coords
    CGContextTranslateCTM(context, 0, img.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    // set the blend mode, and the original image
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, img.size.width, img.size.height);
    CGContextDrawImage(context, rect, img.CGImage);
    
    // set a mask that matches the shape of the image
    CGContextClipToMask(context, rect, img.CGImage);
    CGContextAddRect(context, rect);
    CGContextDrawPath(context,kCGPathFill);
    
    // generate a new UIImage from the graphics context we drew onto
    UIImage *coloredImg = UIGraphicsGetImageFromCurrentImageContext();
	
	// End
    UIGraphicsEndImageContext();
	
	// Start new graphcs context
	UIGraphicsBeginImageContext(stick.size);
	
	CGRect rectFull = CGRectMake(0, 0, stick.size.width, stick.size.height);
	
	// Draw Stick
	[coloredImg drawInRect:rectFull];
	
	// Draw Shading
	[shading drawInRect:rectFull];
	
	// Draw Stick
	[stick drawInRect:rectFull];
	
	UIImage *pinImage = UIGraphicsGetImageFromCurrentImageContext();
	
	// End
    UIGraphicsEndImageContext();
    
    //return the image
    return pinImage;
	
}//end

@end
