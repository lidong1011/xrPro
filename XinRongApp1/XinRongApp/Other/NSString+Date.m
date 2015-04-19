//
//  NSString+Date.m
//  生活荟
//
//  Created by 李冬强 on 15-2-10.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "NSString+Date.h"

@implementation NSString(Time)
+ (NSString *)getTimeWithString:(NSString *)timeStr
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStr doubleValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *time = [formatter stringFromDate:date];
    return time;
}
@end
