//
//  ZaiDetailModel.h
//  XinRongApp
//
//  Created by 李冬强 on 15/4/14.
//  Copyright (c) 2015年 ldq. All rights reserved.
//
/*
 标的ID biddingId
 项目名称title
 推荐公司compName
 项目编码applyCode
 项目ID ordId
 募集金额biddingMoney
 转让本金transAmt
 年化率interestRate
 承接价格creditDealAmt
 还款方式repaymentSort
 剩余周期surplusDays
 转让标的状态transStatus
 是否有法律意见书hasLawer
 项目描述description
 借方介绍
 性别 1男 0女 sex
 年龄 age
 居住城市 省和市拼在一起city
 资金用途 purpose
 还款来源 paysource
 图片资料 fileList
 图片名称 fileName
 图片路径 filePath
 抵押清单 fileMorList
 图片名称 fileName
 图片路径 filePath
 法律意见 lawAdvice
 */

#import "BaseModel.h"

@interface ZaiDetailModel : BaseModel
@property (nonatomic, strong) NSString *biddingId;
@property (nonatomic, strong) NSString *applyCode;
@property (nonatomic, strong) NSString *compName;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *ordId;
@property (nonatomic, strong) NSNumber *biddingMoney;
@property (nonatomic, strong) NSNumber *transAmt;
@property (nonatomic, strong) NSNumber *interestRate;
@property (nonatomic, strong) NSNumber *creditDealAmt;
@property (nonatomic, strong) NSString *repaymentSort;
@property (nonatomic, strong) NSNumber *surplusDays;
@property (nonatomic, strong) NSNumber *transStatus;
@property (nonatomic, strong) NSString *descriptionString;
@property (nonatomic, strong) NSArray *fileList;
@property (nonatomic, strong) NSString *purpose;
@property (nonatomic, strong) NSString *paysource;
@property (nonatomic, strong) NSArray *fileMorList;
@property (nonatomic, strong) NSString *lawAdvice;
@property (nonatomic, strong) NSString *advice;
@end
