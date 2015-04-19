//
//  MyStartView.h
//  Star
//
//  Created by 李冬强 on 14-11-25.
//  Copyright (c) 2014年 ldq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWStarRateView.h"
@interface MyStartView : UIView<CWStarRateViewDelegate>
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *evaluLab;
@property (nonatomic, strong) CWStarRateView *start;
@property (nonatomic, assign) CGFloat  score;
@property (nonatomic, strong) NSString *titleString;
@property (nonatomic, strong) NSString *evaluString;
@end
