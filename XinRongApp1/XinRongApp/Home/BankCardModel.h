//
//  BankCardModel.h
//  XinRongApp
//
//  Created by 李冬强 on 15/4/21.
//  Copyright (c) 2015年 ldq. All rights reserved.
//
/*银行卡编号usrCustId
 所属银行openBankId
 卡号openAcctId*/
#import "BaseModel.h"

@interface BankCardModel : BaseModel
@property (nonatomic, strong) NSString *usrCustId;
@property (nonatomic, strong) NSString *openBankId;
@property (nonatomic, strong) NSString *openAcctId;

@end
