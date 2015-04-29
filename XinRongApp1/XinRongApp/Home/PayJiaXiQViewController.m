//
//  PayJiaXiQViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/4/29.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "PayJiaXiQViewController.h"

@interface PayJiaXiQViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation PayJiaXiQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"购买加息券";
    [self addWebView];
}

#pragma mark 加息券付款
- (void)addWebView
{
    [SVProgressHUD showWithStatus:@"努力加载中..."];
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
    
    NSString *url = [NSString stringWithFormat:@"%@&customerId=%@&ordId=%@&reqType=ios",kkitTransferPayUrl,custId,_ordId];
    
    //    string = @"http://baidu.com";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [_webView loadRequest:request];
    _webView.hidden = NO;
//    _webView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_webView];
}

#pragma mark webView Delegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}


//数据加载完
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [SVProgressHUD dismiss];
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
            /*104 参数非法
             --000 成功
             --128 没有开通汇付天下
             --105 转让失败，未找到加息卷接手人
             --160 交易信息不正确
             --133 支付失败，请重试*/
            if ([[components objectAtIndex:1] isEqualToString:@"000"])
            {
                [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"付款成功"];
//                [self getListRequest];
                _webView.hidden = YES;
                [self.navigationController popViewControllerAnimated:YES];
            }
            else if ([[components objectAtIndex:1] isEqualToString:@"105"])
            {
                [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"转让失败，未找到加息卷接手人"];
                _webView.hidden = YES;
            }
            else if ([[components objectAtIndex:1] isEqualToString:@"128"])
            {
                [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"没有开通汇付天下"];
                _webView.hidden = YES;
            }
            else if ([[components objectAtIndex:1] isEqualToString:@"133"])
            {
                [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"支付失败，请重试"];
                _webView.hidden = YES;
            }
            else if ([[components objectAtIndex:1] isEqualToString:@"160"])
            {
                [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"交易信息不正确"];
                _webView.hidden = YES;
            }
        }
        //        [self.webView removeFromSuperview];
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
