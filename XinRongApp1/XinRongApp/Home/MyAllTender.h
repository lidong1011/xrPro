//
//  MyAllTender.h
//  XinRongApp
//
//  Created by 李冬强 on 15/4/17.
//  Copyright (c) 2015年 ldq. All rights reserved.
//
/*
 项目描述 info
 投资金额 tenderMoney
 转让本金 restCap
 预期收益 income
 投标方式 tenderWay 1 主动投标 2 自动投标
 状态 status 0投标中 1等待放款2还款中3废标4已完成
 合同 htong
 转让 tranferAble
 
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
@interface MyAllTender : BaseModel
@property (nonatomic, strong) NSString *info;
@property (nonatomic, strong) NSString *tenderMoney;
@property (nonatomic, strong) NSString *restCap;
@property (nonatomic, strong) NSNumber *income;
@property (nonatomic, strong) NSNumber *tenderWay;
@property (nonatomic, strong) NSNumber *status;
@property (nonatomic, strong) NSString *tranferAble;
@property (nonatomic, strong) NSString *biddingId;
@end
