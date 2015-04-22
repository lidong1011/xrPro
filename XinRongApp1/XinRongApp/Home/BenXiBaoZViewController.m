//
//  BenXiBaoZViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/4/20.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "BenXiBaoZViewController.h"
#import "BenXBZCell.h"
@interface BenXiBaoZViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tabViewMutArray;
@end

@implementation BenXiBaoZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"本息保障计划";
    _tabViewMutArray = [NSMutableArray array];
    [self addTableView];
    
    [self getBenXiJLRequest];
}

#pragma mark -添加列表视图
- (void)addTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
    [self addTableViewFoot];
}

#pragma mark - 加入本息记录请求
- (void)getBenXiJLRequest
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
    [manager POST:ksafeplanUrl parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [weakSelf benXiJLSuccess:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MyLog(@"%@",error);
        
    }];
}

#pragma mark - 请求返回数据
- (void)benXiJLSuccess:(id)response
{
    //    [SVProgressHUD dismiss];
    /*restCap 本笔投资金额
     useRestCap本笔投资已转金额
     hasrestCap 本笔投资可转金额
     tenderId 转让标的ID*/
    NSDictionary *dic = (NSDictionary *)response;
    MyLog(@"%@",dic);
    if ([dic[@"code"] isEqualToString:@"000"])
    {
        [SVProgressHUD showSuccessWithStatus:dic[@"msg"]];
        for (NSDictionary *dataDic in dic[@"data"])
        {
            [_tabViewMutArray addObject:dataDic];
        }
        [_tableView reloadData];
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:dic[@"msg"]];
    }
}

- (void)addTableViewFoot
{
    UIView *tableViewHeader = [[UIView alloc]init];
    
//    UITextView *companyInfoTV = [[UITextView alloc]init];
    NSString *string = @"本息保障-为您的投资保驾护航\n1.A种方式120元/年，对发生逾期后的本金及利息进行垫付最高垫付额为人民币10万元\n2.B种方式200元/年，对发生逾期后的本金及利息进行垫付无最高垫付额\n3.两种方式之间独立，不可补交升级。对于加入了A计划的用户，想要加入B计划时只能重新购买";
//    companyInfoTV.text = string;
    CGFloat fontSize = 16;
//    companyInfoTV.font = [UIFont systemFontOfSize:fontSize];
//    companyInfoTV.frame = [self getSizeWithString:string andFont:fontSize];
    
    UILabel *lab = [[UILabel alloc]init];
    lab.numberOfLines = 0;
    CGRect frame = [self getSizeWithString:string andFont:fontSize];
    lab.frame = CGRectMake(kWScare(10), 0, kWidth-2*kWScare(10), frame.size.height);
    lab.font = [UIFont systemFontOfSize:fontSize];
    lab.text = string;
//    lab.backgroundColor = [UIColor redColor];
    [tableViewHeader addSubview:lab];
    
    //查看本息保障按钮
    UIButton *lookBenXiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lookBenXiBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
//    lookBenXiBtn.titleLabel.text = @"什么是本息保障计划";
    [lookBenXiBtn setTitle:@"[什么是本息保障计划?]" forState:UIControlStateNormal];
    [lookBenXiBtn setTitleColor:KLColor(60, 185, 246) forState:UIControlStateNormal];
    lookBenXiBtn.tag = 0;
    frame = [self getSizeWithString:lookBenXiBtn.titleLabel.text andFont:fontSize];
    lookBenXiBtn.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    lookBenXiBtn.frame = CGRectMake(lab.left, lab.bottom+10, frame.size.width, 25);
    [lookBenXiBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [tableViewHeader addSubview:lookBenXiBtn];
    
    UIButton *jiaABtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [jiaABtn setTitle:@"加入A计划120元/年" forState:UIControlStateNormal];
    [jiaABtn setBackgroundImage:[UIImage imageWithName:@"tiYanBtn_bg.png"] forState:UIControlStateNormal];
    jiaABtn.tag = 1;
    [jiaABtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    jiaABtn.frame = CGRectMake(lab.left, lookBenXiBtn.bottom+10, kWidth-2*lab.left, 30);
    [tableViewHeader addSubview:jiaABtn];
    
    UIButton *jiaBBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [jiaBBtn setTitle:@"加入B计划200元/年" forState:UIControlStateNormal];
    [jiaBBtn setBackgroundImage:[UIImage imageWithName:@"tiYanBtn_bg.png"] forState:UIControlStateNormal];
    jiaBBtn.tag = 2;
    [jiaBBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    jiaBBtn.frame = CGRectMake(lab.left, jiaABtn.bottom+10, kWidth-2*lab.left, 30);
    [tableViewHeader addSubview:jiaBBtn];

    
    tableViewHeader.frame = CGRectMake(0, 0, kWidth, jiaBBtn.bottom+10);
    _tableView.tableHeaderView = tableViewHeader;
}

- (void)btnAction:(UIButton *)sender
{
    MyLog(@"%ld",sender.tag);
    switch (sender.tag) {
        case 0:
        {
            //查看本息保障
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"本息保障-为您的投资保驾护航\n1.A种方式120元/年，对发生逾期后的本金及利息进行垫付最高垫付额为人民币10万元\n2.B种方式200元/年，对发生逾期后的本金及利息进行垫付无最高垫付额\n3.两种方式之间独立，不可补交升级。对于加入了A计划的" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            break;
        }
        case 1:
            //加入A计划
            [self getTransfDataRequestWithWay:@"a"];
            break;
        case 2:
            //加入B计划
            [self getTransfDataRequestWithWay:@"b"];
            break;
        default:
            break;
    }
}

#pragma mark - 加入本息请求
- (void)getTransfDataRequestWithWay:(NSString *)way
{
    /*用户IDcustomerId 必填
     转让标ID tenderId 必填
     */
    NSString *custId = [[NSUserDefaults standardUserDefaults]stringForKey:kCustomerId];
    
    [SVProgressHUD showWithStatus:@"加载数据中..."];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:custId forKey:@"customerId"];
    [parameter setObject:@"ios" forKey:@"reqType"];
    [parameter setObject:way forKey:@"type"];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    //https请求方式设置
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    __weak typeof(self) weakSelf = self;
    [manager POST:kusrAcctPay4safeplanUrl parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [weakSelf joinBenXiJLSuccess:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MyLog(@"%@",error);
        
    }];
}

#pragma mark - 请求返回数据
- (void)joinBenXiJLSuccess:(id)response
{
    NSDictionary *dic = (NSDictionary *)response;
    MyLog(@"%@",dic);
    if ([dic[@"code"] isEqualToString:@"000"])
    {
        [SVProgressHUD showSuccessWithStatus:dic[@"msg"]];
        for (NSDictionary *dataDic in dic[@"data"])
        {
            [_tabViewMutArray addObject:dataDic];
        }
        [_tableView reloadData];
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:dic[@"msg"]];
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 30;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_tabViewMutArray.count==0) {
        return 1;
    }
    return _tabViewMutArray.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    BenXBZCell *view = [[NSBundle mainBundle]loadNibNamed:@"BenXBZCell" owner:self options:nil][0];
    view.lab1.text = @"保障类型";
    view.lab2.text = @"最高垫付额";
    view.lab3.text = @"到期时间";
    view.lab1.textColor = [UIColor blackColor];
    view.lab2.textColor = [UIColor blackColor];
    view.lab3.textColor = [UIColor blackColor];
    view.lab1.backgroundColor = KLColor(236, 236, 236);
    view.lab2.backgroundColor = KLColor(236, 236, 236);
    view.lab3.backgroundColor = KLColor(236, 236, 236);
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    BenXBZCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"BenXBZCell" owner:self options:nil][0];
    }
    if (_tabViewMutArray.count==0) {
        cell.lab1.text = @"暂未加入";
        cell.lab2.text = @"暂未加入";
        cell.lab3.text = @"暂未加入";
    }
    return cell;
}

#pragma mark - 根据文字获取视图大小
- (CGRect)getSizeWithString:(NSString *)string andFont:(CGFloat)font
{
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineBreakMode = NSLineBreakByWordWrapping;
    style.alignment = NSTextAlignmentCenter;
    
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:font], NSParagraphStyleAttributeName:style.copy};
    //    CGSize size = [string sizeWithAttributes:dict];
    
    // 计算文字在指定最大宽和高下的真实大小
    // 1000 表示高度不限制
    CGRect rect = [string boundingRectWithSize:CGSizeMake(_tableView.width-2*kWScare(10), CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:NULL];
    return rect;
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
