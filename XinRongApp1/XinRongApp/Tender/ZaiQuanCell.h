//
//  ZaiQuanCell.h
//  XinRongApp
//
//  Created by 李冬强 on 15/4/13.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZaiQuanCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *biaoNumLab;
@property (weak, nonatomic) IBOutlet UIImageView *leftBianImgView;
@property (weak, nonatomic) IBOutlet UILabel *biaoName;
@property (weak, nonatomic) IBOutlet UILabel *nianRateLab;
@property (weak, nonatomic) IBOutlet UILabel *huanKFSLab;
@property (weak, nonatomic) IBOutlet UILabel *monyeLab;
@property (weak, nonatomic) IBOutlet UILabel *zhuangRangJinLab;
@property (weak, nonatomic) IBOutlet UILabel *chengJieJiaLab;
@property (weak, nonatomic) IBOutlet UILabel *shengYuTimeLab;
@property (weak, nonatomic) IBOutlet UIButton *statusBtn;
@end
