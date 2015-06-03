//
//  ActivityViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/3/19.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "ActivityViewController.h"
#import "ActivityDetailViewController.h"
@interface ActivityViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tabViewMutArray;

@end

@implementation ActivityViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"活动";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _tabViewMutArray = [NSMutableArray array];
    [self addTableView];
    [self getActivityPic];
}

- (void)getActivityPic
{
    [SVProgressHUD showWithStatus:@"加载数据中..." maskType:SVProgressHUDMaskTypeGradient];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    //https请求方式设置
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    __weak typeof(self) weakSelf = self;
    [manager POST:kqueryActivityPicUrl parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [weakSelf getActivityPicSuccess:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MyLog(@"%@",error);
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - 请求返回数据
- (void)getActivityPicSuccess:(id)response
{
//    [SVProgressHUD dismiss];
    
    NSDictionary *dic = (NSDictionary *)response;
    MyLog(@"%@",dic);
    if ([dic[@"code"] isEqualToString:@"000"])
    {
        for (NSDictionary *dataDic in dic[@"data"]) {
            [_tabViewMutArray addObject:dataDic];
        }
        if (_tabViewMutArray.count==0) {
            [SVProgressHUD showImage:nil status:@"暂无活动"];
        }
        else
        {
            [SVProgressHUD dismiss];
        }
        [self.tableView reloadData];
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:dic[@"msg"]];
    }
}

- (void)addTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight-kNavigtBarH) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
}

#pragma mark 列表数据代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_tabViewMutArray.count==0) {
        [SVProgressHUD showImage:nil status:@"暂无活动"];
    }
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
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, kWidth-20, 120)];
    NSDictionary *data = _tabViewMutArray[indexPath.row];
    
    //图片路径
    NSString *picUrl = [kPicUrl stringByAppendingString:data[@"filePath"]];
    [imgView sd_setImageWithURL:[NSURL URLWithString:picUrl] placeholderImage:[UIImage imageNamed:@"activity_bg.png"]];
    //    imgView.backgroundColor = KLColor(50*indexPath.row, 30, 140);
    [cell.contentView addSubview:imgView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    JiaoYiMXCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    //    if (cell==nil) {
    //        cell = [[NSBundle mainBundle]loadNibNamed:@"JiaoYiMXCell" owner:self options:nil][0];
    //    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActivityDetailViewController *detailVC = [[ActivityDetailViewController alloc]init];
    NSDictionary *data = _tabViewMutArray[indexPath.row];
    detailVC.url = data[@"ext"];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125;
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
