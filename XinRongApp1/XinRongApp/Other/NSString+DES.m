//
//  NSString+DES.m
//  哇米
//
//  Created by wenga on 15/1/31.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import "NSString+DES.h"
#import "DESEncryptFile.h"

@implementation NSString (DES)

//NSString转MD5
+ (NSString*)md5_base64: (NSString *) inPutText{
//    NSString *base64str = [GTMBase64 encodeBase64String:inPutText];
//    NSString *str = [GTMBase64 md5_base64:base64str];
//    return str;
    
    const char *cStr = [inPutText UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest );
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

//文本先进行DES加密。然后再转成base64
+ (NSString *)base64StringFromText:(NSString *)text withKey:(NSString*)key
{
    if (text && ![text isEqualToString:@""]) {
        //取项目的bundleIdentifier作为KEY
        //NSString *key = [[NSBundle mainBundle] bundleIdentifier];
        NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
        //IOS 自带DES加密 Begin
        data = [DESEncryptFile DESEncrypt:data WithKey:key];
        //IOS 自带DES加密 End
        return [DESEncryptFile base64EncodedStringFrom:data];
    }
    else {
        return @"";
    }
}

@end

