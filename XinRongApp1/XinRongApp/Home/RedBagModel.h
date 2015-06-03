//
//  RedBagModel.h
//  XinRongApp
//
//  Created by 李冬强 on 15/4/22.
//  Copyright (c) 2015年 ldq. All rights reserved.
//
/*名称 name
 面额 value
 F码 code
 有效期 mdate
 状态 status
 使用条件 limitBal*/
#import "BaseModel.h"

@interface RedBagModel : BaseModel
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *value;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *mdate;
@property (nonatomic, strong) NSNumber *status;
@property (nonatomic, strong) NSNumber *limitBal;

@end
