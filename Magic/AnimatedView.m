//
//  AnimatedView.m
//  Magic
//
//  Created by Сергей Ваничкин on 10/9/19.
//  Copyright © 2019 👽 Technology. All rights reserved.
//

#import "AnimatedView.h"
#import "NSView+PatternColor.h"

@interface AnimatedView ()

@property (nonatomic, strong) NSView  *scaledContainerView;

@end

@implementation AnimatedView

-(instancetype)initWithFrame:(NSRect   )frameRect
                   withColor:(NSColor *)color
{
    if (self = [super initWithFrame:frameRect])
    {
        self.wantsLayer          = YES;
        self.layer.masksToBounds = NO;
        
        CGRect frame =
        CGRectMake(self.frame.size.width / 2,
                   self.frame.size.height / 2,
                   self.frame.size.width,
                   self.frame.size.height);
        
        self.scaledContainerView =
        [NSView.alloc initWithFrame:frame];
        
        self.scaledContainerView.wantsLayer            = YES;
        self.scaledContainerView.layer.masksToBounds   = NO;
        self.scaledContainerView.alphaValue            = 0;
        
        [self addSubview:self.scaledContainerView];
        
        self.scaledContainerView.layer.affineTransform =
        CGAffineTransformMakeScale(0.5, 0.5);
        
        CGFloat max =
        self.frame.size.width > self.frame.size.height ? self.frame.size.width : self.frame.size.height;
        
        frame =
        CGRectMake(-max * 20,
                   -max * 20,
                   max * 40,
                   max * 40);
        
        NSView *backgroundView =
        [NSView.alloc initWithFrame:frame];
        
        backgroundView.backgroundColor     = color;
        
        [self.scaledContainerView addSubview:backgroundView];
    }
    
    return self;
}

-(void)setState:(AnimationState)state
{
    _state = state;
    
    [NSNotificationCenter.defaultCenter
        postNotificationName:ANiMATED_CHANGED
        object:self];
}

-(void)startAnimationWithDuration:(CGFloat)duration
{
    if (self.state != AnimationStateNone)
        return;
    
    __weak __typeof(self)weakSelf = self;
    
    dispatch_async(dispatch_get_main_queue(), ^(void)
    {
        weakSelf.state = AnimationStateStart;
        
        [NSAnimationContext
         runAnimationGroup:^(NSAnimationContext *context)
         {
            context.duration                = duration;
            
            weakSelf.scaledContainerView.animator.alphaValue   = 1;
        }
         completionHandler:^
         {
            weakSelf.state = AnimationStateHalf;
            
            [NSAnimationContext
             runAnimationGroup:^(NSAnimationContext *context)
             {
                context.duration                = duration;
                
                weakSelf.scaledContainerView.animator.alphaValue   = 0;
            }
             completionHandler:nil];
        }];
    });
}

@end
