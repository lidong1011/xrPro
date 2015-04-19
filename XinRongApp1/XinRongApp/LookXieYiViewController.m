//
//  LookXieYiViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/4/9.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "LookXieYiViewController.h"

@interface LookXieYiViewController ()
@property (nonatomic, strong) UITextView *textView;
@end

@implementation LookXieYiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"用户协议";
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(0, kNavigtBarH, kWidth, kHeight-kNavigtBarH)];
    _textView.text = @"";
    _textView.backgroundColor = KLColor(246, 246, 246);
    [self.view addSubview:_textView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
