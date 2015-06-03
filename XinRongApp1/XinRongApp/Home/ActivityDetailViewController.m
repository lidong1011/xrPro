//
//  ActivityDetailViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/5/19.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "ActivityDetailViewController.h"

@interface ActivityDetailViewController ()

@end

@implementation ActivityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"活动详情";
//    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 1096*kWidth/640.0)];
//    imgView.image = [UIImage imageNamed:@"activitydetail.png"];
//    UITableView *_tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight) style:UITableViewStylePlain];
//    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
//    [self.view addSubview:_tableView];
//    _tableView.tableHeaderView = imgView;
//    [self.view addSubview:_tableView];
    
    UIWebView *webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    [self.view addSubview:webview];
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
