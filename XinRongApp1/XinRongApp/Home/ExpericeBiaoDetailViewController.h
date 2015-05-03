//
//  ExpericeBiaoDetailViewController.h
//  XinRongApp
//
//  Created by 李冬强 on 15/5/2.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "BaseViewController.h"

@interface ExpericeBiaoDetailViewController : BaseViewController
@property (nonatomic, strong) NSString *biddingId;
@property (strong, nonatomic) IBOutlet UIView *bottonView;

- (IBAction)bottomAct:(UIButton *)sender;

@end
