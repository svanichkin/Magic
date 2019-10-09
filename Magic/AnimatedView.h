//
//  AnimatedView.h
//  Magic
//
//  Created by Сергей Ваничкин on 10/9/19.
//  Copyright © 2019 👽 Technology. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef enum
{
    AnimationStateNone,
    AnimationStateStart,
    AnimationStateHalf,
    AnimationStateFinish
} AnimationState;

#define ANiMATED_CHANGED @"AnimationChanged"

@interface AnimatedView : NSView

@property (nonatomic, assign, readonly) AnimationState state;

-(instancetype)initWithFrame:(NSRect   )frameRect
                   withColor:(NSColor *)color;

-(void)startAnimationWithDuration:(CGFloat)duration;

@end
