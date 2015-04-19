//
//  AccountManager.h
//  XinRongApp
//
//  Created by 李冬强 on 15/3/18.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
@interface AccountManager : NSObject
@property (nonatomic, strong) User *user;

+ (instancetype)shareManager;
- (void)resetUser;
- (BOOL)isLogin;
@end
