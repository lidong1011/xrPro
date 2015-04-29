//
//  ChangeHFViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/4/23.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "ChangeHFViewController.h"

@interface ChangeHFViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation ChangeHFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"修改汇付";
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    _webView.delegate = self;
    NSString *custId = [[NSUserDefaults standardUserDefaults]stringForKey:kCustomerId];
    NSString *url = [NSString stringWithFormat:@"%@&customerId=%@&reqType=ios",khfAcctModifyUrl,custId];
    //    string = @"http://baidu.com";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [_webView loadRequest:request];
    _webView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_webView];
    
}

#pragma mark webView Delegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}


//数据加载完
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    
}

//监听
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *requestString = [[request URL] absoluteString];
    NSArray *components = [requestString componentsSeparatedByString:@"//"];
    if ([components count] > 1 && [(NSString *)[components objectAtIndex:0] isEqualToString:@"xr58app:"]) {
        NSString *string = (NSString *)[components objectAtIndex:1];
        components = [string componentsSeparatedByString:@"/"];
        if([(NSString *)[components objectAtIndex:0] isEqualToString:@"state"])
        {
//            UIAlertView *alert = [[UIAlertView alloc]
//                                  initWithTitle:@"code" message:[components objectAtIndex:1]
//                                  delegate:self cancelButtonTitle:nil
//                                  otherButtonTitles:@"OK", nil];
//            [alert show];
            if ([[components objectAtIndex:1] isEqualToString:@"000"])
            {
                [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"登陆成功"];
                [self.navigationController popViewControllerAnimated:YES];
            }
            else if ([[components objectAtIndex:1] isEqualToString:@"128"])
            {
                [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"没有开通汇付天下"];
                _webView.hidden = YES;
            }
        }
        return NO;
    }
    return YES;
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
