//
//  TenderListModel.h
//  XinRongApp
//
//  Created by 李冬强 on 15/4/13.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

/*
 type=biddingList
 项目ID biddingId
 项目编码applyCode
 项目名称title
 募集金额biddingMoney
 回款周期timeLimit
 年化率interestRate
 项目状态biddingStatus
 项目状态百分比process
 
  */

#import <Foundation/Foundation.h>
#import "BaseModel.h"
@interface TenderListModel : BaseModel
@property (nonatomic, strong) NSString *biddingId;
@property (nonatomic, strong) NSString *applyCode;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSNumber *biddingMoney;
@property (nonatomic, strong) NSNumber *totalTenders;
@property (nonatomic, strong) NSNumber *timeLimit;
@property (nonatomic, strong) NSNumber *interestRate;
@property (nonatomic, strong) NSNumber *biddingStatus;
@property (nonatomic, strong) NSString *repaymentSort;
@property (nonatomic, strong) NSNumber *process;
@property (nonatomic, strong) NSString *picurl;
@end
