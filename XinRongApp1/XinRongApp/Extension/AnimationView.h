//
//  AnimationView.h
//  MyMovie
//
//  Created by wxhl_zy107 on 14-8-27.
//  Copyright (c) 2014年 zsm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimationView : UIView<UIScrollViewDelegate> {
    UIScrollView *_scrollView;      //滑动视图
    UIImageView *_pageImageView;    //页码视图
    UIPageControl *pageControl;
    NSInteger _imagesCount;        //小图片个数
    NSInteger _index;              //图片位置
}

@property (nonatomic, retain) NSArray *imageViews;          //保存视图
@property (nonatomic, strong) void (^didSelectedView)(AnimationView *, NSInteger);
@end
