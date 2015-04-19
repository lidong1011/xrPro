//
//  KLCoverView.m
//  KnowingLife
//
//  Created by lidongqiang on 14/11/1.
//  Copyright (c) 2014年 lidongqiang All rights reserved.
//

#import "KLCoverView.h"

#define kAlpha 0.6
@implementation KLCoverView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.背景色
        self.backgroundColor = [UIColor grayColor];
        
        // 2.自动伸缩
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        // 3.透明度
        self.alpha = kAlpha;
    }
    return self;
}

- (void)reset
{
    self.alpha = kAlpha;
}

+ (id)cover
{
    return [[self alloc] init];
}

+ (id)coverWithTarget:(id)target action:(SEL)action
{
    KLCoverView *cover = [self cover];
    
    [cover addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:target action:action]];
    
    return cover;
}

- (void)setTarget:(id)target action:(SEL)action
{
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:target action:action]];
}

@end
