//
//  JiaXiQuanCell.h
//  XinRongApp
//
//  Created by 李冬强 on 15/4/21.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JiaXiQuanCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *intRateLab;
@property (weak, nonatomic) IBOutlet UILabel *youXiaoQiLab;
@property (weak, nonatomic) IBOutlet UILabel *statusLab;
@property (weak, nonatomic) IBOutlet UIButton *stateBtn1;
@property (weak, nonatomic) IBOutlet UIButton *stateBtn2;
@property (weak, nonatomic) IBOutlet UIButton *stateBtn3;

@end
