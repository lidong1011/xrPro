//
//  PartnerDetailViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/4/25.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "PartnerDetailViewController.h"

@interface PartnerDetailViewController ()<UIWebViewDelegate>

@end

@implementation PartnerDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = _titleString;
    UITextView *detailView = [[UITextView alloc]init];
    detailView.frame = CGRectMake(0, 0, kWidth, kHeight);
    detailView.editable = NO;
    detailView.textColor = [UIColor grayColor];
    detailView.font = [UIFont systemFontOfSize:17];
    detailView.text = _detailString;
    [self.view addSubview:detailView];
    
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
