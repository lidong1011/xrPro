//
//  TiYanJinViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/4/7.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "TiYanJinViewController.h"
#import "WPAttributedStyleAction.h"
#import "NSString+WPAttributedMarkup.h"
#import "MyAccoutViewController.h"
#import "JiaoYiMXCell.h"
#import "TiYanJinModel.h"
@interface TiYanJinViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tabViewMutArray;
@property (weak, nonatomic) IBOutlet UIView *titleView;

@end

@implementation TiYanJinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"体验金数据";
    [self initData];
    
    [self addSubview];
    
    [self getTiYanJRequest];
}

//初始化数据
- (void)initData
{
    _tabViewMutArray = [NSMutableArray array];
}

//添加子视图
- (void)addSubview
{
    if (isOver3_5Inch) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kHScare(_bgView.bottom), kWidth, kHeight-kHScare(_bgView.bottom)) style:UITableViewStylePlain];
    }
    else
    {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kHScare(_bgView.bottom)+5, kWidth, kHeight-kHScare(_bgView.bottom)-5) style:UITableViewStylePlain];
    }
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
    
    NSDictionary* style1 = @{@"body":[UIFont fontWithName:@"HelveticaNeue" size:14.0],
                             @"bold":[UIFont fontWithName:@"HelveticaNeue-Bold" size:28.0]
                             };
    NSString *profitString = [NSString stringWithFormat:@"<bold>￥%@</bold> <body>元</body> ",@"0"];
    self.tiYanProfit.attributedText = [profitString attributedStringWithStyleBook:style1];
}

#pragma mark - 体验金请求
- (void)getTiYanJRequest
{
    /*用户IDcustomerId 必填
     转让标ID tenderId 必填
     */
    NSString *custId = [[NSUserDefaults standardUserDefaults]stringForKey:kCustomerId];
    
    [SVProgressHUD showWithStatus:@"加载数据中..."];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:custId forKey:@"customerId"];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    //https请求方式设置
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    __weak typeof(self) weakSelf = self;
    [manager POST:kexperienceRcordUrl parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [weakSelf TiYanJSuccess:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MyLog(@"%@",error);
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - 请求返回数据
- (void)TiYanJSuccess:(id)response
{
    //    [SVProgressHUD dismiss];
    
    NSDictionary *dic = (NSDictionary *)response;
    MyLog(@"%@",dic);
    if ([dic[@"code"] isEqualToString:@"000"])
    {
        [SVProgressHUD showImage:[UIImage imageNamed:kLogo] status:dic[@"msg"]];
        self.tiYanZELab.text = [NSString stringWithFormat:@"￥%@元",dic[@"unTenderAmt"]];
        self.didTiYanLab.text = [NSString stringWithFormat:@"￥%@元",dic[@"tenderAmt"]];
//        self.tiYanProfit.text = [NSString stringWithFormat:@"￥%@元",dic[@"incomeAmt"]];
        
        NSDictionary* style1 = @{@"body":[UIFont fontWithName:@"HelveticaNeue" size:14.0],
                                 @"bold":[UIFont fontWithName:@"HelveticaNeue-Bold" size:28.0]
                                 };
        NSString *profitString = [NSString stringWithFormat:@"<bold>￥%@</bold> <body>元</body> ",dic[@"incomeAmt"]];
        self.tiYanProfit.attributedText = [profitString attributedStringWithStyleBook:style1];
        for (NSDictionary *dataDic in dic[@"data"])
        {
            [_tabViewMutArray addObject:[TiYanJinModel messageWithDict:dataDic]];
        }
        [_tableView reloadData];
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:dic[@"msg"]];
    }
}

#pragma mark 列表数据代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tabViewMutArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*体验金总额unTenderAmt
     已投体验金总额 tenderAmt
     体验金累计收益 incomeAmt
     
     投资日期ordDate
     投资体验标 transAmt
     预计收益 income
     状态status */
    static NSString *identifier = @"cell";
    JiaoYiMXCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"JiaoYiMXCell" owner:self options:nil][0];
    }
    TiYanJinModel *dataModel = _tabViewMutArray[indexPath.row];
    cell.lab1.text = dataModel.ordDate;
    cell.lab2.text = [NSString stringWithFormat:@"%@元",[dataModel.transAmt stringValue]];
    cell.lab3.text = dataModel.income;
    cell.lab4.text = dataModel.status;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

//- (void)back
//{
//    MyAccoutViewController *myacountVC = [[MyAccoutViewController alloc]init];
//    [self.navigationController pushViewController:myacountVC animated:YES];
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
