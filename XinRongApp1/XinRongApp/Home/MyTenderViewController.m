//
//  MyTenderViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/4/18.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "MyTenderViewController.h"
#import "MyTouZiViewController.h"
#import "MyZhaiQViewController.h"
@interface MyTenderViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation MyTenderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的投资";
    [self initSubview];
}

//把视图初始化
- (void)initSubview
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight-kNavigtBarH) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
}

#pragma mark 列表数据代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
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
//            cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            //箭头
            UIImage *jianTouImg = [UIImage imageNamed:@"jianTou.png"];
            UIImageView *jianTimgView = [[UIImageView alloc]initWithImage:jianTouImg];
            jianTimgView.frame = CGRectMake(0, 0, jianTouImg.size.width/2, jianTouImg.size.height/2);
            cell.accessoryView = jianTimgView;
            cell.textLabel.text = @"投资项目";
            break;
        }
        case 1:
        {
            UIImage *icon = [UIImage imageNamed:@"banBenMsg.png"];
            CGSize iconSize = CGSizeMake(30, 30);
            UIGraphicsBeginImageContextWithOptions(iconSize, NO, 0.0);
            CGRect rect = CGRectMake(0, 0, iconSize.width, iconSize.height);
            [icon drawInRect:rect];
//            cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            //箭头
            UIImage *jianTouImg = [UIImage imageNamed:@"jianTou.png"];
            UIImageView *jianTimgView = [[UIImageView alloc]initWithImage:jianTouImg];
            jianTimgView.frame = CGRectMake(0, 0, jianTouImg.size.width/2, jianTouImg.size.height/2);
            cell.accessoryView = jianTimgView;
            cell.textLabel.text = @"债权转让";
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
            //我的投资项目
            MyTouZiViewController *myTouZVC = [[MyTouZiViewController alloc]init];
            [self.navigationController pushViewController:myTouZVC animated:YES];
            break;
        }
        case 1:
        {
            //我的债权转让
            MyZhaiQViewController *myZhaiQVC = [[MyZhaiQViewController alloc]init];
            [self.navigationController pushViewController:myZhaiQVC animated:YES];
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
