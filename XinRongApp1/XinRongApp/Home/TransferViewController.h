//
//  TransferViewController.h
//  XinRongApp
//
//  Created by 李冬强 on 15/4/18.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "BaseViewController.h"
#import "PooCodeView.h"
@interface TransferViewController : BaseViewController
@property (nonatomic, strong) NSString *tenderId;

@property (weak, nonatomic) IBOutlet UILabel *tenderMoneyLab;
@property (weak, nonatomic) IBOutlet UILabel *didTransLab;
@property (weak, nonatomic) IBOutlet UILabel *canTransLab;
@property (weak, nonatomic) IBOutlet UITextField *transMoneyTF;
@property (weak, nonatomic) IBOutlet UITextField *transPriceTF;
@property (weak, nonatomic) IBOutlet UITextField *yanCodeTF;
@property (weak, nonatomic) IBOutlet PooCodeView *code;
- (IBAction)changeCode:(UIButton *)sender;
- (IBAction)transBtnAct:(UIButton *)sender;

@end
