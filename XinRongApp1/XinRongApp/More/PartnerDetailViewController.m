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
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    webView.delegate = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_urlString]];
    [webView loadRequest:request];
    [self.view addSubview:webView];
}

#pragma mark webView Delegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}


//数据加载完
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    
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
