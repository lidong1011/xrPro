//
//  CalculatorViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/4/13.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "CalculatorViewController.h"
#import "QDCalculatorView.h"


#import "WPAttributedStyleAction.h"
#import "NSString+WPAttributedMarkup.h"
@interface CalculatorViewController ()
@property (nonatomic, strong) QDCalculatorView *calculatorView;
@end

@implementation CalculatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"计算器";
    
    self.view.backgroundColor = KLColor(225, 225, 225);
    _calculatorView = [QDCalculatorView createView];
    CGSize size = _calculatorView.size;
    _calculatorView.frame = CGRectMake(0, kNavigtBarH, kWidth, size.height);
    [self.view addSubview:_calculatorView];
    
    //lab 字体大小
    NSDictionary* style1 = @{@"body":[UIFont fontWithName:@"HelveticaNeue" size:14.0],
                             @"bold":[UIFont fontWithName:@"HelveticaNeue-Bold" size:28.0]
                             };
    NSString *nianRate = [NSString stringWithFormat:@"<bold>%.2f</bold> <body>%%</body>",[_nianRate floatValue]*100];
    _calculatorView.nianRateLab.attributedText = [nianRate attributedStringWithStyleBook:style1];
    NSString *timeStr = [NSString stringWithFormat:@"<bold>%@</bold> <body>个月</body>",[_time stringValue]];
    _calculatorView.timeLab.attributedText = [timeStr attributedStringWithStyleBook:style1];
    _calculatorView.moneyLab.text = [NSString stringWithFormat:@"￥%@",[_totalMoney stringValue]];
    [_calculatorView.calculatorBtn addTarget:self action:@selector(calculator) forControlEvents:UIControlEventTouchUpInside];
}

- (void)calculator
{
    if (_calculatorView.inputMoney.text.length == 0 ) {
        [SVProgressHUD showErrorWithStatus:@"输入投资金额有误"];
        return;
    }
    if (_calculatorView.inputRateTF.text.length == 0 ) {
        [SVProgressHUD showErrorWithStatus:@"输入年化率有误"];
        return;
    }
    float profit = [_calculatorView.inputMoney.text integerValue]*[_calculatorView.inputRateTF.text floatValue]*[_time intValue]/100;
    _calculatorView.profitLab.text = [NSString stringWithFormat:@"%.0f元",profit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
