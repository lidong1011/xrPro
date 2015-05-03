//
//  BankCardManageViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/4/22.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "BankCardManageViewController.h"
#import "BindBankCardViewController.h"
#import "MessageListCell.h"
#import "BankCardModel.h"
@interface BankCardManageViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
//@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tabViewMutArray;

@property (nonatomic, strong) BankCardModel *deleBankCard;
@end

@implementation BankCardManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"银行卡管理";
    
    [self initData];
    
    [self addSubview];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getMyBankCardRequest];
}

- (void)initData
{
    _tabViewMutArray = [NSMutableArray array];
}

- (void)addSubview
{
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 100, 20, 20);
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"addbankCard.png"] forState:UIControlStateNormal];
//    [rightBtn setTitle:@"新增" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(addBankCard) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"1.png"] style:UIBarButtonItemStylePlain target:self action:@selector(addBankCard)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    

    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 2, kWidth, kHeight-2-kNavigtBarH) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = KLColor(246, 246, 246);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
    
    
}

#pragma mark - 获取我的银行卡请求
- (void)getMyBankCardRequest
{
    NSString *custId = [[NSUserDefaults standardUserDefaults]stringForKey:kCustomerId];
    
    [SVProgressHUD showWithStatus:@"加载数据中..."];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:custId forKey:@"customerId"];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    //https请求方式设置
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    [manager POST:kqueryCardUrl parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self myBankCardsuccess:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MyLog(@"%@",error);
        
    }];
}

#pragma mark - 请求返回数据
- (void)myBankCardsuccess:(id)response
{
    [SVProgressHUD dismiss];
    NSDictionary *dic = (NSDictionary *)response;
    MyLog(@"%@",dic);
    if ([dic[@"code"] isEqualToString:@"000"])
    {
        //        [SVProgressHUD showSuccessWithStatus:@"成功"];
        [_tabViewMutArray removeAllObjects];
        for(NSDictionary *dataDic in dic[@"data"])
        {
            [_tabViewMutArray addObject:[BankCardModel messageWithDict:dataDic]];
        }
        [_tableView reloadData];
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:dic[@"msg"]];
    }
}

- (void)addBankCard
{
    BindBankCardViewController *bindBankVC = [[BindBankCardViewController alloc]init];
    [self.navigationController pushViewController:bindBankVC animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_tabViewMutArray.count==0) {
        [SVProgressHUD showImage:[UIImage imageNamed:kLogo] status:@"您还未绑定银行卡" maskType:SVProgressHUDMaskTypeGradient];
    }
    return _tabViewMutArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    if (_tabViewMutArray.count==0) {
        cell.textLabel.text = @"还未绑定银行卡";
    }
    else
    {
        BankCardModel *dataModel = _tabViewMutArray[indexPath.row];
        UIImage *icon = [UIImage imageNamed:@"moreBar_select"];
        CGSize iconSize = CGSizeMake(30, 30);
        UIGraphicsBeginImageContextWithOptions(iconSize, NO, 0.0);
        CGRect rect = CGRectMake(0, 0, iconSize.width, iconSize.height);
        [icon drawInRect:rect];
        cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        cell.textLabel.text = dataModel.openBankId;
        cell.detailTextLabel.text = dataModel.openAcctId;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    BankCardModel *dataModel = _tabViewMutArray[indexPath.row];
    _deleBankCard = dataModel;
    NSString *string = [NSString stringWithFormat:@"你确定要删除%@银行卡",dataModel.openAcctId];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:string delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
//    [self deleteMyBankCardRequestWithOpenAcctId:dataModel.openAcctId];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

#pragma mark - 删除我的银行卡请求
- (void)deleteMyBankCardRequestWithOpenAcctId:(NSString *)openAcctId
{
    NSString *custId = [[NSUserDefaults standardUserDefaults]stringForKey:kCustomerId];
    
    [SVProgressHUD showWithStatus:@"加载数据中..."];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:custId forKey:@"customerId"];
    [parameter setObject:openAcctId forKey:@"openAcctId"];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    //https请求方式设置
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    [manager POST:kdelCardUrl parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self deleteMyBankCardsuccess:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MyLog(@"%@",error);
        
    }];
}

#pragma mark - 请求返回数据
- (void)deleteMyBankCardsuccess:(id)response
{
//    [SVProgressHUD dismiss];
    NSDictionary *dic = (NSDictionary *)response;
    MyLog(@"%@",dic);
    if ([dic[@"code"] isEqualToString:@"000"])
    {
        [SVProgressHUD showSuccessWithStatus:@"删除成功"];
        [self getMyBankCardRequest];
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:dic[@"msg"]];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex) {
        [self deleteMyBankCardRequestWithOpenAcctId:_deleBankCard.openAcctId];
    }
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
