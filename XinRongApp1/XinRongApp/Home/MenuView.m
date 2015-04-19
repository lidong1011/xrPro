//
//  menuView.m
//  XinRongApp
//
//  Created by 李冬强 on 15/3/27.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "MenuView.h"

@implementation MenuView
+ (instancetype)createView
{
    // 简单写法
    return [[NSBundle mainBundle] loadNibNamed:@"MenuView" owner:self options:nil][0];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
