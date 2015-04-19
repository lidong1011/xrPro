//
//  ChongZhiRecordMod.h
//  XinRongApp
//
//  Created by 李冬强 on 15/4/18.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

/*
 type=recharge
 流水号trxId
 充值时间 ordDate
 充值金额 transAmt
 充值银行 openBankId
 状态 status 1交易成功 2 处理中 其它就是处理失败
 */

#import "BaseModel.h"

@interface ChongZhiRecordMod : BaseModel
@property (nonatomic, strong) NSString *ordDate;
@property (nonatomic, strong) NSNumber *transAmt;
@property (nonatomic, strong) NSString *trxId;
@property (nonatomic, strong) NSString *openBankId;
@property (nonatomic, strong) NSNumber *status;
@end
