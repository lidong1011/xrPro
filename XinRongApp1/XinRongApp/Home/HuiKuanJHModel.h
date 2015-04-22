//
//  HuiKuanJHModel.h
//  XinRongApp
//
//  Created by 李冬强 on 15/4/22.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

/*标题 title
 第几标 child
 投资金额 tenderMoney
 本期应收本金 capital
 回款周期 step
 应收利息 interest+additionalInterest
 日期 payDate*/

#import "BaseModel.h"

@interface HuiKuanJHModel : BaseModel
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *child;
@property (nonatomic, strong) NSNumber *tenderMoney;
@property (nonatomic, strong) NSNumber *step;

@end
