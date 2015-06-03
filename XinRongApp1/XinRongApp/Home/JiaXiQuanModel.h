//
//  JiaXiQuanModel.h
//  XinRongApp
//
//  Created by 李冬强 on 15/4/22.
//  Copyright (c) 2015年 ldq. All rights reserved.
//
/*加息券名称name
 有效期 edate
 利率 intRate
 状态 status
 加息券ID kitId
 购买人ID targetId
 卖家ID userId
 加息券转让ID ordId*/

#import "BaseModel.h"

@interface JiaXiQuanModel : BaseModel
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *customerId;
@property (nonatomic, strong) NSString *edate;
@property (nonatomic, strong) NSNumber *intRate;
@property (nonatomic, strong) NSNumber *status;
@property (nonatomic, strong) NSNumber *kitId;
@property (nonatomic, strong) NSString *targetId;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *ordId;
@property (nonatomic, strong) NSNumber *transAmt;
@end
