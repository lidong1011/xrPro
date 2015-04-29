//
//  ForgetPasswordViewController.h
//  XinRongApp
//
//  Created by 李冬强 on 15/4/9.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "BaseViewController.h"

@interface ForgetPasswordViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *knewPsdTF;
@property (weak, nonatomic) IBOutlet UITextField *comfirmTF;
@property (weak, nonatomic) IBOutlet UIButton *getCodeBtn;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
- (IBAction)getPassword:(UIButton *)sender;
- (IBAction)getCode:(UIButton *)sender;

@end
