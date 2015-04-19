//
//  AccountManager.m
//  XinRongApp
//
//  Created by 李冬强 on 15/3/18.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "AccountManager.h"
#import "KeychainItemWrapper.h"

NSString * const kKeyChainIdentifier = @"com.xr58.p2p";

@implementation AccountManager
+ (instancetype)shareManager
{
    static AccountManager *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[AccountManager alloc]init];
    });
    return shareInstance;
}

- (instancetype)init
{
    if (self = [super init]) {
        KeychainItemWrapper *keychain = [self keychainItemWrapper];
        _user.username = [keychain objectForKey:(__bridge id)(kSecAttrAccount)];
        _user.password = [keychain objectForKey:(__bridge id)(kSecValueData)];
    }
    return self;
}

- (KeychainItemWrapper *)keychainItemWrapper
{
    return [[KeychainItemWrapper alloc] initWithIdentifier:kKeyChainIdentifier accessGroup:nil];
}

- (void)setUser:(User *)user
{
    _user = user;
    KeychainItemWrapper *keychainItem = [self keychainItemWrapper];
    [keychainItem setObject:user.username forKey:(__bridge id)(kSecAttrAccount)];
    [keychainItem setObject:user.password forKey:(__bridge id)(kSecValueData)];
}

- (void)resetUser
{
    _user = nil;
    KeychainItemWrapper *keychainItem = [self keychainItemWrapper];
    [keychainItem resetKeychainItem];
}

- (BOOL)isLogin
{
    if (_user.username.length && _user.password.length) {
        return YES;
    }
    
    return NO;
}

@end
