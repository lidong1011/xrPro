//
//  JiaXiQuanModel.m
//  XinRongApp
//
//  Created by 李冬强 on 15/4/22.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "JiaXiQuanModel.h"

@implementation JiaXiQuanModel
/*"transfer": {
 "transDate": null,
 "customerId": "c98a6ffd-8679-4967-ae2d-f419465d9bbc",
 "status": 0,
 "ordId": "",
 "kitId": 39,
 "targetId": "",
 "transAmt": 0,
 "kit": null,
 "ordDate": null,
 "version": 0
 }*/
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        self.dataDic = dict;
        self.targetId = self.dataDic[@"transfer"][@"targetId"];
        self.ordId = self.dataDic[@"transfer"][@"ordId"];
        self.transAmt = self.dataDic[@"transfer"][@"transAmt"];
    }
    return self;
}
@end
