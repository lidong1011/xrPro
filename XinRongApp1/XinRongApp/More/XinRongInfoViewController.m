//
//  XinRongInfoViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/4/25.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "XinRongInfoViewController.h"

@interface XinRongInfoViewController ()

@end

@implementation XinRongInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"关于新融";
    
    NSString *string = @"新融网（www.xr58.com)成立于2013年3月，公司全称为“衡阳新润民间资本投资服务有限公司”， 是一家经过衡阳市工商行政管理批准成立的合法机构。\n\
     新融网（www.xr58.com)致力于解决小微企业的资金需求和民间投资者理财需求的信息撮合和网上匹配。新融网运用先进的理念和创新的技术建立了一个安全、高效、诚信、透明的互联网金融平台，规范了个 人借贷行为，让借入者改善生产生活，让借出者增加投资渠道.";
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight-kNavigtBarH)];
    textView.text = string;
    textView.font = [UIFont systemFontOfSize:18];
    textView.editable = NO;
    [self.view addSubview:textView];
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
