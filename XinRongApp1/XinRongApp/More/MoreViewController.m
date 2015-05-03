//
//  MoreViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/3/18.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "MoreViewController.h"

#import "AboutUsViewController.h"
#import "VersionsViewController.h"
#import "HelpViewController.h"
#import "FeedbackViewController.h"
@interface MoreViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSString *updataStr;
@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"更多";
    
    //初始化试图
    [self initSubview];
}

//把视图初始化
- (void)initSubview
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight-49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = KLColor(246, 246, 246);
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

#pragma mark 列表数据代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 4;
    }
    else
    {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *const identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (indexPath.section==0)
    {
        switch (indexPath.row)
        {
            case 0:
            {
                UIImage *icon = [UIImage imageNamed:@"aboutUs.png"];
                CGSize iconSize = CGSizeMake(30, 30);
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
                cell.textLabel.text = @"关于我们";
                break;
            }
            case 1:
            {
                UIImage *icon = [UIImage imageNamed:@"feedback.png"];
                CGSize iconSize = CGSizeMake(30, 30);
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
                cell.textLabel.text = @"用户反馈";
                break;
            }
            case 2:
            {
                UIImage *icon = [UIImage imageNamed:@"help.png"];
                CGSize iconSize = CGSizeMake(30, 30);
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
                cell.textLabel.text = @"帮助中心";
                break;
            }
            case 3:
            {
                UIImage *icon = [UIImage imageNamed:@"banBenMsg.png"];
                CGSize iconSize = CGSizeMake(30, 30);
                UIGraphicsBeginImageContextWithOptions(iconSize, NO, 0.0);
                CGRect rect = CGRectMake(0, 0, iconSize.width, iconSize.height);
                [icon drawInRect:rect];
                cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                //箭头
                //            UIImage *jianTouImg = [UIImage imageNamed:@"jianTou.png"];
                //            UIImageView *jianTimgView = [[UIImageView alloc]initWithImage:jianTouImg];
                //            jianTimgView.frame = CGRectMake(0, 0, jianTouImg.size.width/2, jianTouImg.size.height/2);
                //            cell.accessoryView = jianTimgView;
                cell.textLabel.text = @"版本信息";
                break;
            }
            default:
                break;
        }
    }
    else
    {
        UIImage *icon = [UIImage imageNamed:@"clear.png"];
        CGSize iconSize = CGSizeMake(30, 30);
        UIGraphicsBeginImageContextWithOptions(iconSize, NO, 0.0);
        CGRect rect = CGRectMake(0, 0, iconSize.width, iconSize.height);
        [icon drawInRect:rect];
        cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        //箭头
//        UIImage *jianTouImg = [UIImage imageNamed:@"jianTou.png"];
//        UIImageView *jianTimgView = [[UIImageView alloc]initWithImage:jianTouImg];
//        jianTimgView.frame = CGRectMake(0, 0, jianTouImg.size.width/2, jianTouImg.size.height/2);
//        cell.accessoryView = jianTimgView;
        cell.textLabel.text = @"清理缓存";
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==0) {
        return 15;
    }
    else
    {
        return 1;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                //关于我们
                AboutUsViewController *aboutUsVC = [[AboutUsViewController alloc]init];
                [self.navigationController pushViewController:aboutUsVC animated:YES];
                break;
            }
            case 1:
            {
                //用户反馈
                FeedbackViewController *feedbackVC = [[FeedbackViewController alloc]init];
                [self.navigationController pushViewController:feedbackVC animated:YES];
                break;
            }
            case 2:
            {
                //帮助
                HelpViewController *helpVC = [[HelpViewController alloc]init];
                [self.navigationController pushViewController:helpVC animated:YES];
                break;
            }
            case 3:
            {
                //版本信息
                [self checkUpdata];
                break;
            }
            default:
                break;
        }
    }
    else
    {
        //清理缓存
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"确定要清除缓存" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
        alert.tag = 100;
        [alert show];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

#pragma mark - alertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==10000)
    {
        
        if (buttonIndex==1) {
            
            NSURL *url = [NSURL URLWithString:_updataStr];
            
            [[UIApplication sharedApplication]openURL:url];
            
        }
        
    }
    if (alertView.tag==100) {
        if (buttonIndex) {
            [self showWithProgress];
        }
    }
}

#pragma mark 检查更新
- (void)checkUpdata
{
    //    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    //    [parameter setObject:@"id" forKey:@"959293324"];
    [SVProgressHUD showImage:[UIImage imageWithName:kLogo] status:@"检查更新中..."];
    AFHTTPSessionManager *_manager = [[AFHTTPSessionManager alloc]init];
    [_manager POST:@"http://itunes.apple.com/lookup?id=943690767" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        [self verionback:responseObject];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
        [SVProgressHUD dismiss];
    }];
}

- (void)verionback:(id)response
{
    NSDictionary *dic = (NSDictionary *)response;
    MyLog(@"%@",dic);
    [SVProgressHUD dismiss];
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
        
        NSString *lastVersion = [releaseInfo objectForKey:@"version"];
        _updataStr = [releaseInfo objectForKey:@"trackViewUrl"];
        MyLog(@"%@",_updataStr);
        
        if (![lastVersion isEqualToString:currentVersion]) {
            
            //trackViewURL = [releaseInfo objectForKey:@"trackVireUrl"];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更新" message:@"有新的版本更新，是否前往更新？" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:@"更新", nil];
            
            alert.tag = 10000;
            
            [alert show];
            
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更新" message:@"当前为最新版本" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil];
            
            alert.tag = 10001;
            
            [alert show];
        }
    }
}

static float progress = 0.0f;

- (void)showWithProgress
{
    progress = 0.0f;
    [SVProgressHUD setBackgroundColor:kZhuTiColor];
    [SVProgressHUD showProgress:0 status:@"清理中..."];
    [self performSelector:@selector(increaseProgress) withObject:nil afterDelay:0.3f];
}

- (void)increaseProgress {
    progress+=0.1f;
    [SVProgressHUD showProgress:progress status:@"清理中..."];
    
    if(progress < 1.0f)
        [self performSelector:@selector(increaseProgress) withObject:nil afterDelay:0.3f];
    else
        [self performSelector:@selector(showSuccess) withObject:nil afterDelay:0.4f];
}

- (void)showSuccess
{
    [SVProgressHUD showSuccessWithStatus:@"清理完成"];
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
