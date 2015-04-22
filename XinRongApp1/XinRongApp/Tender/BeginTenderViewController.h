//
//  BeginTenderViewController.h
//  XinRongApp
//
//  Created by 李冬强 on 15/4/13.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "BaseViewController.h"
#import "PooCodeView.h"
@interface BeginTenderViewController : BaseViewController
@property (nonatomic, strong) NSString *titleString;
@property (nonatomic, assign) NSInteger keTouMoney;
@property (nonatomic, strong) NSString *biddingId;

@property (weak, nonatomic) IBOutlet UILabel *keYongLab;
@property (weak, nonatomic) IBOutlet UILabel *keTouLab;
@property (weak, nonatomic) IBOutlet UITextField *inputMoneyTF;
@property (weak, nonatomic) IBOutlet UIButton *redBagFBtn;
@property (weak, nonatomic) IBOutlet UIButton *jiFenBtn;

@property (weak, nonatomic) IBOutlet PooCodeView *codeView;
@property (weak, nonatomic) IBOutlet UITextField *yanZCode;


@property (strong, nonatomic) IBOutlet UIView *queRenView;

@property (strong, nonatomic) IBOutlet UIView *redBagView;
@property (weak, nonatomic) IBOutlet UITextField *FCodeTF;


@property (strong, nonatomic) IBOutlet UIView *jiFenView;
@property (weak, nonatomic) IBOutlet UITextField *changJFTF;
@property (weak, nonatomic) IBOutlet UILabel *diKeJiFenLab;
@property (weak, nonatomic) IBOutlet UILabel *jiFenLab;

- (IBAction)changeBtnAct:(UIButton *)sender;
- (IBAction)comfireTuoZi:(UIButton *)sender;
- (IBAction)getCodeAct:(UIButton *)sender;

@end
