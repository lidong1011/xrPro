//
//  ExperenceTenderViewController.h
//  XinRongApp
//
//  Created by 李冬强 on 15/5/2.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "BaseViewController.h"
#import "PooCodeView.h"
@interface ExperenceTenderViewController : BaseViewController
@property (nonatomic, strong) NSString *biddingId;
@property (nonatomic, strong) NSNumber *ordType;
@property (nonatomic, assign) NSInteger keTouMoney;

@property (weak, nonatomic) IBOutlet UILabel *keTouLab;
@property (weak, nonatomic) IBOutlet UILabel *keYongTiYJLab;
@property (weak, nonatomic) IBOutlet UITextField *inputMoneyTF;


@property (weak, nonatomic) IBOutlet PooCodeView *codeView;
@property (weak, nonatomic) IBOutlet UITextField *yanZCode;

- (IBAction)comfireTuoZi:(UIButton *)sender;
- (IBAction)getCodeAct:(UIButton *)sender;
@end
