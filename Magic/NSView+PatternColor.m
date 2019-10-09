//
//  NSView+PatternColor.m
//  Magic Background
//
//  Created by Сергей Ваничкин on 28.02.15.
//  Copyright (c) 2015 👽 Technology. All rights reserved.
//

#import "NSView+PatternColor.h"

@implementation NSView(PatternColor)

-(void)setBackgroundColor:(NSColor *)color
{
    self.wantsLayer = YES;
    
    self.layer.backgroundColor = color.CGColor;
}


@end
