//
//  OMOAssessmentPayAlertView.m
//  OMO_iphone
//
//  Created by wy on 2018/10/16.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOAssessmentPayAlertView.h"
#import "OMOAssessmentPayAlertHeadView.h"
#import "OMOAssessmentPayAlertGoodsCell.h"
/**  */
#import "OMOKangFuBaoMtItemModel.h"
/**  */
#import "OMOBuyDevicesVC.h"

@interface OMOAssessmentPayAlertView()
<UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout,
UICollectionViewDataSourcePrefetching>

/**  */
@property (nonatomic, strong)NSArray <OMOKangFuBaoMtItemModel *> *items;
@property (nonatomic,strong)UIButton * backButton;// 背部
/**  */
@property (nonatomic, strong)UIView *backView;
@property(strong,nonatomic)OMOAssessmentPayAlertHeadView *headView;// 头视图
@property(strong,nonatomic)UICollectionView *collectionView;// 展示视图
/** 不需要 */
@property (nonatomic, strong)UIButton *dontNeedBtn;
/** 需要 */
@property (nonatomic, strong)UIButton *needBtn;

@end

static NSString *OMOAssessmentPayAlertGoodsCellID = @"OMOAssessmentPayAlertGoodsCellID";

@implementation OMOAssessmentPayAlertView

- (instancetype)init{
    
    if(self = [super init]){
        
        self.frame = CGRectMake(0, 0, SCREENW, SCREENH);
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.backButton];
        [self addSubview:self.backView];
    }
    return self;
}
- (void)setKangFuBaoModel:(OMOKangFuBaoModel *)kangFuBaoModel{
    
    _kangFuBaoModel = kangFuBaoModel;
    
    _items = kangFuBaoModel.mt_item;
    
    [self.collectionView reloadData];
}
- (void)show{
    
    [[OMOIphoneManager getCurrentVC].view addSubview:self];
    //动画
    [UIView animateWithDuration:0.25 animations:^{
        
        self.backButton.alpha = 0.5;
        self.backView.lwb_bottom = SCREENH;
    }];
}
- (void)dissMiss{
    
    //动画
    [UIView animateWithDuration:0.25 animations:^{
        self.backView.lwb_y = SCREENH;
        self.backButton.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
#pragma mark - 懒加载
- (UIView *)backView{
    
    if(_backView == nil){
        
        CGFloat height = (SCREENW - lwb_margin * 4) * 0.5 + 40 + 80;
        
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREENH - height, SCREENW, height)];
        _backView.backgroundColor = mainBackColor;
        [_backView addSubview:self.headView];
        [_backView addSubview:self.collectionView];
        [_backView addSubview:self.dontNeedBtn];
        [_backView addSubview:self.needBtn];
    }
    return _backView;
}
-(UIButton *)backButton
{
    if (!_backButton) {
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = self.bounds;
        button.backgroundColor = [UIColor whiteColor];
        button.alpha = 0.4;
        [button addTarget:self action:@selector(dissMiss) forControlEvents:UIControlEventTouchUpInside];
        _backButton = button;
    }return _backButton;
}
- (OMOAssessmentPayAlertHeadView *)headView{
    
    if(_headView == nil){
        
        _headView = [[OMOAssessmentPayAlertHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREENW, 40)];
    }
    return _headView;
}
- (UIButton *)dontNeedBtn{
    
    if(_dontNeedBtn == nil){
        
        _dontNeedBtn = [[UIButton alloc]init];
        _dontNeedBtn.titleLabel.font = navTitleFont;
        _dontNeedBtn.tag = 100;
        [_dontNeedBtn setTitle:@"暂不需要" forState:UIControlStateNormal];
        [_dontNeedBtn setTitleColor:backColor forState:UIControlStateNormal];
        _dontNeedBtn.lwb_x = SCREENW * 0.5 - lwb_margin * 2 - 120.f;
        _dontNeedBtn.lwb_y = self.backView.lwb_height - 80;
        _dontNeedBtn.lwb_height = 40;
        _dontNeedBtn.lwb_width = 120.f;
        _dontNeedBtn.layer.masksToBounds = YES;
        _dontNeedBtn.layer.cornerRadius = 20.f;
        _dontNeedBtn.layer.borderWidth = 1.f;
        _dontNeedBtn.layer.borderColor = backColor.CGColor;
        [_dontNeedBtn addTarget:self action:@selector(omo_neebDevice:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dontNeedBtn;
}
- (UIButton *)needBtn{
    
    if(_needBtn == nil){
        
        _needBtn = [[UIButton alloc]init];
        _needBtn.titleLabel.font = navTitleFont;
        _needBtn.backgroundColor = backColor;
        _needBtn.tag = 200;
        [_needBtn setTitle:@"全部购买" forState:UIControlStateNormal];
        [_needBtn setTitleColor:WHITECOLORA(1) forState:UIControlStateNormal];
        _needBtn.lwb_x = SCREENW * 0.5 + lwb_margin * 2;
        _needBtn.lwb_y = self.backView.lwb_height - 80;
        _needBtn.lwb_height = 40;
        _needBtn.lwb_width = 120.f;
        _needBtn.layer.masksToBounds = YES;
        _needBtn.layer.cornerRadius = 20.f;
        [_needBtn addTarget:self action:@selector(omo_neebDevice:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _needBtn;
}
- (UICollectionView *)collectionView{
    
    if(_collectionView == nil){
        
        UICollectionViewFlowLayout *collectionLayout = [[UICollectionViewFlowLayout alloc]init];
        
        collectionLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 40, SCREENW, (SCREENW - lwb_margin * 4) * 0.5) collectionViewLayout:collectionLayout];
        
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
    

}

// iteam大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(collectionView.lwb_height - lwb_margin * 4, collectionView.lwb_height - lwb_margin * 4);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{

    return UIEdgeInsetsMake(lwb_margin * 2, lwb_margin * 2, lwb_margin * 2, lwb_margin * 2);
}
// 行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return lwb_margin * 4;
}
// 列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return lwb_margin * 4;
}
#pragma mark ------- 是否需要辅具 --------
- (void)omo_neebDevice:(UIButton *)sender{
    
    OMOBuyDevicesVC *buyDevicesVC = [[OMOBuyDevicesVC alloc]init];
    
    if(sender.tag == 100){
        
        buyDevicesVC.buyType = 1;
    }else if (sender.tag == 200){
        
        buyDevicesVC.buyType = 0;
    }
    buyDevicesVC.numType = _numType;
    buyDevicesVC.kangFuBaoModel = _kangFuBaoModel;
    
    [[OMOIphoneManager getCurrentVC].navigationController pushViewController:buyDevicesVC animated:YES];
}
@end
