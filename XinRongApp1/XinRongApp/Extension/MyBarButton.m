//
//  MyBarButton.m
//  艺甲名妆
//
//  Created by 李冬强 on 15-1-7.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "MyBarButton.h"

@implementation MyBarButton
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame])
    {
//        self.backgroundColor = [UIColor whiteColor];
        _imgView = [[UIImageView alloc]init];
        [self addSubview:_imgView];
//        self.layer.borderColor = [UIColor grayColor].CGColor;
//        self.layer.borderWidth = 0.5;
        _titleLab = [[UILabel alloc]init];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.font = [UIFont systemFontOfSize:10];
        [self addSubview:_titleLab];
    }
    return self;
}

- (void)setItem:(Items *)item
{
    _item = item;
    _titleLab.text = item.title;
    _imgView.image = _item.image;
}

- (void)setIsSelect:(BOOL)isSelect
{
    _isSelect = isSelect;
    if (_isSelect)
    {
        _imgView.image = _item.selectImage;
        _titleLab.textColor = kZhuTiColor;
    }
    else
    {
        _imgView.image = _item.image;
        _titleLab.textColor = KLColor(184, 186, 186);
    }
}

- (void)layoutSubviews
{
    CGFloat selfW = self.bounds.size.width;
    CGFloat selfH = self.bounds.size.height;
    _imgView.frame = CGRectMake(0, 0, 18, 18);
    _imgView.center = CGPointMake(selfW/2, selfH/4+5);
    _titleLab.frame = CGRectMake(0, _imgView.bottom, selfW, selfH/2);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
