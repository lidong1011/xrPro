//
//  KLCoverView.h
//  KnowingLife
//
//  Created by lidongqiang on 14/11/1.
//  Copyright (c) 2014年 lidongqiang All rights reserved.
//

#import <UIKit/UIKit.h>

// 遮罩view
@interface KLCoverView : UIView
+ (id)cover;
+ (id)coverWithTarget:(id)target action:(SEL)action;
- (void)setTarget:(id)target action:(SEL)action;
- (void)reset;
@end
