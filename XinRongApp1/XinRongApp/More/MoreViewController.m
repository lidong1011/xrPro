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
#import "FeedbackViewController.h"
@interface MoreViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
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
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
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
            UIImage *icon = [UIImage imageNamed:@"banBenMsg.png"];
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
            cell.textLabel.text = @"版本信息";
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
        case 4:
        {
            UIImage *icon = [UIImage imageNamed:@"clear.png"];
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
            cell.textLabel.text = @"清理缓存";
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
            //关于我们
            AboutUsViewController *aboutUsVC = [[AboutUsViewController alloc]init];
            [self.navigationController pushViewController:aboutUsVC animated:YES];
            break;
        }
        case 1:
        {
            //版本信息
            VersionsViewController *versionsVC = [[VersionsViewController alloc]init];
            [self.navigationController pushViewController:versionsVC animated:YES];
            break;
        }
        case 2:
        {
            //检查更新
            AboutUsViewController *aboutUsVC = [[AboutUsViewController alloc]init];
            [self.navigationController pushViewController:aboutUsVC animated:YES];
            break;
        }
        case 3:
        {
            //用户反馈
            FeedbackViewController *feedbackVC = [[FeedbackViewController alloc]init];
            [self.navigationController pushViewController:feedbackVC animated:YES];
            break;
        }
        case 4:
        {
            //清理缓存
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"确定要清除缓存" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
            [alert show];
            break;
        }

        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

#pragma mark - alertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex) {
        [self showWithProgress];
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
