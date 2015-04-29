//
//  TransterJXQViewController.h
//  XinRongApp
//
//  Created by 李冬强 on 15/4/24.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "BaseViewController.h"
#import "JiaXiQuanModel.h"
@interface TransterJXQViewController : BaseViewController
@property (nonatomic,strong) JiaXiQuanModel *dataModel;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTF;
@property (weak, nonatomic) IBOutlet UITextField *moneyTF;
- (IBAction)transAct:(UIButton *)sender;

@end
