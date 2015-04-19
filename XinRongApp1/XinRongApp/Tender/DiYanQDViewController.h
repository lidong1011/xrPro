//
//  DiYanQDViewController.h
//  XinRongApp
//
//  Created by 李冬强 on 15/4/13.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "BaseViewController.h"

@interface DiYanQDViewController : BaseViewController
@property (nonatomic, strong) NSArray *picArray;
@property (nonatomic, strong) NSString *titleString;
@property (nonatomic, assign) NSInteger vCflag;//0为抵押清单  1为图片资料
@end
