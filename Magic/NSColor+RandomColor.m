//
//  NSColor+RandomColor.m
//  Magic Background
//
//  Created by Сергей Ваничкин on 27.02.15.
//  Copyright (c) 2015 👽 Technology. All rights reserved.
//

#import "NSColor+RandomColor.h"

@implementation NSColor (RandomColor)

+(NSColor *)randomColor
{
    return [NSColor colorWithRed:(arc4random() % 255) / 255.f
                           green:(arc4random() % 255) / 255.f
                            blue:(arc4random() % 255) / 255.f
                           alpha:1];
}

+(NSColor *)randomColorA
{
    return [NSColor colorWithRed:(arc4random() % 255) / 255.f
                           green:(arc4random() % 255) / 255.f
                            blue:(arc4random() % 255) / 255.f
                           alpha:(arc4random() % 255) / 255.f];
}

@end
