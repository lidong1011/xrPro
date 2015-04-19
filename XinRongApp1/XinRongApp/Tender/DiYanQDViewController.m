//
//  DiYanQDViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/4/13.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "DiYanQDViewController.h"
#import "PicturesCollectionViewCell.h"
#import "KLCoverView.h"
@interface DiYanQDViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIImageView *bigImgView;
@property (nonatomic, strong) KLCoverView *coverView;
@end
static NSString *reuseIdPicCell = @"PicturesCollectionViewCell";
@implementation DiYanQDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = _titleString;
//    self.navigationItem.title = @"抵押清单";
    [self initSubview];
}

- (void)initSubview
{
    //    self.view.backgroundColor = KLColor(<#r#>, <#g#>, <#b#>)
    UIButton *topBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (_vCflag == 0) {
        [topBtn setTitle:@"抵押清单" forState:UIControlStateNormal];
    }
    else
    {
        [topBtn setTitle:@"图片资料" forState:UIControlStateNormal];
    }
    [topBtn setTitleColor:kZhuTiColor forState:UIControlStateNormal];
    UIImage *btnBgImg = [UIImage imageNamed:@"danBaoTop.9.png"];
    [topBtn setBackgroundImage:btnBgImg forState:UIControlStateNormal];
    CGFloat space = 100;
    //    topBtn.frame = CGRectMake(kWScare(space), kNavigtBarH+20, kWidth-2*kWScare(space), (kWidth-2*kWScare(space)*btnBgImg.size.width/btnBgImg.size.height));
    topBtn.frame = CGRectMake(kWScare(space), kNavigtBarH+20, kWidth-2*kWScare(space), 30);
    [self.view addSubview:topBtn];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, topBtn.bottom+20, kWidth, kHeight-topBtn.bottom-20) collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    UINib *nib = [UINib nibWithNibName:reuseIdPicCell bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:reuseIdPicCell];
    self.collectionView.backgroundColor = [UIColor whiteColor];
//    [_collectionView registerClass:[PicturesCollectionViewCell class] forCellWithReuseIdentifier:reuseIdPicCell];
    [self.view addSubview:_collectionView];
    
    //cover
    _coverView = [[KLCoverView alloc]initWithFrame:CGRectMake(0, kNavigtBarH, kWidth, kHeight-kNavigtBarH)];
    _coverView.hidden = YES;
    [self.view addSubview:_coverView];
    
    //bigImg
    _bigImgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, kNavigtBarH+10, kWidth-2*10, kHeight-kNavigtBarH-20)];
    _bigImgView.userInteractionEnabled = YES;
    _bigImgView.hidden = YES;
    _bigImgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_bigImgView];
    
    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideBigImage)];
    [_bigImgView addGestureRecognizer:tap];
}

- (void)hideBigImage
{
    _bigImgView.hidden = YES;
    _coverView.hidden = YES;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_picArray.count == 0) {
        UILabel *tipLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kWidth, 100)];
        tipLab.center = self.view.center;
        tipLab.textAlignment = NSTextAlignmentCenter;
        tipLab.text = @"暂无图片资料";
        [self.view addSubview:tipLab];
    }
    return _picArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PicturesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdPicCell forIndexPath:indexPath];
    NSDictionary *picDic = _picArray[indexPath.row];
    NSString *imgURl = [kPicUrl stringByAppendingString:picDic[@"filePath"]];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imgURl] placeholderImage:[UIImage imageNamed:@""]];
    cell.imgNameLab.text = picDic[@"fileName"];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
// 定义每个Item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((kWidth-4*10)/3 , 100);
}

// 定义每个UICollectionView的margin
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"\nitem:%ld\nsection:%ld\nrow:%ld", indexPath.item, indexPath.section, indexPath.row);
    _bigImgView.hidden = NO;
    _coverView.hidden = NO;
    NSDictionary *picDic = _picArray[indexPath.row];
    NSString *imgURl = [kPicUrl stringByAppendingString:picDic[@"filePath"]];
    [_bigImgView sd_setImageWithURL:[NSURL URLWithString:imgURl] placeholderImage:[UIImage imageNamed:@""]];

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
