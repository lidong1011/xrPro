//
//  ParterViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/4/25.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "ParterViewController.h"
#import "PartnerDetailViewController.h"
@interface ParterViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *partnerNameArray;
@property (nonatomic, strong) NSArray *partnerUrlArray;
@end

@implementation ParterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"合作伙伴";
    
    //初始化数据
    [self initData];
    //初始化试图
    [self initSubview];
}

- (void)initData
{
    _partnerNameArray = @[@"汇付天下",@"华旅文化",@"电广传媒",@"汇博金控",@"通城典当"];
    _partnerUrlArray = @[@"http://www.chinapnr.com/",@"http://www.chinapnr.com/",@"电广传媒",@"汇博金控",@"通城典当"];
}

//把视图初始化
- (void)initSubview
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight) style:UITableViewStylePlain];
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
//            UIImage *icon = [UIImage imageNamed:@"aboutUs.png"];
//            CGSize iconSize = CGSizeMake(30, 30);
//            UIGraphicsBeginImageContextWithOptions(iconSize, NO, 0.0);
//            CGRect rect = CGRectMake(0, 0, iconSize.width, iconSize.height);
//            [icon drawInRect:rect];
//            cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
//            UIGraphicsEndImageContext();
            //箭头
            UIImage *jianTouImg = [UIImage imageNamed:@"jianTou.png"];
            UIImageView *jianTimgView = [[UIImageView alloc]initWithImage:jianTouImg];
            jianTimgView.frame = CGRectMake(0, 0, jianTouImg.size.width/2, jianTouImg.size.height/2);
            cell.accessoryView = jianTimgView;
            cell.textLabel.text = _partnerNameArray[indexPath.row];
            break;
        }
        case 1:
        {
//            UIImage *icon = [UIImage imageNamed:@"banBenMsg.png"];
//            CGSize iconSize = CGSizeMake(30, 30);
//            UIGraphicsBeginImageContextWithOptions(iconSize, NO, 0.0);
//            CGRect rect = CGRectMake(0, 0, iconSize.width, iconSize.height);
//            [icon drawInRect:rect];
//            cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
//            UIGraphicsEndImageContext();
            //箭头
            UIImage *jianTouImg = [UIImage imageNamed:@"jianTou.png"];
            UIImageView *jianTimgView = [[UIImageView alloc]initWithImage:jianTouImg];
            jianTimgView.frame = CGRectMake(0, 0, jianTouImg.size.width/2, jianTouImg.size.height/2);
            cell.accessoryView = jianTimgView;
            cell.textLabel.text = _partnerNameArray[indexPath.row];
            break;
        }
        case 2:
        {
//            UIImage *icon = [UIImage imageNamed:@"help.png"];
//            CGSize iconSize = CGSizeMake(30, 30);
//            UIGraphicsBeginImageContextWithOptions(iconSize, NO, 0.0);
//            CGRect rect = CGRectMake(0, 0, iconSize.width, iconSize.height);
//            [icon drawInRect:rect];
//            cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
//            UIGraphicsEndImageContext();
            //箭头
            UIImage *jianTouImg = [UIImage imageNamed:@"jianTou.png"];
            UIImageView *jianTimgView = [[UIImageView alloc]initWithImage:jianTouImg];
            jianTimgView.frame = CGRectMake(0, 0, jianTouImg.size.width/2, jianTouImg.size.height/2);
            cell.accessoryView = jianTimgView;
            cell.textLabel.text = _partnerNameArray[indexPath.row];
            break;
        }
        case 3:
        {
//            UIImage *icon = [UIImage imageNamed:@"feedback.png"];
//            CGSize iconSize = CGSizeMake(30, 30);
//            UIGraphicsBeginImageContextWithOptions(iconSize, NO, 0.0);
//            CGRect rect = CGRectMake(0, 0, iconSize.width, iconSize.height);
//            [icon drawInRect:rect];
//            cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
//            UIGraphicsEndImageContext();
            //箭头
            UIImage *jianTouImg = [UIImage imageNamed:@"jianTou.png"];
            UIImageView *jianTimgView = [[UIImageView alloc]initWithImage:jianTouImg];
            jianTimgView.frame = CGRectMake(0, 0, jianTouImg.size.width/2, jianTouImg.size.height/2);
            cell.accessoryView = jianTimgView;
            cell.textLabel.text = _partnerNameArray[indexPath.row];
            break;
        }
        case 4:
        {
//            UIImage *icon = [UIImage imageNamed:@"clear.png"];
//            CGSize iconSize = CGSizeMake(30, 30);
//            UIGraphicsBeginImageContextWithOptions(iconSize, NO, 0.0);
//            CGRect rect = CGRectMake(0, 0, iconSize.width, iconSize.height);
//            [icon drawInRect:rect];
//            cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
//            UIGraphicsEndImageContext();
            //箭头
            UIImage *jianTouImg = [UIImage imageNamed:@"jianTou.png"];
            UIImageView *jianTimgView = [[UIImageView alloc]initWithImage:jianTouImg];
            jianTimgView.frame = CGRectMake(0, 0, jianTouImg.size.width/2, jianTouImg.size.height/2);
            cell.accessoryView = jianTimgView;
            cell.textLabel.text = _partnerNameArray[indexPath.row];
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
    PartnerDetailViewController *detailVC = [[PartnerDetailViewController alloc]init];
    detailVC.titleString = _partnerNameArray[indexPath.row];
    detailVC.urlString = _partnerUrlArray[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
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
