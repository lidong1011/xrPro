//
//  TiYanJinViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/4/7.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "TiYanJinViewController.h"
#import "JiaoYiMXCell.h"
@interface TiYanJinViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *titleView;

@end

@implementation TiYanJinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"体验金数据";
    [self initData];
    
    [self addSubview];
}

//初始化数据
- (void)initData
{

}

//添加子视图
- (void)addSubview
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kHScare(_titleView.bottom), kWidth, kHeight-kHScare(_titleView.bottom)) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
}

#pragma mark 列表数据代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    JiaoYiMXCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"JiaoYiMXCell" owner:self options:nil][0];
    }
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
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
