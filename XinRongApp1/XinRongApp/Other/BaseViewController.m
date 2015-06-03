//
//  BaseViewController.m
//  生活荟
//
//  Created by 李冬强 on 15-1-20.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"back.png" highlightIcon:nil imageScale:0.6 target:self action:@selector(back)];
    
    //添加左滑动手势
    UISwipeGestureRecognizer *leftswith = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(back)];
    leftswith.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:leftswith];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
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
