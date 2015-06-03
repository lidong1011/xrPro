//
//  BankCardCell.h
//  XinRongApp
//
//  Created by 李冬强 on 15/5/7.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BankCardCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bankCardImg;
@property (weak, nonatomic) IBOutlet UIImageView *bankCardBgImg;
@property (weak, nonatomic) IBOutlet UILabel *bankNameLab;
@property (weak, nonatomic) IBOutlet UILabel *bankCardIdLab;
@property (weak, nonatomic) IBOutlet UILabel *cardTypeLab;

@end
