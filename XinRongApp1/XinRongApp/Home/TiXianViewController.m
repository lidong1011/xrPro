//
//  TiXianViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/4/16.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "TiXianViewController.h"

@interface TiXianViewController ()
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation TiXianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addSubview
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kHScare(self.shouXuFenLab.bottom)+15, kWidth, kHeight-kHScare(self.shouXuFenLab.bottom)-5) style:UITableViewStylePlain];
    _tableView.tableFooterView = _footView;
    [self.view addSubview:_tableView];
    
//    _keTouLab.text = [NSString stringWithFormat:@"%ld",_keTouMoney];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)jiFenBtnAct:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        _tableView.tableHeaderView = _jiFenView;
    }
    else
    {
        _tableView.tableHeaderView = nil;
    }
}

- (IBAction)tiXianBtn:(id)sender {
}
@end
