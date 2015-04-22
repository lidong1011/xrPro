//
//  SettingsViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/4/2.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "SettingsViewController.h"
#import "PersonSetViewController.h"
#import "UMSocial.h"
@interface SettingsViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"账户设置";
    
    //初始化试图
    [self initSubview];
}

//把视图初始化
- (void)initSubview
{
    UIButton *quiteBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    quiteBtn.frame = CGRectMake(40, 20, kWidth-2*40, kHScare(35));
    [quiteBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    quiteBtn.backgroundColor = KLColor(74, 180 , 220);
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
    return 5;
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
            UIImage *icon = [UIImage imageNamed:@"moreBar_select"];
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
            UIImage *icon = [UIImage imageNamed:@"moreBar_select"];
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
            cell.textLabel.text = @"汇付天下";
            break;
        }
        case 2:
        {
            UIImage *icon = [UIImage imageNamed:@"moreBar_select"];
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
            break;
        }
        case 3:
        {
            UIImage *icon = [UIImage imageNamed:@"moreBar_select"];
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
            break;
        }
        case 4:
        {
            UIImage *icon = [UIImage imageNamed:@"moreBar_select"];
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
            //版本信息
//            VersionsViewController *versionsVC = [[VersionsViewController alloc]init];
//            [self.navigationController pushViewController:versionsVC animated:YES];
            break;
        }
        case 2:
        {
            //检查更新
//            AboutUsViewController *aboutUsVC = [[AboutUsViewController alloc]init];
//            [self.navigationController pushViewController:aboutUsVC animated:YES];
            break;
        }
        case 3:
        {
            //用户反馈
//            FeedbackViewController *feedbackVC = [[FeedbackViewController alloc]init];
//            [self.navigationController pushViewController:feedbackVC animated:YES];
            break;
        }
        case 4:
        {
            [self share];
            break;
        }
            
        default:
            break;
    }
}

- (void)share
{
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"507fcab25270157b37000010"
                                      shareText:@"你要分享的文字"
                                     shareImage:[UIImage imageNamed:@"icon.png"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToQzone,nil]
                                       delegate:nil];

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
        exit(0);
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
