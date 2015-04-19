//
//  TenderBill.h
//  XinRongApp
//
//  Created by 李冬强 on 15/4/18.
//  Copyright (c) 2015年 ldq. All rights reserved.
//
/*type=deal
 交易时间 ordDate
 交易金额  transAmt
 手续费 fee
 交易类型 settlCode
 可用余额 aftAvlBal
 冻结结算aftFrzBal
 备注 remark
 */

#import "BaseModel.h"

@interface TenderBill : BaseModel
@property (nonatomic, strong) NSString *ordDate;
@property (nonatomic, strong) NSNumber *transAmt;
@property (nonatomic, strong) NSNumber *fee;
@property (nonatomic, strong) NSString *settlCode;
@property (nonatomic, strong) NSNumber *aftAvlBal;
@property (nonatomic, strong) NSNumber *aftFrzBal;
@property (nonatomic, strong) NSString *remark;
@end
