//
//  NSImage+Mirror.m
//  Magic Background
//
//  Created by Сергей Ваничкин on 28.02.15.
//  Copyright (c) 2015 👽 Technology. All rights reserved.
//

#import "NSImage+Mirror.h"

@implementation NSImage (Mirror)

+ (NSImage *)imageMirroredVertical:(NSImage *)image
{
    NSImage *existingImage = image;
    NSSize existingSize = [existingImage size];
    NSSize newSize = NSMakeSize(existingSize.width, existingSize.height);
    NSImage *flipedImage = [[NSImage alloc] initWithSize:newSize];
    
    [flipedImage lockFocus];
    [[NSGraphicsContext currentContext] setImageInterpolation:NSImageInterpolationHigh];
    
    NSAffineTransform *t = [NSAffineTransform transform];
    
    [t translateXBy:0
                yBy:existingSize.height];
    
    [t scaleXBy:1
            yBy:-1];
    
    [t concat];
    
    [existingImage drawAtPoint:NSZeroPoint
                      fromRect:NSMakeRect(0, 0, newSize.width, newSize.height)
                     operation:NSCompositeSourceOver
                      fraction:1.0];
    
    [flipedImage unlockFocus];
    
    return flipedImage;
}

+ (NSImage *)imageMirroredHorizontal:(NSImage *)image
{
    NSImage *existingImage = image;
    NSSize existingSize = [existingImage size];
    NSSize newSize = NSMakeSize(existingSize.width, existingSize.height);
    NSImage *flipedImage = [[NSImage alloc] initWithSize:newSize];
    
    [flipedImage lockFocus];
    [[NSGraphicsContext currentContext] setImageInterpolation:NSImageInterpolationHigh];
    
    NSAffineTransform *t = [NSAffineTransform transform];
    
    [t translateXBy:existingSize.width
                yBy:0];
    
    [t scaleXBy:-1
            yBy:1];
    
    [t concat];
    
    [existingImage drawAtPoint:NSZeroPoint
                      fromRect:NSMakeRect(0, 0, newSize.width, newSize.height)
                     operation:NSCompositeSourceOver
                      fraction:1.0];
    
    [flipedImage unlockFocus];
    
    return flipedImage;
}

@end
