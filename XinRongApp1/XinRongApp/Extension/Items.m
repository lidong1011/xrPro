//
//  Items.m
//  CustomTabBar-0818
//
//  Created by apple on 14-8-18.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "Items.h"

@implementation Items

- (id)initWithImage:(UIImage *)image title:(NSString *)string;
{
    if (self=[super init])
    {
        _image=image;
        _title=string;
    }
    return self;
}

@end
