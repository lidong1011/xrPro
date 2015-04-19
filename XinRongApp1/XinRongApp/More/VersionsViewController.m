//
//  VersionsViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/3/18.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "VersionsViewController.h"
#import "BWMCoverView.h"
@interface VersionsViewController ()

@end

@implementation VersionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"版本信息";
    // 此数组用来保存BWMCoverViewModel
    NSMutableArray *realArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i<5; i++) {
        NSString *imageStr = [NSString stringWithFormat:@"http://ikaola-image.b0.upaiyun.com/club/2014/9/28/575ba9141352103160644106f6ea328d_898_600.jpg"];
        NSString *imageTitle = [NSString stringWithFormat:@"第%d个小猫", i+1];
        BWMCoverViewModel *model = [[BWMCoverViewModel alloc] initWithImageURLString:imageStr imageTitle:imageTitle];
        [realArray addObject:model];
    }
    
    // 以上代码只为了构建一个包含BWMCoverViewModel的数组而已——realArray
    //* 快速创建BWMCoverView
    // * models是一个包含BWMCoverViewModel的数组
    //* placeholderImageNamed为图片加载前的本地占位图片名
    
    BWMCoverView *coverView = [BWMCoverView coverViewWithModels:realArray andFrame:CGRectMake(0, kNavigtBarH, self.view.bounds.size.width, kHScare(300)) andPlaceholderImageNamed:@"banner" andClickdCallBlock:^(NSInteger index) {
        NSLog(@"你点击了第%d个图片", index);
    }];
    [coverView setAutoPlayWithDelay:2.0];
    [self.view addSubview:coverView];

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
