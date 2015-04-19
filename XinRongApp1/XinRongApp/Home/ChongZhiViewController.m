//
//  ChongZhiViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/4/13.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "ChongZhiViewController.h"

@interface ChongZhiViewController ()

@end

@implementation ChongZhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

- (void)viewWillLayoutSubviews
{
    self.navigationController.title = @"充值";
    self.view.backgroundColor = [UIColor whiteColor];
    _chongView.frame = CGRectMake(0, kNavigtBarH, kWidth, kHeight-kNavigtBarH);
    [self.view addSubview:_chongView];

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
