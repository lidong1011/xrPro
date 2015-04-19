//
//  TabBar.h
//  CustomTabBar-0818
//
//  Created by apple on 14-8-18.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"
@class TabBar;

@protocol TabBarDelegate <NSObject>

@optional
- (void)tabBar:(TabBar *)tabBar didTag:(NSInteger)tag;

@end
@interface TabBar : UIView
@property(nonatomic,assign)NSInteger selectIndex;
@property(nonatomic,strong)UIImage *bgImage;
@property(nonatomic,strong)NSArray *itemArray;
@property(nonatomic,weak)id<TabBarDelegate> delegate;
- (void)didClicked:(UIButton *)sender;
@end
