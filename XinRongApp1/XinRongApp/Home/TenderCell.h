//
//  TenderCell.h
//  XinRongApp
//
//  Created by 李冬强 on 15/3/26.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TenderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *leftBianImgView;
@property (weak, nonatomic) IBOutlet UILabel *biaoName;
@property (weak, nonatomic) IBOutlet UILabel *nianRateLab;
@property (weak, nonatomic) IBOutlet UILabel *huiKuangQiLab;
@property (weak, nonatomic) IBOutlet UIProgressView *progress;
@property (weak, nonatomic) IBOutlet UILabel *monyeLab;
@property (weak, nonatomic) IBOutlet UILabel *progressNum;
@property (weak, nonatomic) IBOutlet UILabel *bianNum;
@property (weak, nonatomic) IBOutlet UIButton *touBiaoBtn;
@property (weak, nonatomic) IBOutlet UIImageView *rightStatusImgView;

@end
