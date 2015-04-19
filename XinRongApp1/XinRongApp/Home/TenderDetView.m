//
//  TenderDetView.m
//  XinRongApp
//
//  Created by 李冬强 on 15/3/31.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "TenderDetView.h"

@implementation TenderDetView
+ (instancetype)createView
{
    return [[NSBundle mainBundle]loadNibNamed:@"TenderDetView" owner:self options:nil][0];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
