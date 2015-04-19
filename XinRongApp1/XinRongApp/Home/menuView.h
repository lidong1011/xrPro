//
//  menuView.h
//  XinRongApp
//
//  Created by 李冬强 on 15/3/27.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuView : UIView
@property (weak, nonatomic) IBOutlet UIButton *activityBtn;
@property (weak, nonatomic) IBOutlet UIButton *wuYeBtn;
+ (instancetype)createView;
@end
