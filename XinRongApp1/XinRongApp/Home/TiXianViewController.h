//
//  TiXianViewController.h
//  XinRongApp
//
//  Created by 李冬强 on 15/4/16.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "BaseViewController.h"

@interface TiXianViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *totalMoneyLab;
@property (weak, nonatomic) IBOutlet UILabel *keYongLab;
@property (weak, nonatomic) IBOutlet UILabel *keQuMonLab;
@property (weak, nonatomic) IBOutlet UITextField *inputMoneyLab;
@property (weak, nonatomic) IBOutlet UILabel *shouXuFenLab;
@property (weak, nonatomic) IBOutlet UITextField *jieFenChangTF;

@property (strong, nonatomic) IBOutlet UIView *jiFenView;
@property (strong, nonatomic) IBOutlet UIView *footView;

- (IBAction)jiFenBtnAct:(UIButton *)sender;
- (IBAction)tiXianBtn:(id)sender;

@end
