//
//  MagicView.m
//  Magic
//
//  Created by Сергей Ваничкин on 01.03.15.
//  Copyright (c) 2015 👽 Technology. All rights reserved.
//

#import "MagicView.h"
#import "NSImage+PatternGenerator.h"
#import "NSView+PatternColor.h"
#import "AnimatedView.h"
#import <QuartzCore/QuartzCore.h>

#define TiME 60

@interface MagicView ()

@property (nonatomic, strong) NSArray <NSNumber *> *sizes;
@property (nonatomic, strong) NSTextField          *tf;
@property (nonatomic, strong) NSColor              *nextColor;
@property (nonatomic, assign) BOOL                  nextColorGenerated;
@property (nonatomic, strong) NSView               *animatedContainerView;

@end

@implementation MagicView

NSSize displaysize;

-(instancetype)initWithFrame:(NSRect)frame
                   isPreview:(BOOL)isPreview
{
    if (self =
        [super initWithFrame:frame
                   isPreview:isPreview])
    {
        self.sizes = @[@64, @128, @256];
        
        CGRect frame =
        CGRectMake(self.frame.size.width / 2,
                   self.frame.size.height / 2,
                   self.frame.size.width,
                   self.frame.size.height);
        
        self.animatedContainerView =
        [NSView.alloc initWithFrame:frame];
        
        self.animatedContainerView.wantsLayer          = YES;
        self.animatedContainerView.layer.masksToBounds = NO;
        
        [self addSubview:self.animatedContainerView];
        
        [self addTextLabel];
        
        [NSNotificationCenter.defaultCenter
         addObserver:self
         selector:@selector(animatedChanged:)
         name:ANiMATED_CHANGED
         object:nil];
    }
    
    return self;
}

-(void)animateOneFrame
{
    [super animateOneFrame];
    
//    if (self.isPreview)
//    {
//        self.needsDisplay = YES;
//
//        return;
//    }
    
//    if (self.isAnimationProgress == YES)
//        return;
//
//    [self animate];
    
    return;
}

//-(BOOL)hasConfigureSheet
//{
//    return NO;
//}
//
//-(NSWindow *)configureSheet
//{
//    return nil;
//}

-(void)startAnimation
{
    [super startAnimation];
    
    [self startNewTransformation];

    if (self.nextColor == nil)
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void)
        {
            self.nextColor = self.color;
        
            dispatch_async(dispatch_get_main_queue(), ^(void)
            {
                [self startNewAnimationView];
            });
        });
    }
    
    else
        [self startNewAnimationView];
}

//-(void)stopAnimation
//{
//    [super stopAnimation];
//}

-(void)startNewAnimationView
{
    AnimatedView *view =
    [AnimatedView.alloc initWithFrame:self.frame
                            withColor:self.nextColor];
    
    [self.animatedContainerView addSubview:view];
            
    [view startAnimationWithDuration:TiME];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void)
    {
        self.nextColor = self.color;
    });
}

-(void)startNewTransformation
{
    [NSAnimationContext
     runAnimationGroup:^(NSAnimationContext *context)
     {
        context.duration                = TiME + arc4random()%TiME;
        context.allowsImplicitAnimation = YES;
        context.timingFunction          =
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

        CGFloat scale = 1. + (arc4random()%100) / 90.;
        
        self.animatedContainerView.layer.affineTransform =
        CGAffineTransformConcat(CGAffineTransformMakeScale(scale, scale),CGAffineTransformMakeRotation(M_PI * (arc4random()%100) / 180.0));
    }
     completionHandler:^
    {
        [self startNewTransformation];
    }];
}

-(void)animatedChanged:(NSNotification *)notification
{
    AnimatedView *view = notification.object;
    
    if (view.state == AnimationStateFinish)
    {
        [view removeFromSuperview];
        
        [self startNewAnimationView];
    }
    
    else if (view.state == AnimationStateHalf)
        [self startNewAnimationView];
}

-(NSColor *)color
{
    if (self.nextColorGenerated)
        return self.nextColor;
    
    self.nextColorGenerated = YES;

    NSColor *color;
    
    if (arc4random()%10 > 5)
        color =
        [NSColor colorWithPatternImage:
         [NSImage pattern45ImageWithSize:
          [self.sizes[arc4random()%self.sizes.count] integerValue]]];
    
    else
        color =
        [NSColor colorWithPatternImage:
         [NSImage patternImageWithSize:
          [self.sizes[arc4random()%self.sizes.count] integerValue]]];
    
    self.nextColorGenerated = NO;
    
    return color;
}

-(void)addTextLabel
{
    self.tf            =
    [NSTextField.alloc initWithFrame:NSMakeRect(0, 0, self.frame.size.width, 30)];
    
    self.tf.backgroundColor = NSColor.clearColor;
    self.tf.bezeled         = NO;
    self.tf.drawsBackground = YES;
    self.tf.textColor       = NSColor.whiteColor;
    self.tf.editable        = NO;
    self.tf.selectable      = NO;
    self.tf.alignment       = NSTextAlignmentCenter;
    self.tf.stringValue     = @"Copyright © 2015 👽 Technology. https://macflash.ru";
    
    if (self.isPreview)
        self.tf.font        = [NSFont fontWithName:@"Helvetica Neue"
                                              size:12];
    
    else
        self.tf.font        = [NSFont fontWithName:@"Helvetica Neue Thin"
                                              size:20];
    
    [self.tf fittingSize];
    
    self.tf.frame = NSMakeRect((self.frame.size.width - self.tf.frame.size.width)/2,
                               self.frame.size.height - 10 - self.tf.frame.size.height,
                               self.tf.frame.size.width,
                               self.tf.frame.size.height);
    
    [self addSubview:self.tf];
}

@end
