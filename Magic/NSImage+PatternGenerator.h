//
//  NSImage+PatternGenerator.h
//  Magic Background
//
//  Created by Сергей Ваничкин on 27.02.15.
//  Copyright (c) 2015 👽 Technology. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSImage (PatternGenerator)

+(NSImage *)patternImageWithSize:(NSUInteger)size;

+(NSImage *)pattern45ImageWithSize:(NSUInteger)size;

@end
