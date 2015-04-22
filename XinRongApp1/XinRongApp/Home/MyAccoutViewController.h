//
//  MyAccoutViewController.h
//  XinRongApp
//
//  Created by 李冬强 on 15/4/2.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyAccoutViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *coverView;
@property (weak, nonatomic) IBOutlet UIImageView *vipImgView;


@property (weak, nonatomic) IBOutlet UILabel *jiFenLab;
@property (weak, nonatomic) IBOutlet UILabel *yongHuLab;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *todayProfitLab;
@property (weak, nonatomic) IBOutlet UILabel *totalMoneyLab;
@property (weak, nonatomic) IBOutlet UILabel *daiShouJinLab;
@property (weak, nonatomic) IBOutlet UILabel *daiShouLXLab;

@property (weak, nonatomic) IBOutlet UILabel *huiFuNumLab;
@property (weak, nonatomic) IBOutlet UIImageView *huiFNextImgView;
@property (weak, nonatomic) IBOutlet UIButton *huiHuiBtn;


- (IBAction)backAction:(UIButton *)sender;
- (IBAction)settings:(UIButton *)sender;
- (IBAction)qianDaoAction:(UIButton *)sender;
- (IBAction)nextAction:(UIButton *)sender;

@end
