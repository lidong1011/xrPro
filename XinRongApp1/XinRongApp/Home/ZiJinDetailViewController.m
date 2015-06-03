//
//  ZiJinDetailViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/5/7.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "ZiJinDetailViewController.h"
#import "ChongZhiViewController.h"
#import "TiXianViewController.h"
#import "KaiTongHFViewController.h"
@interface ZiJinDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, assign) NSInteger msgCount;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ZiJinDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"账户总览";
    self.keYongLab.text = [NSString stringWithFormat:@"￥%.2f",[_balDic[@"avlBal"] floatValue]];
    self.dongJieLab.text = [NSString stringWithFormat:@"￥%.2f",[_balDic[@"frzBal"] floatValue]];
    [self addTableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getMyBalanceRequest];
}

#pragma mark - 获取我的余额请求
- (void)getMyBalanceRequest
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
    __weak typeof(self) weakSelf = self;
    [manager POST:kqueryAmtUrl parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [weakSelf getBalansuccess:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MyLog(@"%@",error);
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - 请求返回数据
- (void)getBalansuccess:(id)response
{
    /*
     账户余额 acctBal
     冻结金额 frzBal
     待收总额(待收本金+待收利息)
     待收本金restCap
     待收利息restInt
     可用余额avlBal
     待收奖励collectionReward*/
    //    [SVProgressHUD dismiss];
    NSDictionary *dic = (NSDictionary *)response;
    MyLog(@"%@",dic);
    if ([dic[@"code"] isEqualToString:@"000"])
    {
        [SVProgressHUD dismiss];
        _balDic = dic;
        self.keYongLab.text = [NSString stringWithFormat:@"￥%.2f",[_balDic[@"avlBal"] floatValue]];
        self.dongJieLab.text = [NSString stringWithFormat:@"￥%.2f",[_balDic[@"frzBal"] floatValue]];
        [self.tableView reloadData];
    }
    else if ([dic[@"code"] isEqualToString:@"128"])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"您还未开通汇付天下，是否去开通" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
        [alert show];
        //        [self performSelector:@selector(goKaiTongFH) withObject:self afterDelay:1];
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:dic[@"msg"]];
    }
}

#pragma mark -添加列表视图
- (void)addTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavigtBarH, kWidth, kHeight-49-kNavigtBarH) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableHeaderView = _headerView;
    _tableView.backgroundColor = KLColor(221, 223, 224);
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*账户余额 acctBal
     冻结金额 frzBal
     待收总额(待收本金restCap+待收利息restInt)
     待收本金restCap
     待收利息restInt
     可用余额avlBal
     累计收益 gotInt
     累计提现 totalCash
     累计充值 totalNetSave
     累计投资 tenderMoneys
     
     //"totalNetSave": 152000,
     "acctBal": 8871.27,
     "tenderMoneys": 70100,
     //"restInt": 1706.93,
     //"totalCash": 129700,
     //"restCap": 41762,
     //"frzBal": 1600,
     "code": "000",
     "msg": "查询成功",
     //"avlBal": 7271.27,
     "collectionReward": "0"*/
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    switch (indexPath.row) {
        case 0:
        {
            cell.textLabel.text = @"代收利息：";
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
            //                _verLab.backgroundColor = [UIColor redColor];
            lab.textAlignment = NSTextAlignmentRight;
            lab.text = [NSString stringWithFormat:@"￥%.2f",[_balDic[@"restInt"] floatValue]];
            cell.accessoryView = lab;
            break;
        }
        case 1:
        {
            cell.textLabel.text = @"代收本金：";
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
            //                _verLab.backgroundColor = [UIColor redColor];
            lab.textAlignment = NSTextAlignmentRight;
            lab.text = [NSString stringWithFormat:@"￥%.2f",[_balDic[@"restCap"] floatValue]];
            cell.accessoryView = lab;
            break;
        }
        case 2:
        {
            cell.textLabel.text = @"累计收益：";
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
            //                _verLab.backgroundColor = [UIColor redColor];
            lab.textAlignment = NSTextAlignmentRight;
            lab.text = [NSString stringWithFormat:@"￥%.2f",[_balDic[@"gotInt"] floatValue]];
            cell.accessoryView = lab;
            break;
        }case 3:
        {
            cell.textLabel.text = @"累计投资：";
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
            //                _verLab.backgroundColor = [UIColor redColor];
            lab.textAlignment = NSTextAlignmentRight;
            lab.text = [NSString stringWithFormat:@"￥%.2f",[_balDic[@"tenderMoneys"] floatValue]];
            cell.accessoryView = lab;
            break;
        }case 4:
        {
            cell.textLabel.text = @"累计充值：";
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
            //                _verLab.backgroundColor = [UIColor redColor];
            lab.textAlignment = NSTextAlignmentRight;
            lab.text = [NSString stringWithFormat:@"￥%.2f",[_balDic[@"totalNetSave"] floatValue]];
            cell.accessoryView = lab;
            break;
        }case 5:
        {
            cell.textLabel.text = @"累计提现：";
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
            //                _verLab.backgroundColor = [UIColor redColor];
            lab.textAlignment = NSTextAlignmentRight;
            lab.text = [NSString stringWithFormat:@"￥%.2f",[_balDic[@"totalCash"] floatValue]];
            cell.accessoryView = lab;
            break;
        }
        default:
            break;
    }
    return cell;
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

- (IBAction)bottonAction:(UIButton *)sender
{
    //先判断是否开通汇付
    NSDictionary *userMsgDic = [[NSUserDefaults standardUserDefaults]objectForKey:kUserMsg];
    if(userMsgDic[@"usrCustId"])
    {
        switch (sender.tag) {
            case 0:
            {
                //充值
                ChongZhiViewController *chongZhiVC = [[ChongZhiViewController alloc]init];
                [self.navigationController pushViewController:chongZhiVC animated:YES];
                break;
            }
            case 1:
            {
                //提现
                TiXianViewController *tiXianVC = [[TiXianViewController alloc]init];
                tiXianVC.balDic = _balDic;
                [self.navigationController pushViewController: tiXianVC animated:YES];
                break;
            }
            default:
                break;
        }
    }
    else
    {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"还未开通汇付，请开通汇付"];
        KaiTongHFViewController *kaitongHFVC = [[KaiTongHFViewController alloc]init];
        [self.navigationController pushViewController:kaitongHFVC animated:YES];
    }

    
}
@end
