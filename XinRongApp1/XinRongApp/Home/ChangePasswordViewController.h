//
//  ChangePasswordViewController.h
//  XinRongApp
//
//  Created by 李冬强 on 15/4/10.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "BaseViewController.h"

@interface ChangePasswordViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *oldPasswordTF;
@property (weak, nonatomic) IBOutlet UITextField *kNewPasswordTF;
@property (weak, nonatomic) IBOutlet UITextField *comfirmPwdTF;
- (IBAction)changAct:(UIButton *)sender;

@end
