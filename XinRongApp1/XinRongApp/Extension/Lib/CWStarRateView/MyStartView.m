//
//  MyStartView.m
//  Star
//
//  Created by 李冬强 on 14-11-25.
//  Copyright (c) 2014年 ldq. All rights reserved.
//

#import "MyStartView.h"

@implementation MyStartView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self==[super initWithFrame:frame])
    {
        CGFloat labW = self.bounds.size.width/4;
        CGFloat selfH = self.bounds.size.height;
        _titleLab = [[UILabel alloc]init];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.textColor = [UIColor blackColor];
        [self addSubview:_titleLab];
        _evaluLab = [[UILabel alloc]init];
        _evaluLab.textColor = KLColor(234, 80, 0);
        _evaluLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_evaluLab];
        _start = [[CWStarRateView alloc]initWithFrame:CGRectMake(labW, 0, 2*labW, selfH) numberOfStars:5 bgImg:@"03--050.png" foreImg:@"03--049.png"];
        _start.scorePercent = 0;
//        _start.delegate = self;
        [self addSubview:_start];
    }
    return self;
}

- (void)setEvaluString:(NSString *)evaluString
{
    _evaluLab.text = evaluString;
}

- (void)setTitleString:(NSString *)titleString
{
    _titleLab.text = titleString;
}

- (void)setScore:(CGFloat)score
{
    _evaluString = [NSString stringWithFormat:@"%.2f",score];
}

//delegate
- (void)starRateView:(CWStarRateView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent
{
//    _score = newScorePercent;
    _evaluLab.text = [NSString stringWithFormat:@"%.2f",newScorePercent];
}

- (void)layoutSubviews
{
    CGFloat labW = self.bounds.size.width/4;
    CGFloat selfH = self.bounds.size.height;
    _titleLab.frame = CGRectMake(0, 0, labW, selfH);
    _start.frame =  CGRectMake(labW, 0, 2*labW, selfH);
    _evaluLab.frame = CGRectMake(3*labW, 0, labW, selfH);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
