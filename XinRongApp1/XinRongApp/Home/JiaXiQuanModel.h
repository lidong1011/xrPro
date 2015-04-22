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
 状态 status*/

#import "BaseModel.h"

@interface JiaXiQuanModel : BaseModel
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *edate;
@property (nonatomic, strong) NSNumber *intRate;
@property (nonatomic, strong) NSNumber *status;

@end
