//
//  TouZiDetetView.h
//  XinRongApp
//
//  Created by 李冬强 on 15/4/11.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TouZiDetailTopView : UIView
+ (instancetype)createView;
@property (weak, nonatomic) IBOutlet UIButton *companyBtn;

@property (weak, nonatomic) IBOutlet UILabel *moneyLab;
@property (weak, nonatomic) IBOutlet UILabel *processLab;
@property (weak, nonatomic) IBOutlet UILabel *nianHLLab;
@property (weak, nonatomic) IBOutlet UILabel *time_Lab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *text1_lab;
@property (weak, nonatomic) IBOutlet UILabel *text1Lab;
@property (weak, nonatomic) IBOutlet UILabel *text2_lab;
@property (weak, nonatomic) IBOutlet UILabel *text2Lab;
@property (weak, nonatomic) IBOutlet UILabel *text3Lab;
@property (weak, nonatomic) IBOutlet UILabel *text3_lab;




@end
