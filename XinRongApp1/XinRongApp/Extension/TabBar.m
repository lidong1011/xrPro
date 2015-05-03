//
//  TabBar.m
//  CustomTabBar-0818
//
//  Created by apple on 14-8-18.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "TabBar.h"
#import "Items.h"
#import "MyBarButton.h"
@interface TabBar ()
{
    UIImageView *bgImageView;
    NSMutableArray *_btnMArray;
}
@end

@implementation TabBar
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        bgImageView=[[UIImageView alloc]initWithFrame:self.bounds];
        bgImageView.image=[UIImage imageNamed:@"TabBarBackground.png"];
//        [self addSubview:bgImageView];
    }
    _btnMArray = [NSMutableArray array];
    return self;
}

- (void)setSelectIndex:(NSInteger)selectIndex
{
    UIButton *btn=_btnMArray[selectIndex];
    [self didClicked:btn];
    _selectIndex=selectIndex;
}

- (void)setBgImage:(UIImage *)bgImage
{
    bgImageView.image=bgImage;
    _bgImage=bgImage;
}

//- (void)setItemArray:(NSArray *)items
//{
//    CGFloat width=self.frame.size.width/items.count;
//    for (int i=0; i<items.count; i++)
//    {
//        Items *item=[items objectAtIndex:i];
//        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
//        btn.frame=CGRectMake(i*width, 0, width, self.frame.size.height);
//        [btn addTarget:self action:@selector(didClicked:) forControlEvents:UIControlEventTouchUpInside];
//        [btn setImage:item.selectImage forState:UIControlStateSelected];
//        btn.tag=i;
//        [btn setImage:item.image forState:UIControlStateNormal];
//        [self addSubview:btn];
//        
//        [_btnMArray addObject:btn];
//        //显示文字
////        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(i*width, self.frame.size.height-15, width, 15)];
////        label.text=item.title;
////        label.textAlignment=NSTextAlignmentCenter;
////        [self addSubview:label];
//    }
//}
//
//- (void)didClicked:(UIButton *)sender
//{
//    //遍历各个按钮，使所有按钮都变为未选中状态
//    for (UIButton *button in _btnMArray)
//    {
//        button.selected=NO;
//    }
//    sender.selected=YES;
//    if (_delegate&&[_delegate respondsToSelector:@selector(tabBar:didTag:)])
//    {
//        [_delegate tabBar:self didTag:sender.tag];
//    }
//}

- (void)setItemArray:(NSArray *)items
{
    CGFloat width=self.frame.size.width/items.count;
    for (int i=0; i<items.count; i++)
    {
        Items *item=[items objectAtIndex:i];
        MyBarButton *btn=[[MyBarButton alloc]init];
        btn.frame=CGRectMake(i*width, 0, width, self.frame.size.height);
        btn.item = item;
        [btn addTarget:self action:@selector(didClicked:) forControlEvents:UIControlEventTouchUpInside];
//        [btn setImage:item.selectImage forState:UIControlStateSelected];
        btn.tag=i;
//        [btn setImage:item.image forState:UIControlStateNormal];
        [self addSubview:btn];
        
        [_btnMArray addObject:btn];
        //显示文字
        //        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(i*width, self.frame.size.height-15, width, 15)];
        //        label.text=item.title;
        //        label.textAlignment=NSTextAlignmentCenter;
        //        [self addSubview:label];
    }
}

- (void)didClicked:(MyBarButton *)sender
{
    //遍历各个按钮，使所有按钮都变为未选中状态
    for (MyBarButton *button in _btnMArray)
    {
        button.isSelect=NO;
    }
    sender.isSelect=YES;
    if (_delegate&&[_delegate respondsToSelector:@selector(tabBar:didTag:)])
    {
        [_delegate tabBar:self didTag:sender.tag];
    }
}


@end
