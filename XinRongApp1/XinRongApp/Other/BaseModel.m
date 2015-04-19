//
//  BaseModel.m
//  生活荟
//
//  Created by 李冬强 on 15-2-10.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
//    MyLog(@"%@",key);
}

- (void)setNilValueForKey:(NSString *)key
{
//    MyLog(@"%@",key);
}

+ (instancetype)messageWithDict:(NSDictionary *)dict
{
//    NSLog(@"父类 ： %@", self);
    return [[self alloc] initWithDict:dict];
    
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.dataDic = dict;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
@end
