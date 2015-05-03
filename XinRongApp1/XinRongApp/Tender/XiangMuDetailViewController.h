//
//  XiangMuDetailViewController.h
//  XinRongApp
//
//  Created by 李冬强 on 15/4/9.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "BaseViewController.h"

@interface XiangMuDetailViewController : BaseViewController
@property (assign, nonatomic) int vcFlag;//0为投标  1为债权转让 2为体验标
@property (strong, nonatomic) NSString *biddingId;
@property (strong, nonatomic) IBOutlet UIView *bottonView;
@property (weak, nonatomic) IBOutlet UIButton *bottomBtn;

@end
