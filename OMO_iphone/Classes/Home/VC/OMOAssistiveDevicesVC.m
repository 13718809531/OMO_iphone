//
//  OMOAssistiveDevicesVC.m
//  OMO_iphone
//
//  Created by wy on 2018/10/13.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOAssistiveDevicesVC.h"
#import "OMOAssessmentPayAlertGoodsCell.h"
/**  */
#import "OMODeviceDescView.h"

@interface OMOAssistiveDevicesVC ()<UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout,
UICollectionViewDataSourcePrefetching>

@property(strong,nonatomic)UICollectionView *collectionView;// 展示视图

@end

static NSString *OMOAssessmentPayAlertGoodsCellID = @"OMOAssessmentPayAlertGoodsCellID";

@implementation OMOAssistiveDevicesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatBar];
    [self.bar addLeftButtonWithImage:[UIImage imageNamed:@"App_Back"]];
    [self.bar addTitltLabelWithText:@"训练辅具" Font:navTitleFont];
    
    self.view.backgroundColor = mainBackColor;
}

- (void)setItems:(NSArray<OMOKangFuBaoMtItemModel *> *)items{
    
    _items = items;
    
    [self.view addSubview:self.collectionView];
}

- (UICollectionView *)collectionView{
    
    if(_collectionView == nil){
        
        UICollectionViewFlowLayout *collectionLayout = [[UICollectionViewFlowLayout alloc]init];
        
//        collectionLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, IphoneY, SCREENW, SCREENH - IphoneY) collectionViewLayout:collectionLayout];
        
        //自适应大小
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        
        _collectionView.backgroundColor = [UIColor clearColor];
        // 允许多选
        _collectionView.allowsMultipleSelection = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = NO;
        _collectionView.bounces = NO;// 默认为YES。如果该属性为YES，视图滚动时可以越过边界，越过边界后会被弹回。
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.alwaysBounceHorizontal = YES;
        
        // 分区cell
        [_collectionView registerClass:[OMOAssessmentPayAlertGoodsCell class] forCellWithReuseIdentifier:OMOAssessmentPayAlertGoodsCellID];
    }
    return _collectionView;
}
// 分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}
// 行数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    return _items.count;
}
// cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    OMOAssessmentPayAlertGoodsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:OMOAssessmentPayAlertGoodsCellID forIndexPath:indexPath];
    
    cell.mtItemModel = _items[indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    OMODeviceDescView *descView = [[OMODeviceDescView alloc]init];
    descView.itemModel = _items[indexPath.row];
    [descView show];
}

// iteam大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat width = (collectionView.lwb_width - lwb_margin * 3) * 0.5;
    return CGSizeMake(width, width * 0.8 + 80);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(lwb_margin, lwb_margin, lwb_margin, lwb_margin);
}
// 行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return lwb_margin;
}
// 列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return lwb_margin;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
