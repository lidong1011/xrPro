//
//  MyIngTenderModel.m
//  XinRongApp
//
//  Created by 李冬强 on 15/4/17.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "MyIngTenderModel.h"

@implementation MyIngTenderModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        self.dataDic = dict;
        self.step = self.dataDic[@"repayment"][@"step"];
    }
    return self;
}
@end
