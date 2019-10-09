//
//  NSImage+Mirror.h
//  Magic Background
//
//  Created by Сергей Ваничкин on 28.02.15.
//  Copyright (c) 2015 👽 Technology. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSImage (Mirror)

+ (NSImage *)imageMirroredVertical:(NSImage *)image;
+ (NSImage *)imageMirroredHorizontal:(NSImage *)image;

@end
