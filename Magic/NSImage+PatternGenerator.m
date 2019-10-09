//
//  NSImage+PatternGenerator.m
//  Magic Background
//
//  Created by Сергей Ваничкин on 27.02.15.
//  Copyright (c) 2015 👽 Technology. All rights reserved.
//

#import "NSColor+RandomColor.h"
#import "NSImage+PatternGenerator.h"
#import "NSImage+Rotate.h"
#import <QuartzCore/QuartzCore.h>
#import "NSImage+Mirror.h"

@implementation NSImage (PatternGenerator)

+(NSImage *)patternImageWithSize:(NSUInteger)sz
{
    CGSize size = CGSizeMake(sz, sz);
    
    NSUInteger width   = size.width;
    NSUInteger height  = size.height;
    
    NSImage *result   = [NSImage.alloc initWithSize:size];
    
    for (int i = 0; i < 10 + arc4random() % 100; i ++)
    {
        NSImage* image = [NSImage.alloc initWithSize:size];
        
        [image lockFocus];
        
        // Line
        NSBezierPath *line = NSBezierPath.bezierPath;
        
        line.lineWidth = arc4random() % 3;
        
        [line moveToPoint:NSMakePoint(arc4random() % width,
                                      arc4random() % height)];
        
        [line lineToPoint:NSMakePoint(arc4random() % width,
                                      arc4random() % height)];

        [NSColor.randomColorA set];
        
        [line stroke];
        
        // Rect
        [NSColor.randomColorA set];
        [NSColor.randomColorA setFill];
        
        [NSBezierPath fillRect:NSMakeRect(arc4random() % width,
                                          arc4random() % height,
                                          arc4random() % width,
                                          arc4random() % height)];
     
        [NSBezierPath strokeRect:NSMakeRect(arc4random() % width,
                                            arc4random() % height,
                                            arc4random() % width,
                                            arc4random() % height)];
     
        [image unlockFocus];
     
        // Blur
        CGFloat k = (arc4random() % 8);
     
        CIImage *beginImage  =
        [CIImage.alloc initWithData:image.TIFFRepresentation];
        
        CIFilter *filter     =
        [CIFilter filterWithName:@"CIGaussianBlur"
                   keysAndValues:kCIInputImageKey, beginImage, @"inputRadius", @(k), nil];
        
        CIImage *outputImage = [filter valueForKey:@"outputImage"];
        
//        [outputImage drawInRect:NSMakeRect(0,
//                                           0,
//                                           size.width,
//                                           size.height)
//                       fromRect:NSMakeRect(0,
//                                           0,
//                                           size.width,
//                                           size.height)
//                      operation:NSCompositeSourceOver
//                       fraction:1.0];
        
        NSCIImageRep *rep = [NSCIImageRep imageRepWithCIImage:outputImage];
        
        NSImage *r = [NSImage.alloc initWithSize:rep.size];
        
        [r addRepresentation:rep];
        
        NSImage *newImage = [NSImage.alloc initWithSize:size];
        
        [newImage lockFocus];
        
        [result drawInRect:NSMakeRect(0,
                                      0,
                                      size.width,
                                      size.height)];
        
        [r drawInRect:NSMakeRect(0,
                                 0,
                                 size.width,
                                 size.height)];
        
        [newImage unlockFocus];
        
        result = newImage;
    }
    
    
    // Mirror 4 side
    NSUInteger w2 = width/2;
    NSUInteger h2 = height/2;
    
    NSRect r1 = NSMakeRect(0,  0,  w2, h2); // left top
    NSRect r2 = NSMakeRect(w2, 0,  w2, h2); // right top
    NSRect r3 = NSMakeRect(w2, h2, w2, h2); // right bottom
    NSRect r4 = NSMakeRect(0,  h2, w2, h2); // left bottom
    
    NSImage *r = [NSImage.alloc initWithSize:size];
    
    [r lockFocus];
    
    [result drawInRect:r1];
    [[NSImage imageMirroredVertical:[result imageRotated:180]] drawInRect:r2];
    
    [[NSImage imageMirroredVertical:[NSImage imageMirroredHorizontal:result.copy]] drawInRect:r3];
    
    [[NSImage imageMirroredVertical:result.copy] drawInRect:r4];
    
    [r unlockFocus];
    
    result = r;
    
    NSImage *newImage = [NSImage.alloc initWithSize:size];
    
    [newImage lockFocus];
    
    [result drawInRect:NSMakeRect(0,
                                  0,
                                  size.width,
                                  size.height)];
    
    [[result imageRotated:90] drawInRect:NSMakeRect(0,
                                                                  0,
                                                                  size.width,
                                                                  size.height)
                                              fromRect:NSMakeRect(0,
                                                                  0,
                                                                  size.width,
                                                                  size.height)
                                             operation:NSCompositeMultiply
                                              fraction:1];
    
    [newImage unlockFocus];
    
    result = newImage;
    
    return result;
}

+(NSImage *)pattern45ImageWithSize:(NSUInteger)sz
{
    CGSize size = CGSizeMake(sz, sz);
 
    NSImage *result = [NSImage patternImageWithSize:sz];
 
    CGSize s = CGSizeMake(size.width  * 3,
                          size.height * 3);
 
    NSImage *newImage = [NSImage.alloc initWithSize:s];
    
    CGFloat w = size.width;
    CGFloat h = size.height;
    
    [newImage lockFocus];
    
    for (int i = 0; i < 3; i ++)
        for (int j = 0; j < 3; j ++)
            [result drawInRect:NSMakeRect(i * w,
                                          j * h,
                                          w,
                                          h)];
    
    [newImage unlockFocus];
    
    newImage = [newImage imageRotated:45];
    
    [result lockFocus];
    
    CGFloat d = (2.f * size.width)/sqrtl(2.f);
    
    CGFloat border = (s.width - d) / 2.f;
    
    [newImage drawInRect:NSMakeRect(0,
                                    0,
                                    size.width,
                                    size.height)
                fromRect:NSMakeRect(border,
                                    border,
                                    d,
                                    d)
               operation:NSCompositeSourceOver
                fraction:1];
    
    [result unlockFocus];
    
    return result;
}

@end
