//
//  FeedbackViewController.h
//  XinRongApp
//
//  Created by 李冬强 on 15/3/18.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "SZTextView.h"
@interface FeedbackViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *syLab;
@property (weak, nonatomic) IBOutlet SZTextView *textView;
- (IBAction)callBtn:(UIButton *)sender;
- (IBAction)sender:(UIButton *)sender;

@end
