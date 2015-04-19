//
//  QuXianRecord.h
//  XinRongApp
//
//  Created by 李冬强 on 15/4/18.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

/*type=withdraw
 取现时间 ordDate
 取现银行 openBankId
 银行卡号 openAcctId
 到账金额 transAmt
 手续费 servFee
 积分抵扣 dikb
 状态 status 1交易成功 2 处理中 其它就是处理失败
 备注 remark
*/

#import "BaseModel.h"

@interface QuXianRecord : BaseModel
@property (nonatomic, strong) NSString *ordDate;
@property (nonatomic, strong) NSNumber *transAmt;
@property (nonatomic, strong) NSString *openAcctId;
@property (nonatomic, strong) NSString *openBankId;
@property (nonatomic, strong) NSNumber *status;
@property (nonatomic, strong) NSNumber *servFee;
@property (nonatomic, strong) NSNumber *dikb;
@property (nonatomic, strong) NSString *remark;
@end
