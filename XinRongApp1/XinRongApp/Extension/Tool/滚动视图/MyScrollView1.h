//
//  MyScrollView1.h
//  滚动视图封装
//
//  Created by apple on 14-10-6.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyScrollView1;
@protocol MyScrollViewDelegate <NSObject>

@optional
- (void)scrollViewDidEndScroll:(MyScrollView1 *)scrollView;

@end

@interface MyScrollView1 : UIView
@property (nonatomic,strong) NSInteger(^numberOfAllView)(MyScrollView1 *myScrollView);
@property (nonatomic,strong) NSInteger(^numberOfViewAtRow)(MyScrollView1 *myScrollView);
@property (nonatomic, strong) CGFloat (^widthForView)(MyScrollView1 *, NSInteger);
@property (nonatomic, strong) UIView *(^viewForScr)(MyScrollView1 *, NSInteger);
@property (nonatomic, strong) void (^didSelectedView)(MyScrollView1 *, NSInteger);
@property (nonatomic,assign) CGFloat heightOfView;
@property (nonatomic,assign) CGFloat widthInterval;
@property (nonatomic,assign) CGFloat HeightInterval;
@property (nonatomic,assign) NSInteger currentPage;
@property (nonatomic,weak) id<MyScrollViewDelegate> delegate;
- (void)reloadData;
@end
