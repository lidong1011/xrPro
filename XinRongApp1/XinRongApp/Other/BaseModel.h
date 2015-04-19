//
//  BaseModel.h
//  生活荟
//
//  Created by 李冬强 on 15-2-10.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject
@property (nonatomic, strong) NSDictionary *dataDic;
//@property (nonatomic, strong) NSString *title;
+ (instancetype)messageWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
