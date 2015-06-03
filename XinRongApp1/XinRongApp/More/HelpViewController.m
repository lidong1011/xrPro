//
//  HelpViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/4/29.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "HelpViewController.h"
#import "AnswerViewController.h"
@interface HelpViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tabViewMutArray;


@end

#define kAnswer @"answer"
#define kQuestion @"question"

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"帮助中心";
    [self initData];
    
    [self addSubview];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self getMyBankCardRequest];
}

- (void)initData
{
    NSArray *questionsArray = @[@"我是新手，该如何投资?",@"相比于其他投资渠道，新融网有何优势？",@"新融网的投资是否安全？有哪些保障？",@"如何注册新融账户？",@"为什么要注册汇付天下帐号？我该如何如何注册？"];
    NSArray *answerArray = @[@"尊敬的先生/女士，您可以先对我们平台做一个简单的了解，并注册您的新融网个人账户，根据您的兴趣在平台首页选择投资项目，点击我要投标按钮，输入金额和验证码，点击确认投资跳转至汇付天下界面，输入交易密码即投资成功",@"尊敬的先生/女士，您好，新融网运用先进的理念和创新的技术建立了一个安全、高效、诚信、透明的互联网金融平台，规范了个人借贷行为，让借入者改善生产生活，让借出者增加投资渠道。平台不仅拥有专业且实力雄厚的人员储备，并与第三方资金托管平台汇付天下进行合作，而且平台上所有投资的项目均有担保公司进行担保。",@"尊敬的先生/女士，请您放心，我们平台拥有专业且实力雄厚的人员储备。新融网拥有资深的技术团队，对网络数据安全，并发处理，金融业务等技术有着丰富的实践经验。与我们合作的第三方托管是汇付天下资金托管平台，汇付天下是获得中国第三方支付牌照的公司，资金年交易量7000亿人民币并受央行监管。并且平台上所有投资项目均有担保公司进行担保，而且我们会和多家担保公司、资产管理公司合作。",@"尊敬的先生/女士，您打开百度搜索www.xr58.com，进入新融网（www.xr58.com），点击右上角注册按钮，填写基本信息，验证手机号激活账户，注册成功。",@"尊敬的先生/女士，您需要注册汇付天下账户托管您的资金，在您激活手机绑定后，点击开通汇付天下账号，页面自动跳转至汇付天下，设置汇付天下登录密码和交易密码，建议密码不一致安全性更高，并且牢记您所设置的密码；完善您的个人信息，点击确定开通成功。"];
    _tabViewMutArray = [NSMutableArray array];
    for (int i=0; i<questionsArray.count; i++)
    {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:answerArray[i],kAnswer,questionsArray[i],kQuestion, nil];
        [_tabViewMutArray addObject:dic];
    }
    
}

- (void)addSubview
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 2, kWidth, kHeight-2) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = KLColor(246, 246, 246);
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
}

#pragma mark - 获取帮助问题卡请求
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
//            [_tabViewMutArray addObject:[BankCardModel messageWithDict:dataDic]];
        }
        [_tableView reloadData];
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:dic[@"msg"]];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return 4;
    return _tabViewMutArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    UIImage *jianTouImg = [UIImage imageNamed:@"jianTou.png"];
    UIImageView *jianTimgView = [[UIImageView alloc]initWithImage:jianTouImg];
    jianTimgView.frame = CGRectMake(0, 0, jianTouImg.size.width/2, jianTouImg.size.height/2);
    cell.accessoryView = jianTimgView;
    NSDictionary *dic = _tabViewMutArray[indexPath.row];
    cell.textLabel.text = dic[kQuestion];
    cell.detailTextLabel.text = dic[kAnswer];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AnswerViewController *answerVC = [[AnswerViewController alloc]init];
    answerVC.dic = _tabViewMutArray[indexPath.row];
    [self.navigationController pushViewController:answerVC animated:YES];
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
