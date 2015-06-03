//
//  ZiJinDetailViewController.h
//  XinRongApp
//
//  Created by 李冬强 on 15/5/7.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface ZiJinDetailViewController : BaseViewController
@property (nonatomic, strong) NSDictionary *balDic;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *keYongLab;
@property (weak, nonatomic) IBOutlet UILabel *dongJieLab;
- (IBAction)bottonAction:(UIButton *)sender;

@end
