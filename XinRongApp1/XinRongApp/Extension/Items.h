//
//  Items.h
//  CustomTabBar-0818
//
//  Created by apple on 14-8-18.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Items : NSObject
@property(nonatomic,strong)UIImage *selectImage;
@property(nonatomic,strong)UIImage *image;
@property(nonatomic,strong)NSString *title;
- (id)initWithImage:(UIImage *)image title:(NSString *)string;
@end
