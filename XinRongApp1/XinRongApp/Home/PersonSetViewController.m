//
//  PersonSetViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/4/2.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "PersonSetViewController.h"
#import "ChangePasswordViewController.h"
@interface PersonSetViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation PersonSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"个人设置";
    self.view.backgroundColor = KLColor(231, 231, 231);
    //初始化试图
    [self initSubview];
}

//把视图初始化
- (void)initSubview
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 5, kWidth, kHeight-5) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _tableView.backgroundColor = KLColor(231, 231, 231);
    [self.view addSubview:_tableView];
}

#pragma mark 列表数据代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *const identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSDictionary *msgDic = [[NSUserDefaults standardUserDefaults]objectForKey:kUserMsg];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.row)
    {
        case 0:
        {
            //箭头
            UIImage *jianTouImg = [UIImage imageNamed:@"jianTou.png"];
            UIImageView *jianTimgView = [[UIImageView alloc]initWithImage:jianTouImg];
            jianTimgView.frame = CGRectMake(0, 0, jianTouImg.size.width/2, jianTouImg.size.height/2);
//            cell.accessoryView = jianTimgView;
            NSString *name;
            if (msgDic[@"name"]) {
                name = [NSString stringWithFormat:@"用户名：%@",msgDic[@"name"]];
            }
            else
            {
                name = @"用户名：还未绑定汇付";
            }
            
            cell.textLabel.text = name;
            break;
        }
        case 1:
        {
            //箭头
            UIImage *jianTouImg = [UIImage imageNamed:@"jianTou.png"];
            UIImageView *jianTimgView = [[UIImageView alloc]initWithImage:jianTouImg];
            jianTimgView.frame = CGRectMake(0, 0, jianTouImg.size.width/2, jianTouImg.size.height/2);
            cell.accessoryView = jianTimgView;
            cell.textLabel.text = @"修改登录密码";
            break;
        }
        case 2:
        {
            //箭头
            UIImage *jianTouImg = [UIImage imageNamed:@"jianTou.png"];
            UIImageView *jianTimgView = [[UIImageView alloc]initWithImage:jianTouImg];
            jianTimgView.frame = CGRectMake(0, 0, jianTouImg.size.width/2, jianTouImg.size.height/2);
//            cell.accessoryView = jianTimgView;
            NSString *regstr = [NSString stringWithFormat:@"注册时间：%@",msgDic[@"regDate"]];
            cell.textLabel.text = regstr;
            break;
        }
        case 3:
        {
            //箭头
            UIImage *jianTouImg = [UIImage imageNamed:@"jianTou.png"];
            UIImageView *jianTimgView = [[UIImageView alloc]initWithImage:jianTouImg];
            jianTimgView.frame = CGRectMake(0, 0, jianTouImg.size.width/2, jianTouImg.size.height/2);
//            cell.accessoryView = jianTimgView;
            NSString *phone = [NSString stringWithFormat:@"手机号码：%@",msgDic[@"mobile"]];
            cell.textLabel.text = phone;
            break;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            //个人设置
//            PersonSetViewController *personSetVC = [[PersonSetViewController alloc]init];
//            [self.navigationController pushViewController:personSetVC animated:YES];
            break;
        }
        case 1:
        {
            //修改密码
            ChangePasswordViewController *changePWDVC = [[ChangePasswordViewController alloc]init];
            [self.navigationController pushViewController:changePWDVC animated:YES];
            break;
        }
        case 2:
        {
            //检查更新
            //            AboutUsViewController *aboutUsVC = [[AboutUsViewController alloc]init];
            //            [self.navigationController pushViewController:aboutUsVC animated:YES];
            break;
        }
        default:
            break;
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
