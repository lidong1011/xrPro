//
//  NSString+DES.h
//  哇米
//
//  Created by wenga on 15/1/31.
//  Copyright (c) 2015年 wenga. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CommonCrypto/CommonDigest.h>

@interface NSString (DES)

//NSString转MD5
+ (NSString*)md5_base64: (NSString *) inPutText;

//文本先进行DES加密。然后再转成base64
+ (NSString *)base64StringFromText:(NSString *)text withKey:(NSString*)key;
@end
