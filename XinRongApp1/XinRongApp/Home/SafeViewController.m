//
//  SafeViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/5/18.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "SafeViewController.h"

@interface SafeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tabViewMutArray;
@end

@implementation SafeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"安全保障";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _tabViewMutArray = [NSMutableArray arrayWithArray:@[@"sd_01.png",@"sd_02.png",@"sd_03.png",@"sd_04.png",@"sd_05.png",@"sd_06.png"]];
    [self addTableView];
}

- (void)addTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight-kNavigtBarH) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.pagingEnabled = YES;
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
}

#pragma mark 列表数据代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tabViewMutArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//    if (cell==nil)
//    {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//    }
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight-kNavigtBarH)];
    imgView.image = [UIImage imageNamed:_tabViewMutArray[indexPath.row]];
//    imgView.backgroundColor = KLColor(50*indexPath.row, 30, 140);
    [cell.contentView addSubview:imgView];
//    JiaoYiMXCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//    if (cell==nil) {
//        cell = [[NSBundle mainBundle]loadNibNamed:@"JiaoYiMXCell" owner:self options:nil][0];
//    }
    cell.backgroundColor = KLColor(50*indexPath.row, 30, 140);
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _tableView.bounds.size.height;
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
