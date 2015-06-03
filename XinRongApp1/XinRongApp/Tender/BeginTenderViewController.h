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
@property (weak, nonatomic) IBOutlet UIButton *jiaXiBtn;

@property (weak, nonatomic) IBOutlet PooCodeView *codeView;
@property (weak, nonatomic) IBOutlet UITextField *yanZCode;


@property (strong, nonatomic) IBOutlet UIView *queRenView;

@property (strong, nonatomic) IBOutlet UIView *redBagView;
@property (weak, nonatomic) IBOutlet UITextField *FCodeTF;
@property (weak, nonatomic) IBOutlet UIImageView *isRightImg;


@property (strong, nonatomic) IBOutlet UIView *jiFenView;
@property (weak, nonatomic) IBOutlet UITextField *changJFTF;
@property (weak, nonatomic) IBOutlet UILabel *diKeJiFenLab;
@property (weak, nonatomic) IBOutlet UILabel *jiFenLab;

//加息券
@property (strong, nonatomic) IBOutlet UIView *jiaXiQView;
@property (weak, nonatomic) IBOutlet UITextField *jiaXiQNumTF;
- (IBAction)selectJXQ:(UIButton *)sender;

//红包和加息
@property (strong, nonatomic) IBOutlet UIView *redBagAndJXQView;
@property (weak, nonatomic) IBOutlet UITextField *rjFCodeTF;
@property (weak, nonatomic) IBOutlet UITextField *rjJiaXiQTF;

//积分与加息券
@property (strong, nonatomic) IBOutlet UIView *jiFenAndJXQView;
@property (weak, nonatomic) IBOutlet UITextField *jjChangJFTF;
@property (weak, nonatomic) IBOutlet UILabel *jjDiKeJiFenLab;
@property (weak, nonatomic) IBOutlet UILabel *jjJiFenLab;
@property (weak, nonatomic) IBOutlet UITextField *jjJiaXiQTF;


- (IBAction)changeBtnAct:(UIButton *)sender;
- (IBAction)comfireTuoZi:(UIButton *)sender;
- (IBAction)getCodeAct:(UIButton *)sender;

@end
