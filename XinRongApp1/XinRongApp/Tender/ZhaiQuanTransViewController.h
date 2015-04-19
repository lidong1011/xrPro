//
//  ZhaiQuanTransViewController.h
//  XinRongApp
//
//  Created by 李冬强 on 15/4/16.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "BaseViewController.h"

@interface ZhaiQuanTransViewController : BaseViewController
@property (nonatomic, strong) NSNumber *transMoney;
@property (nonatomic, strong) NSString *ordId;
@property (nonatomic, strong) NSNumber *chengJieJin;
@property (weak, nonatomic) IBOutlet UILabel *transMonLab;
@property (weak, nonatomic) IBOutlet UILabel *chengJieLab;
@property (weak, nonatomic) IBOutlet UILabel *keYongLab;
@property (weak, nonatomic) IBOutlet UITextField *transMoneyTF;


- (IBAction)zhuanRangAct:(id)sender;

@end
