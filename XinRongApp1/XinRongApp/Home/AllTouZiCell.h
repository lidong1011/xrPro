//
//  AllTouZiCell.h
//  XinRongApp
//
//  Created by 李冬强 on 15/4/8.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllTouZiCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *info;
@property (weak, nonatomic) IBOutlet UILabel *tenderMoneyLab;
@property (weak, nonatomic) IBOutlet UILabel *didTransMoneyLab;
@property (weak, nonatomic) IBOutlet UILabel *willProfitLab;
@property (weak, nonatomic) IBOutlet UILabel *statusLab;
@property (weak, nonatomic) IBOutlet UIButton *transBtn;
- (IBAction)transAct:(UIButton *)sender;
@end
