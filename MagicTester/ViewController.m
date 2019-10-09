//
//  ViewController.m
//  MagicTester
//
//  Created by Сергей Ваничкин on 10/9/19.
//  Copyright © 2019 👽 Technology. All rights reserved.
//

#import "ViewController.h"
#import "MagicView.h"
#import "AnimatedView.h"
#import "NSImage+PatternGenerator.h"
#import "NSView+PatternColor.h"

@implementation ViewController

-(void)viewDidAppear
{
    [super viewDidAppear];

    MagicView *view =
    [MagicView.alloc initWithFrame:self.view.frame
                         isPreview:NO];

    [self.view addSubview:view];

    [view startAnimation];
    
//    AnimatedView *view =
//    [AnimatedView.alloc initWithFrame:self.view.frame
//                            withColor:self.color];
//
//
//    [self.view addSubview:view];
//
//    [view startAnimationWithDuration:10];
}

-(NSColor *)color
{
    if (arc4random()%10 > 5)
        return
        [NSColor colorWithPatternImage:
         [NSImage pattern45ImageWithSize:32]];
    
    return
    [NSColor colorWithPatternImage:
     [NSImage patternImageWithSize:32]];
}


@end
