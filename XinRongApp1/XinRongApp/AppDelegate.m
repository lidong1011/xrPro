//
//  AppDelegate.m
//  XinRongApp
//
//  Created by 李冬强 on 15/3/9.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "AppDelegate.h"
#import "CustNavigationViewController.h"
#import "HomeViewController.h"
#import "TenderViewController.h"
#import "MoreViewController.h"
#import "AboutUsViewController.h"
#import "MyAccoutViewController.h"
#import "LoginViewController.h"
#import "IQKeyboardManager.h"
#import "AccountManager.h"
#import "Items.h"
#import "TabBar.h"

#import "UMSocial.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSnsPlatformManager.h"
#import "UMSocialSnsService.h"
#import "UMSocialConfig.h"

#import "MyGestureLockView.h"
#import "KKGestureLockView.h"
#import "LeadPageViewController.h"
@interface AppDelegate ()<TabBarDelegate,UIAlertViewDelegate,MyGestureLockViewDelegate>
@property (nonatomic, strong) MyGestureLockView *kkGview;
@property (nonatomic, strong) UITabBarController *tabBarCtr;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    [[NSUserDefaults standardUserDefaults]removeObjectForKey:kCustomerId];
//    [[NSUserDefaults standardUserDefaults]removeObjectForKey:kUserMsg];

    //设置友盟
    [self setUMSocial];
    
    [self keyboardSet];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //判断是否第一次登录
    NSString *path =[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/animation3.plist"];
    //获取路径文件内容
    NSDictionary *fileDic = [NSDictionary dictionaryWithContentsOfFile:path];
    //判断文件内容是否为空
    if (fileDic == nil)
    {
    //是第一次打开应用程序，开启第一次进入动画
        LeadPageViewController *leadVC = [[LeadPageViewController alloc]init];
        self.window.rootViewController = leadVC;
    //把文件写入
    fileDic = @{@"animation":@"YES"};
    [fileDic writeToFile:path atomically:YES];
    }
    else
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
        self.window.rootViewController = _tabBarCtr;
    }
    
    return YES;
}

- (void)setUMSocial
{
    [UMSocialData setAppKey:@"5542defa67e58ed9890060f8"];
    
    NSString *downloadUrl = [[NSUserDefaults standardUserDefaults]objectForKey:kDownloadUrl];
    if (downloadUrl==nil) {
        downloadUrl = @"http://www.xr58.com";
    }
    //设置微信AppId，设置分享url，默认使用友盟的网址
    [UMSocialWechatHandler setWXAppId:@"wxfcf5d93e67705541" appSecret:@"d08f2810cf6053090fc00d8b75111be2" url:downloadUrl];
    
    //设置手机QQ的AppId，指定你的分享url，若传nil，将使用友盟的网址
//    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.xr58.com"];
    [UMSocialQQHandler setQQWithAppId:@"1104665952" appKey:@"0wOVYu5pCrLGbfzr" url:downloadUrl];
    
    //    //设置支持没有客户端情况下使用SSO授权
    [UMSocialQQHandler setSupportWebView:YES];

//    
    //打开新浪微博的SSO开关
//    [UMSocialConfig setSupportSinaSSO:YES];
}

- (void)keyboardSet
{
    //Enabling keyboard manager
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager] setKeyboardDistanceFromTextField:10];
    //Enabling autoToolbar behaviour. If It is set to NO. You have to manually create UIToolbar for keyboard.
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    
    //Setting toolbar behavious to IQAutoToolbarBySubviews. Set it to IQAutoToolbarByTag to manage previous/next according to UITextField's tag property in increasing order.
    [[IQKeyboardManager sharedManager] setToolbarManageBehaviour:IQAutoToolbarBySubviews];
    
    //Resign textField if touched outside of UITextField/UITextView.
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
    
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

- (void)applicationWillResignActive:(UIApplication *)application {
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [_kkGview removeFromSuperview];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [UMSocialSnsService  applicationDidBecomeActive];
//    _actView = [[UIView alloc]initWithFrame:self.window.bounds];
//    _actView.backgroundColor = [UIColor greenColor];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(go)];
//    [_actView addGestureRecognizer:tap];
//    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    rightBtn.frame = CGRectMake(0, 100, 31, 31);
//    [rightBtn setBackgroundImage:[UIImage imageNamed:@"person.png"] forState:UIControlStateNormal];
//    
//    [rightBtn addTarget:self action:@selector(go) forControlEvents:UIControlEventTouchUpInside];
//    [_actView addSubview:rightBtn];
//    [_actView addGestureRecognizer:tap];
//    [self.window addSubview:_actView];
    NSString *code = [[NSUserDefaults standardUserDefaults]objectForKey:@"passcode"];
    NSString *custId = [[NSUserDefaults standardUserDefaults]objectForKey:kCustomerId];
    BOOL isOn = [[NSUserDefaults standardUserDefaults] boolForKey:@"gusetureState"];
    if (isOn&&code&&custId) {
        [self.window addSubview:[self popview]];
    }
}

- (MyGestureLockView *)popview
{
    //    CGFloat with = self.window.bounds.size.width;
    MyGestureLockView *kkGestureView = [[MyGestureLockView alloc]initWithFrame:self.window.bounds];
    kkGestureView.backgroundColor = [UIColor whiteColor];
    //    self.view.backgroundColor = [UIColor whiteColor];
    //    kkGestureView.normalGestureNodeImage = [UIImage imageNamed:@"gesture_node_normal.png"];
    //    kkGestureView.selectedGestureNodeImage = [UIImage imageNamed:@"gesture_node_selected.png"];
    //    kkGestureView.lineColor = [[UIColor orangeColor] colorWithAlphaComponent:0.3];
    //    kkGestureView.lineWidth = 12;
    kkGestureView.delegate = self;
    kkGestureView.titleLab.text = @"手势解锁";
    kkGestureView.center = self.window.center;
    //    [self.view addSubview:kkGestureView];
    _kkGview = kkGestureView;
    [_kkGview.forgetBut addTarget:self action:@selector(forgetAct) forControlEvents:UIControlEventTouchUpInside];
    _kkGview.forgetBut.hidden = NO;
    [_kkGview.forgetBut setTitle:@"忘记密码" forState:UIControlStateNormal];
    [_kkGview.forgetBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    return  kkGestureView;
}

- (void)forgetAct
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"请输入账户登录密码" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *loginPassword = [AccountManager shareManager].user.password;
    NSString *inputStr = [alertView textFieldAtIndex:0].text;
    if ([loginPassword isEqualToString:inputStr])
    {
        [_kkGview removeFromSuperview];
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"账户登录密码错误"];
    }
}

//- (void)gestureLockView:(KKGestureLockView *)gestureLockView didBeginWithPasscode:(NSString *)passcode{
//    NSLog(@"%@",passcode);
//}
//
//- (void)gestureLockView:(KKGestureLockView *)gestureLockView didEndWithPasscode:(NSString *)passcode{
//    NSLog(@"%@",passcode);
//    [_kkGview removeFromSuperview];
//}

- (void)myGestureLockView:(MyGestureLockView *)myGestureLockView didEndWithPasscode:(NSString *)passcode
{
    NSLog(@"%@",passcode);
    NSString *code = [[NSUserDefaults standardUserDefaults]objectForKey:@"passcode"];
    if ([passcode isEqualToString:code]) {
        [_kkGview removeFromSuperview];
    }
    else
    {
        _kkGview.titleLab.text = @"密码错误";
    }
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
}



- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

//- (void)applicationDidBecomeActive:(UIApplication *)application {
//    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//}

- (void)applicationWillTerminate:(UIApplication *)application {
   
//    [[NSUserDefaults standardUserDefaults]removeObjectForKey:kCustomerId];
//    [[NSUserDefaults standardUserDefaults]removeObjectForKey:kUserMsg];
}

@end
