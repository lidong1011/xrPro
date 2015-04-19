//
//  TenderDetailModel.h
//  XinRongApp
//
//  Created by 李冬强 on 15/4/14.
//  Copyright (c) 2015年 ldq. All rights reserved.
//
/*
 项目ID biddingId
 项目编码applyCode
 项目名称title
 募集金额biddingMoney
 回款周期timeLimit
 年化率interestRate
 项目状态biddingStatus
 项目状态百分比process
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
 担保机构
 */

#import "BaseModel.h"

@interface TenderDetailModel : BaseModel
@property (nonatomic, strong) NSString *biddingId;
@property (nonatomic, strong) NSString *applyCode;
@property (nonatomic, strong) NSString *compName;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSNumber *biddingMoney;
@property (nonatomic, strong) NSNumber *totalTender;
@property (nonatomic, strong) NSNumber *timeLimit;
@property (nonatomic, strong) NSNumber *interestRate;
@property (nonatomic, strong) NSNumber *biddingStatus;
@property (nonatomic, strong) NSString *repaymentSort;
@property (nonatomic, strong) NSString *process;
@property (nonatomic, strong) NSNumber *hasLawer;
@property (nonatomic, strong) NSString *descriptionStrng;
@property (nonatomic, strong) NSArray *fileList;
@property (nonatomic, strong) NSString *purpose;
@property (nonatomic, strong) NSString *paysource;
@property (nonatomic, strong) NSArray *fileMorList;
@property (nonatomic, strong) NSString *lawAdvice;
@property (nonatomic, strong) NSString *advice;
@end
