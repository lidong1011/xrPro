//
//  QDCalculatorView.h
//  XinRongApp
//
//  Created by 李冬强 on 15/4/13.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QDCalculatorView : UIView
@property (weak, nonatomic) IBOutlet UILabel *nianRateLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;
@property (weak, nonatomic) IBOutlet UITextField *inputMoney;
@property (weak, nonatomic) IBOutlet UITextField *inputRateTF;
@property (weak, nonatomic) IBOutlet UILabel *profitLab;
@property (weak, nonatomic) IBOutlet UIButton *calculatorBtn;





+ (instancetype)createView;
@end
