//
//  MyEndTenderModel.h
//  XinRongApp
//
//  Created by 李冬强 on 15/4/17.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

/*
 type=ing
 还款日期 payDate
 项目名称 | 周期 '第'+data.child+'标 | 第 '+data.repayment.step+'期'
 借款人 outCustAccount
 逾期天数 late
 待收利息 interest
 待收本金 capital
 罚息 lateInt
 
 type=end
 还款日期 payDate
 项目名称 | 周期 '第'+data.child+'标 | 第 '+data.repayment.step+'期'
 借款人 outCustAccount
 逾期天数 late
 已收利息 interest
 已收本金 capital
 已收罚息 lateInt
 利息所得费 fee
 */

#import "BaseModel.h"

@interface MyEndTenderModel : BaseModel
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *payDate;
@property (nonatomic, strong) NSString *outCustAccount;
@property (nonatomic, strong) NSNumber *late;
@property (nonatomic, strong) NSNumber *interest;
@property (nonatomic, strong) NSNumber *capital;
@property (nonatomic, strong) NSNumber *lateInt;
@property (nonatomic, strong) NSNumber *child;
@property (nonatomic, strong) NSNumber *step;
@property (nonatomic, strong) NSNumber *intFee;

@end
