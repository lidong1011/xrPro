//
//  TiYanJinModel.h
//  XinRongApp
//
//  Created by 李冬强 on 15/4/22.
//  Copyright (c) 2015年 ldq. All rights reserved.
//
/*体验金总额unTenderAmt
 已投体验金总额 tenderAmt
 体验金累计收益 incomeAmt
 
 投资日期ordDate
 投资体验标 transAmt
 预计收益 income
 状态status */

#import "BaseModel.h"

@interface TiYanJinModel : BaseModel
@property (nonatomic, strong) NSString *ordDate;
@property (nonatomic, strong) NSNumber *transAmt;
@property (nonatomic, strong) NSString *income;
@property (nonatomic, strong) NSString *status;
@end
