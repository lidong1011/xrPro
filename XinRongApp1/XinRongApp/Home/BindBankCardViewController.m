//
//  BindBankCardViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/4/23.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "BindBankCardViewController.h"

@interface BindBankCardViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation BindBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"新增银行卡";
    
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    _webView.hidden=YES;
    [self.view addSubview:_webView];
    _webView.delegate = self;
    /*用户ID customerId 必填
     提现金额 transAmt 必填
     卡号 openAcctId 必填
     输入抵扣的积分 dikb  非必填
     备注 remark 非必填
     返回地址 wxUrl 必填
     请求类别 reqType 必填
     */
    NSString *custId = [[NSUserDefaults standardUserDefaults]stringForKey:kCustomerId];
    NSString *url;
    url = [NSString stringWithFormat:@"%@&customerId=%@&reqType=ios",kbindCardUrl,custId];
    //    string = @"http://baidu.com";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [_webView loadRequest:request];
    _webView.hidden = NO;
    _webView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark webView Delegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}


//数据加载完
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    
}

//监听
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    //    //    [self setNavigationLeftBg:@"ishome.png"];
    //    NSString *requestString = [[request URL] absoluteString];
    //    NSString *protocol = @"leave_view";
    //    NSLog(@"%@",requestString);
    //
    ////    if ([requestString rangeOfString:flagStr].location != NSNotFound)
    ////    {
    ////    }
    NSString *requestString = [[request URL] absoluteString];
    NSArray *components = [requestString componentsSeparatedByString:@"//"];
    if ([components count] > 1 && [(NSString *)[components objectAtIndex:0] isEqualToString:@"xr58app:"]) {
        NSString *string = (NSString *)[components objectAtIndex:1];
        components = [string componentsSeparatedByString:@"/"];
        if([(NSString *)[components objectAtIndex:0] isEqualToString:@"state"])
        {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"code" message:[components objectAtIndex:1]
                                  delegate:self cancelButtonTitle:nil
                                  otherButtonTitles:@"OK", nil];
            [alert show];
        }
        return NO;
    }
    return YES;
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
