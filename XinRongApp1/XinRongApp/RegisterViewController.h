//
//  RegisterViewController.h
//  XinRongApp
//
//  Created by 李冬强 on 15/3/10.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface RegisterViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UITextField *confirmPsTF;
@property (weak, nonatomic) IBOutlet UITextField *tuiGuangNumTF;
@property (weak, nonatomic) IBOutlet UITextField *msgCodeTF;
- (IBAction)getYanZhengCode:(UIButton *)sender;
- (IBAction)lookXieYi:(UIButton *)sender;
- (IBAction)isAgressXieYi:(UIButton *)sender;
- (IBAction)registerAction:(UIButton *)sender;

@end
