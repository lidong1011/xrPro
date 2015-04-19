//
//  MyBarButton.h
//  艺甲名妆
//
//  Created by 李冬强 on 15-1-7.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Items.h"
@interface MyBarButton : UIButton
@property (nonatomic, strong) Items *item;
@property (nonatomic, assign) BOOL isSelect;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titleLab;
@end
