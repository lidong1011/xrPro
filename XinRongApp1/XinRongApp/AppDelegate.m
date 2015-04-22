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
#import "IQKeyboardManager.h"
#import "Items.h"
#import "TabBar.h"

#import "UMSocial.h"

@interface AppDelegate ()<TabBarDelegate>
@property (nonatomic, strong) UITabBarController *tabBarCtr;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    [[NSUserDefaults standardUserDefaults]removeObjectForKey:kCustomerId];
//    [[NSUserDefaults standardUserDefaults]removeObjectForKey:kUserMsg];
    [UMSocialData setAppKey:@"507fcab25270157b37000010"];

    [self keyboardSet];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    HomeViewController *homeVC = [[HomeViewController alloc]init];
    CustNavigationViewController *homeNaviVC = [[CustNavigationViewController alloc]initWithRootViewController:homeVC];
    
    TenderViewController *accountVC = [[TenderViewController alloc]init];
    CustNavigationViewController *accountNavigtVC = [[CustNavigationViewController alloc]initWithRootViewController:accountVC];

    MoreViewController *moreVC = [[MoreViewController alloc]init];
    CustNavigationViewController *moreNavigtVC = [[CustNavigationViewController alloc]initWithRootViewController:moreVC];
    
    _tabBarCtr = [[UITabBarController alloc]init];
    _tabBarCtr.viewControllers = @[homeNaviVC,accountNavigtVC,moreNavigtVC];
    [_tabBarCtr.tabBar addSubview:[self makeTabBar]];
    self.window.rootViewController = _tabBarCtr;
    return YES;
}

- (void)keyboardSet
{
    //Enabling keyboard manager
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager] setKeyboardDistanceFromTextField:5];
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
                          @"xiangMu_norm.png",
                          @"moreBar_norm.png"];
    NSArray *selectImageArray=@[@"homeBar_select.png",
                                @"xiangMu_select.png",
                                @"moreBar_select.png"];
    NSArray *titleArray=@[@"首页",
                          @"项目",
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
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    
    if (url) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"你唤醒了您的应用--%@",url] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alertView show];
        
    }
    if ([[url scheme] isEqualToString:@"xr58app"]) {
        //处理链接
        return YES;
    }
    return NO;
    
//    return YES;
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
   
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:kCustomerId];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:kUserMsg];
}

@end
