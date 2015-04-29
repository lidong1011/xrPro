//
//  EditMessageListCell.h
//  XinRongApp
//
//  Created by 李冬强 on 15/4/25.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditMessageListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *infoLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UIImageView *isNewImgView;
@property (weak, nonatomic) IBOutlet UIButton *singleSeleBtn;

@end
