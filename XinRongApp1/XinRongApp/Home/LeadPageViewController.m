//
//  LeadPageViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/5/21.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "LeadPageViewController.h"
#import "AnimationView.h"
#import "CustNavigationViewController.h"
#import "HomeViewController.h"
#import "TenderViewController.h"
#import "MoreViewController.h"
#import "AboutUsViewController.h"
#import "MyAccoutViewController.h"

#import "Items.h"
#import "TabBar.h"
@interface LeadPageViewController ()<TabBarDelegate>
@property (nonatomic, strong) UITabBarController *tabBarCtr;
@end

@implementation LeadPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AnimationView *aniView = [[AnimationView alloc]initWithFrame:self.view.bounds];
    aniView.didSelectedView = ^(AnimationView *aniview,NSInteger i){
        [self pushTo];
    };
    [self.view addSubview:aniView];
}

- (void)pushTo
{
    //不是第一次打开应用程序.默认动画
    HomeViewController *homeVC = [[HomeViewController alloc]init];
    CustNavigationViewController *homeNaviVC = [[CustNavigationViewController alloc]initWithRootViewController:homeVC];

    MyAccoutViewController *accountVC = [[MyAccoutViewController alloc]init];
    CustNavigationViewController *accountNavigtVC = [[CustNavigationViewController alloc]initWithRootViewController:accountVC];

    MoreViewController *moreVC = [[MoreViewController alloc]init];
    CustNavigationViewController *moreNavigtVC = [[CustNavigationViewController alloc]initWithRootViewController:moreVC];

    _tabBarCtr = [[UITabBarController alloc]init];
    _tabBarCtr.viewControllers = @[homeNaviVC,accountNavigtVC,moreNavigtVC];
    [_tabBarCtr.tabBar addSubview:[self makeTabBar]];
    [self presentViewController:_tabBarCtr animated:YES completion:nil];
}

- (TabBar *)makeTabBar
{
    NSArray *imageArray=@[@"homeBar_norm.png",
                          @"person_nor.png",
                          @"moreBar_norm.png"];
    NSArray *selectImageArray=@[@"homeBar_select.png",
                                @"person_select.png",
                                @"moreBar_select.png"];
    NSArray *titleArray=@[@"首页",
                          @"账户",
                          @"更多"];
    NSMutableArray *itemsArray=[[NSMutableArray alloc]init];
    for (int i=0; i<imageArray.count; i++)
    {
        UIImage *image=[UIImage imageNamed:imageArray[i]];
        Items *item=[[Items alloc]initWithImage:image title:titleArray[i]];
        
        item.selectImage=[UIImage imageNamed:selectImageArray[i]];
        [itemsArray addObject:item];
    }
    TabBar *tabBar=[[TabBar alloc]initWithFrame:_tabBarCtr.tabBar.bounds];
    tabBar.itemArray=itemsArray;
    //RecommandationViewTitleBackground@2x
    tabBar.backgroundColor = [UIColor whiteColor];
    tabBar.selectIndex=0;
    tabBar.delegate = self;
    return tabBar;
}

- (void)tabBar:(TabBar *)tabBar didTag:(NSInteger)tag
{
    _tabBarCtr.selectedIndex=tag;
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
