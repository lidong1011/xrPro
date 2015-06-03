//
//  GuestureViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/5/18.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "GuestureViewController.h"
#import "MyGestureLockView.h"
#import "AccountManager.h"
@interface GuestureViewController ()<MyGestureLockViewDelegate,UIAlertViewDelegate>
@property (nonatomic, strong) MyGestureLockView *guestureView;
@property (nonatomic, assign) BOOL isChangePass;
@property (nonatomic, assign) BOOL isForgetPass;
@property (nonatomic, strong) NSString *passcode;
@property (nonatomic, assign) int numflag;
@end

@implementation GuestureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"安全设置";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"back.png" highlightIcon:nil imageScale:0.6 target:self action:@selector(back)];
    
    [self addSubview];
}

- (void)switchAct:(UISwitch *)sender
{
    [[NSUserDefaults standardUserDefaults]setBool:sender.isOn forKey:@"gusetureState"];
    if (sender.isOn) {
        _guestureView.hidden = NO;
    }
    else
    {
        _guestureView.hidden = YES;
    }
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)addSubview
{
    BOOL isOn = [[NSUserDefaults standardUserDefaults]boolForKey:@"gusetureState"];
    UISwitch *switchView = [[UISwitch alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    switchView.onTintColor = [UIColor greenColor];
    switchView.on = isOn;
    [switchView addTarget:self action:@selector(switchAct:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:switchView];
    _guestureView = [[MyGestureLockView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    _guestureView.backgroundColor = [UIColor whiteColor];
    //    self.view.backgroundColor = [UIColor whiteColor];
    //    kkGestureView.normalGestureNodeImage = [UIImage imageNamed:@"gesture_node_normal.png"];
    //    kkGestureView.selectedGestureNodeImage = [UIImage imageNamed:@"gesture_node_selected.png"];
    //    kkGestureView.lineColor = [[UIColor orangeColor] colorWithAlphaComponent:0.3];
    //    kkGestureView.lineWidth = 12;
    _guestureView.delegate = self;
//    _guestureView.center = self.window.center;
//    _guestureView.forgetBut.hidden = YES;
    if (isOn) {
        _guestureView.hidden = NO;
        if ([[NSUserDefaults standardUserDefaults]objectForKey:@"passcode"]) {
            [_guestureView.gestureView setHidden:YES];
            _guestureView.titleLab.text = @"";
            [_guestureView.forgetBut setTitle:@"修改手势" forState:UIControlStateNormal];
            [_guestureView.forgetBut addTarget:self action:@selector(changePass) forControlEvents:UIControlEventTouchUpInside];
        }
        else
        {
            _guestureView.titleLab.text = @"请设置手势";
        }
    }
    else
    {
        _guestureView.hidden = YES;
    }
    [self.view addSubview:_guestureView];
}

- (void)changePass
{
    _guestureView.gestureView.hidden = NO;
    _guestureView.titleLab.text = @"请输入原手势";
    [_guestureView.forgetBut setTitle:@"忘记手势" forState:UIControlStateNormal];
    [_guestureView.forgetBut addTarget:self action:@selector(forget) forControlEvents:UIControlEventTouchUpInside];
    _isChangePass = YES;
}

- (void)forget
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
        _guestureView.titleLab.text = @"请输入新手势";
        _numflag = 0;
        _isChangePass = NO;
        _passcode = @"";
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"passcode"];
        _guestureView.forgetBut.hidden = YES;
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"账户登录密码错误"];
    }
}

- (void)myGestureLockView:(MyGestureLockView *)myGestureLockView didEndWithPasscode:(NSString *)passcode
{
    NSLog(@"%@",passcode);
    if (_isChangePass == 0) {
        if ([_passcode isEqualToString:passcode])
        {
            [[NSUserDefaults standardUserDefaults]setObject:passcode forKey:@"passcode"];
            [SVProgressHUD showImage:nil status:@"手势设置成功"];
            [self back];
        }
        else
        {
            if (_numflag) {
                _guestureView.titleLab.text = @"两次手势不一致";
            }
            else
            {
                _guestureView.titleLab.text = @"确认密码";
                _passcode = passcode;
            }
            _numflag++;
        }
        
    }
    else
    {
        NSString *oldPasscode = [[NSUserDefaults standardUserDefaults]objectForKey:@"passcode"];
        if([passcode isEqualToString:oldPasscode])
        {
            _guestureView.titleLab.text = @"请设置新手势";
            _isChangePass = NO;
//            return;
        }
        else
        {
            _guestureView.titleLab.text = @"手势错误";
        }
//        if ([_passcode isEqualToString:passcode]) {
//            [[NSUserDefaults standardUserDefaults]setObject:passcode forKey:@"passcode"];
//            [SVProgressHUD showImage:nil status:@"手势设置成功"];
//            [self back];
//        }
//        else
//        {
//            _guestureView.titleLab.text = @"确认密码";
//        }
//        _passcode = passcode;
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
