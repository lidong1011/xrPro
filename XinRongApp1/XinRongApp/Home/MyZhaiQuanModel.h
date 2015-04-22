//
//  MyZhaiQuanModel.h
//  XinRongApp
//
//  Created by 李冬强 on 15/4/19.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

/*
 标题 title
 编号applyCode
 转让本金transAmt
 承接价格creditDealAmt
 承接时间buyDate
 发布时间ordDate
 剩余周期restStep
 状态transStatus
 {
 applyCode = DB000001;
 creditDealAmt = 198;
 ordDate =             {
 date = 14;
 day = 2;
 hours = 0;
 minutes = 0;
 month = 3;
 nanos = 0;
 seconds = 0;
 time = 1428940800000;
 timezoneOffset = "-480";
 year = 115;
 };
 restStep = 6;
 title = "\U6d4b\U8bd5\U5c0f\U8d37\U516c\U53f8\U9879\U76ee";
 transAmt = 200;
 transStatus = 0;
 },*/

#import "BaseModel.h"

@interface MyZhaiQuanModel : BaseModel
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *applyCode;
@property (nonatomic, strong) NSNumber *transAmt;
@property (nonatomic, strong) NSNumber *creditDealAmt;
//@property (nonatomic, strong) NSString *buyDate;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *restStep;
@property (nonatomic, strong) NSNumber *transStatus;
@end
