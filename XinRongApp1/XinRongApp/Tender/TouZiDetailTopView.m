//
//  TouZiDetetView.m
//  XinRongApp
//
//  Created by 李冬强 on 15/4/11.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "TouZiDetailTopView.h"

@implementation TouZiDetailTopView
+ (instancetype)createView
{
    return [[NSBundle mainBundle]loadNibNamed:@"TouZiDetailTopView" owner:self options:nil][0];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
