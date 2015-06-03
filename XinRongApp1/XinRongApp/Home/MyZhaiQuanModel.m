//
//  MyZhaiQuanModel.m
//  XinRongApp
//
//  Created by 李冬强 on 15/4/19.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "MyZhaiQuanModel.h"
#import "NSString+Date.h"
@implementation MyZhaiQuanModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        self.dataDic = dict;
        self.title = self.dataDic[@"bidding"][@"title"];
//        self.time = [NSString getTimeWithString:[self.dataDic[@"ordDate"][@"time"] stringValue]];
    }
    return self;
}

@end
