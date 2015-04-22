//
//  ChongZhiViewController.h
//  XinRongApp
//
//  Created by 李冬强 on 15/4/13.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "BaseViewController.h"

@interface ChongZhiViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIView *chongView;
@property (weak, nonatomic) IBOutlet UILabel *keYongELab;
@property (weak, nonatomic) IBOutlet UITextField *chongZJinTF;
@property (weak, nonatomic) IBOutlet UILabel *cZHouJinLab;
- (IBAction)chongZhiAct:(UIButton *)sender;

@end
