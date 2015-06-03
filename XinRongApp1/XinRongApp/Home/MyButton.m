//
//  MyButton.m
//  XinRongApp
//
//  Created by 李冬强 on 15/5/7.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "MyButton.h"

@implementation MyButton
+ (instancetype)createView
{
    // 简单写法
    return [[NSBundle mainBundle] loadNibNamed:@"MyButton" owner:self options:nil][0];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
