//
//  SettingsViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/4/2.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "SettingsViewController.h"
#import "PersonSetViewController.h"
#import "MessageViewController.h"
#import "BankCardManageViewController.h"
#import "LoginHuiFuViewController.h"
#import "ChangeHFViewController.h"
#import "LoginViewController.h"
#import "XiangMuDetailViewController.h"
#import "GuestureViewController.h"
#import "LoginHFCell.h"
#import "UMSocial.h"
@interface SettingsViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UMSocialUIDelegate,UMSocialDataDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) BOOL isSelectHF;
@property (nonatomic, strong) NSString *updataStr;
@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"账户设置";
    
    //初始化试图
    [self initSubview];
    
    [self checkUpdata];
}

//把视图初始化
- (void)initSubview
{
    UIButton *quiteBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    quiteBtn.frame = CGRectMake(40, 20, kWidth-2*40, kHScare(35));
    [quiteBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    quiteBtn.backgroundColor = kZhuTiColor;
    quiteBtn.layer.cornerRadius = quiteBtn.height/2;
    quiteBtn.clipsToBounds = YES;
    [quiteBtn addTarget:self action:@selector(quite) forControlEvents:UIControlEventTouchUpInside];
    UIView *tableViewFootView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHScare(74))];
    [tableViewFootView addSubview:quiteBtn];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 5, kWidth, kHeight-5) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = KLColor(231, 231, 231);
    _tableView.tableFooterView = tableViewFootView;
    [self.view addSubview:_tableView];
}


#pragma mark 列表数据代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_isSelectHF) {
        return 7;
    }
    else
    {
        return 6;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *const identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    switch (indexPath.row) {
        case 0:
        {
            UIImage *icon = [UIImage imageNamed:@"person_person.png"];
            CGSize iconSize = CGSizeMake(20, 20);
            UIGraphicsBeginImageContextWithOptions(iconSize, NO, 0.0);
            CGRect rect = CGRectMake(0, 0, iconSize.width, iconSize.height);
            [icon drawInRect:rect];
            cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            //箭头
            UIImage *jianTouImg = [UIImage imageNamed:@"jianTou.png"];
            UIImageView *jianTimgView = [[UIImageView alloc]initWithImage:jianTouImg];
            jianTimgView.frame = CGRectMake(0, 0, jianTouImg.size.width/2, jianTouImg.size.height/2);
            cell.accessoryView = jianTimgView;
            cell.textLabel.text = @"个人设置";
            break;
        }
        case 1:
        {
            UIImage *icon = [UIImage imageNamed:@"huiftx.png"];
            CGSize iconSize = CGSizeMake(20, 20);
            UIGraphicsBeginImageContextWithOptions(iconSize, NO, 0.0);
            CGRect rect = CGRectMake(0, 0, iconSize.width, iconSize.height);
            [icon drawInRect:rect];
            cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
//            //箭头
//            UIImage *jianTouImg = [UIImage imageNamed:@"jianTou.png"];
//            UIImageView *jianTimgView = [[UIImageView alloc]initWithImage:jianTouImg];
//            jianTimgView.frame = CGRectMake(0, 0, jianTouImg.size.width/2, jianTouImg.size.height/2);
//            cell.accessoryView = jianTimgView;
            cell.textLabel.text = @"汇付天下";
            break;
        }
        case 2:
        {
            if (_isSelectHF)
            {
                //
                LoginHFCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"LoginHFCell" owner:self options:nil] firstObject];
                cell.loginHFBtn.tag = 0;
                [cell.loginHFBtn addTarget:self action:@selector(huiFuAct:) forControlEvents:UIControlEventTouchUpInside];
                cell.changeHFBtn.tag = 1;
                [cell.changeHFBtn addTarget:self action:@selector(huiFuAct:) forControlEvents:UIControlEventTouchUpInside];
                return cell;
//                UIButton *loginHFBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                
            }
            else
            {//银行卡管理
                UIImage *icon = [UIImage imageNamed:@"bankcard_p.png"];
                CGSize iconSize = CGSizeMake(20, 20);
                UIGraphicsBeginImageContextWithOptions(iconSize, NO, 0.0);
                CGRect rect = CGRectMake(0, 0, iconSize.width, iconSize.height);
                [icon drawInRect:rect];
                cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                //箭头
                UIImage *jianTouImg = [UIImage imageNamed:@"jianTou.png"];
                UIImageView *jianTimgView = [[UIImageView alloc]initWithImage:jianTouImg];
                jianTimgView.frame = CGRectMake(0, 0, jianTouImg.size.width/2, jianTouImg.size.height/2);
                cell.accessoryView = jianTimgView;
                cell.textLabel.text = @"银行卡管理";
            }
            break;
        }
        case 3:
        {
            if (_isSelectHF) {
                //银行卡管理
                UIImage *icon = [UIImage imageNamed:@"bankcard_p.png"];
                CGSize iconSize = CGSizeMake(20, 20);
                UIGraphicsBeginImageContextWithOptions(iconSize, NO, 0.0);
                CGRect rect = CGRectMake(0, 0, iconSize.width, iconSize.height);
                [icon drawInRect:rect];
                cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                //箭头
                UIImage *jianTouImg = [UIImage imageNamed:@"jianTou.png"];
                UIImageView *jianTimgView = [[UIImageView alloc]initWithImage:jianTouImg];
                jianTimgView.frame = CGRectMake(0, 0, jianTouImg.size.width/2, jianTouImg.size.height/2);
                cell.accessoryView = jianTimgView;
                cell.textLabel.text = @"银行卡管理";
            }
            else
            {
                UIImage *icon = [UIImage imageNamed:@"message_p.png"];
                CGSize iconSize = CGSizeMake(20, 20);
                UIGraphicsBeginImageContextWithOptions(iconSize, NO, 0.0);
                CGRect rect = CGRectMake(0, 0, iconSize.width, iconSize.height);
                [icon drawInRect:rect];
                cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                //箭头
                UIImage *jianTouImg = [UIImage imageNamed:@"jianTou.png"];
                UIImageView *jianTimgView = [[UIImageView alloc]initWithImage:jianTouImg];
                jianTimgView.frame = CGRectMake(0, 0, jianTouImg.size.width/2, jianTouImg.size.height/2);
                cell.accessoryView = jianTimgView;
                cell.textLabel.text = @"消息中心";
            }
            break;
        }
        case 4:
        {
            if (_isSelectHF) {
                UIImage *icon = [UIImage imageNamed:@"message_p.png"];
                CGSize iconSize = CGSizeMake(20, 20);
                UIGraphicsBeginImageContextWithOptions(iconSize, NO, 0.0);
                CGRect rect = CGRectMake(0, 0, iconSize.width, iconSize.height);
                [icon drawInRect:rect];
                cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                //箭头
                UIImage *jianTouImg = [UIImage imageNamed:@"jianTou.png"];
                UIImageView *jianTimgView = [[UIImageView alloc]initWithImage:jianTouImg];
                jianTimgView.frame = CGRectMake(0, 0, jianTouImg.size.width/2, jianTouImg.size.height/2);
                cell.accessoryView = jianTimgView;
                cell.textLabel.text = @"消息中心";
            }
            else
            {
                UIImage *icon = [UIImage imageNamed:@"lock.png"];
                CGSize iconSize = CGSizeMake(20, 20);
                UIGraphicsBeginImageContextWithOptions(iconSize, NO, 0.0);
                CGRect rect = CGRectMake(0, 0, iconSize.width, iconSize.height);
                [icon drawInRect:rect];
                cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                //箭头
                UIImage *jianTouImg = [UIImage imageNamed:@"jianTou.png"];
                UIImageView *jianTimgView = [[UIImageView alloc]initWithImage:jianTouImg];
                jianTimgView.frame = CGRectMake(0, 0, jianTouImg.size.width/2, jianTouImg.size.height/2);
                cell.accessoryView = jianTimgView;
                cell.textLabel.text = @"安全设置";
            }
            break;
        }
        case 5:
        {
            if (_isSelectHF) {
                UIImage *icon = [UIImage imageNamed:@"lock.png"];
                CGSize iconSize = CGSizeMake(20, 20);
                UIGraphicsBeginImageContextWithOptions(iconSize, NO, 0.0);
                CGRect rect = CGRectMake(0, 0, iconSize.width, iconSize.height);
                [icon drawInRect:rect];
                cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                //箭头
                UIImage *jianTouImg = [UIImage imageNamed:@"jianTou.png"];
                UIImageView *jianTimgView = [[UIImageView alloc]initWithImage:jianTouImg];
                jianTimgView.frame = CGRectMake(0, 0, jianTouImg.size.width/2, jianTouImg.size.height/2);
                cell.accessoryView = jianTimgView;
                cell.textLabel.text = @"安全设置";
            }
            else
            {
                UIImage *icon = [UIImage imageNamed:@"share.png"];
                CGSize iconSize = CGSizeMake(20, 20);
                UIGraphicsBeginImageContextWithOptions(iconSize, NO, 0.0);
                CGRect rect = CGRectMake(0, 0, iconSize.width, iconSize.height);
                [icon drawInRect:rect];
                cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                //            //箭头
                //            UIImage *jianTouImg = [UIImage imageNamed:@"jianTou.png"];
                //            UIImageView *jianTimgView = [[UIImageView alloc]initWithImage:jianTouImg];
                //            jianTimgView.frame = CGRectMake(0, 0, jianTouImg.size.width/2, jianTouImg.size.height/2);
                //            cell.accessoryView = jianTimgView;
                cell.textLabel.text = @"邀请好友";
            }
            break;
        }
        case 6:
        {
            UIImage *icon = [UIImage imageNamed:@"share.png"];
            CGSize iconSize = CGSizeMake(20, 20);
            UIGraphicsBeginImageContextWithOptions(iconSize, NO, 0.0);
            CGRect rect = CGRectMake(0, 0, iconSize.width, iconSize.height);
            [icon drawInRect:rect];
            cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            //            //箭头
            //            UIImage *jianTouImg = [UIImage imageNamed:@"jianTou.png"];
            //            UIImageView *jianTimgView = [[UIImageView alloc]initWithImage:jianTouImg];
            //            jianTimgView.frame = CGRectMake(0, 0, jianTouImg.size.width/2, jianTouImg.size.height/2);
            //            cell.accessoryView = jianTimgView;
            cell.textLabel.text = @"邀请好友";
            break;
        }
        default:
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            //个人设置
            PersonSetViewController *personSetVC = [[PersonSetViewController alloc]init];
            [self.navigationController pushViewController:personSetVC animated:YES];
            break;
        }
        case 1:
        {
            _isSelectHF = !_isSelectHF;
            [_tableView reloadData];
            break;
        }
        case 2:
        {
            if (_isSelectHF) {
                //
            }
            else
            {//银行卡管理
                 BankCardManageViewController *messageVC = [[BankCardManageViewController alloc]init];
                [self.navigationController pushViewController:messageVC animated:YES];
            }
            break;
        }
        case 3:
        {
            
            if (_isSelectHF)
            {
                //银行卡管理
                BankCardManageViewController *messageVC = [[BankCardManageViewController alloc]init];
                [self.navigationController pushViewController:messageVC animated:YES];
            }
            else
            {//消息中心
                MessageViewController *messageVC = [[MessageViewController alloc]init];
                [self.navigationController pushViewController:messageVC animated:YES];
            }
            break;
        }
        case 4:
        {
            if (_isSelectHF) {
                MessageViewController *messageVC = [[MessageViewController alloc]init];
                [self.navigationController pushViewController:messageVC animated:YES];
            }
            else
            {
                GuestureViewController *guestureVC = [[GuestureViewController alloc]init];
                [self.navigationController pushViewController:guestureVC animated:YES];
            }
            break;
        }
        case 5:
        {
            if (_isSelectHF) {
                GuestureViewController *guestureVC = [[GuestureViewController alloc]init];
                [self.navigationController pushViewController:guestureVC animated:YES];
            }
            else
            {
                [self share];
            }

            break;
        }
        case 6:
        {
            if (_isSelectHF) {
                [self share];
            }
            break;
        }

        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

#pragma mark 汇付操作
- (void)huiFuAct:(UIButton *)sender
{
    if (sender.tag==0)
    {
        LoginHuiFuViewController *loginHFVC = [[LoginHuiFuViewController alloc]init];
        [self.navigationController pushViewController:loginHFVC animated:YES];
    }
    else
    {
        ChangeHFViewController *changeHFVC = [[ChangeHFViewController alloc]init];
        [self.navigationController pushViewController:changeHFVC animated:YES];
    }
}

- (void)share
{
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults]objectForKey:kUserMsg];
    NSString *msg = [NSString stringWithFormat:@"%@分享 %@",dic[@"name"],_updataStr];
    if(_updataStr==nil)
    {
        msg = [NSString stringWithFormat:@"%@分享 %@",dic[@"name"],@"https//www.xr58.com"];
    }
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"5542defa67e58ed9890060f8"
                                      shareText:msg
                                     shareImage:[UIImage imageNamed:@"logo_tu.png"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToQQ,UMShareToSms,UMShareToQzone,UMShareToSina,UMShareToTencent,UMShareToWechatTimeline,nil]
                                       delegate:self];
}

//弹出列表方法presentSnsIconSheetView需要设置delegate为self
-(BOOL)isDirectShareInIconActionSheet
{
    return YES;
}

-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}

//退出登录提醒框
- (void)quite
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"确定退出" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        //退出登录
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:kCustomerId];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:kUserMsg];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:kIsRemembPsd];
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        loginVC.fromFlag = 1;
        [self.navigationController pushViewController:loginVC animated:YES];
//        exit(0);
    }
}

#pragma mark 检查更新
- (void)checkUpdata
{
    //    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    //    [parameter setObject:@"id" forKey:@"959293324"];
    AFHTTPSessionManager *_manager = [[AFHTTPSessionManager alloc]init];
    [_manager POST:@"http://itunes.apple.com/lookup?id=1001047776" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        [self verionback:responseObject];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
        //        [_mbProgressHUD hide:YES];
        //            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"网络不稳定" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        //            [alert show];
    }];
}

- (void)verionback:(id)response
{
    NSDictionary *dic = (NSDictionary *)response;
    MyLog(@"%@",dic);
    //    //    SBJsonParser *sbParser = [[SBJsonParser alloc]init];
    //    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:dic[@"msg"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    //    [alert show];
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    
    //CFShow((__bridge CFTypeRef)(infoDic));
    
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleVersion"];
    NSLog(@"----%@----",currentVersion);
    
    NSArray *infoArray = [dic objectForKey:@"results"];
    
    if ([infoArray count]) {
        
        NSDictionary *releaseInfo = [infoArray objectAtIndex:0];
        
//        NSString *lastVersion = [releaseInfo objectForKey:@"version"];
        _updataStr = [releaseInfo objectForKey:@"trackViewUrl"];
        [[NSUserDefaults standardUserDefaults]setObject:_updataStr forKey:kDownloadUrl];
        MyLog(@"%@",_updataStr);
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
