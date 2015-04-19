//
//  ZaiQuanModel.h
//  XinRongApp
//
//  Created by 李冬强 on 15/4/13.
//  Copyright (c) 2015年 ldq. All rights reserved.
//
/*
 type=transferList
 推荐公司compName
 项目编码applyCode
 项目ID biddingId
 募集金额biddingMoney
 转让本金transAmt
 年化率interestRate
 承接价格creditDealAmt
 还款方式repaymentSort
 剩余周期surplusDays
 转让标的状态transStatus

*/

#import "BaseModel.h"

@interface ZaiQuanModel : BaseModel
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *applyCode;//
@property (nonatomic, strong) NSString *biddingId;
@property (nonatomic, strong) NSNumber *biddingMoney;//
@property (nonatomic, strong) NSString *ordId;
@property (nonatomic, strong) NSNumber *transAmt;//
@property (nonatomic, strong) NSNumber *interestRate;//
@property (nonatomic, strong) NSNumber *creditDealAmt;//
@property (nonatomic, strong) NSString *repaymentSort;//
@property (nonatomic, strong) NSNumber *surplusDays;//
@property (nonatomic, strong) NSNumber *transStatus;//

@end
