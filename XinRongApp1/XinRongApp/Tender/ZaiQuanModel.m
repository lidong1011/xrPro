//
//  ZaiQuanModel.m
//  XinRongApp
//
//  Created by 李冬强 on 15/4/13.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "ZaiQuanModel.h"

@implementation ZaiQuanModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        self.dataDic = dict;
        self.title = self.dataDic[@"bidding"][@"title"];
        self.applyCode = self.dataDic[@"bidding"][@"applyCode"];
    }
    return self;
}

@end
