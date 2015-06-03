//
//  ExperienceRecordViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/5/2.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "ExperienceRecordViewController.h"
#import "ExperienceBiaoRecordCell.h"
@interface ExperienceRecordViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ExperienceRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"投标记录";
    
    [self initData];
    
    [self initSubview];
    
//    [self getListRequest];
}

- (void)initData
{
    
}



#pragma mark -添加列表视图
- (void)initSubview
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 2, kWidth, kHeight-2) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    ExperienceBiaoRecordCell *cell = [[NSBundle mainBundle] loadNibNamed:@"ExperienceBiaoRecordCell" owner:self options:nil][0];
    cell.backgroundColor = KLColor(224, 224, 224);
    _tableView.tableHeaderView = cell;
    _tableView.backgroundColor = KLColor(246, 246, 246);
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
    //    [_tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
}

//- (void)loadMore
//{
//    if (_segementIndex==0) {
//        [self getListRequestWithPageNo:(++_tenderPageNo) andPageSize:@"20"];
//    }
//    else
//    {
//        [self getListRequestWithPageNo:(++_zaiQuanPageNo) andPageSize:@"20"];
//    }
//}

#pragma mark - tableView dataSource and delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tabViewMutArray.count;
    //    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    ExperienceBiaoRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ExperienceBiaoRecordCell" owner:self options:nil][0];
    }
    NSDictionary *dataDic = _tabViewMutArray[indexPath.row];
    cell.timeLab.text = [dataDic[@"ordDate"] substringToIndex:10];
    cell.moneyLab.text = [NSString stringWithFormat:@"￥%@",[dataDic[@"transAmt"] stringValue]];
    NSMutableString *nameString = [NSMutableString stringWithString:dataDic[@"mobile"]];
    [nameString replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    cell.nameLab.text = nameString;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSString *biddingId;
    //    XiangMuDetailViewController *detialVC = [[XiangMuDetailViewController  alloc]init];
    //    if (_segementIndex == 0)
    //    {
    //        TenderListModel *tenderModel = _tabViewMutArray[indexPath.row];
    //        biddingId = tenderModel.biddingId;
    //        detialVC.vcFlag = 0;
    //    }
    //    else
    //    {
    //        ZaiQuanModel *zaiQuanModel = _tabViewMutArray[indexPath.row];
    //        biddingId = zaiQuanModel.ordId;
    //        detialVC.vcFlag = 1;
    //    }
    //    detialVC.biddingId = biddingId;
    //    [self.navigationController pushViewController:detialVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}

//- (void)back
//{
//    [self.navigationController popToRootViewControllerAnimated:YES];
//}

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
