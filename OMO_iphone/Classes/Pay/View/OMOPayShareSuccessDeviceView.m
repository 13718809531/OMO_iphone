//
//  OMOPayShareSuccessDeviceView.m
//  OMO_iphone
//
//  Created by wy on 2018/10/18.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOPayShareSuccessDeviceView.h"
/**  */
#import "OMOAssessmentPayAlertGoodsCell.h"
/**  */
#import "OMOBuyDevicesVC.h"

@interface OMOPayShareSuccessDeviceView()
<UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout,
UICollectionViewDataSourcePrefetching>

/**  */
@property (nonatomic, strong)NSArray <OMOKangFuBaoMtItemModel *> *items;
/**  */
@property (nonatomic, strong)UILabel *titleLab;
/**  */
@property (nonatomic, strong)UILabel *detailLab;
// 展示视图
@property(strong,nonatomic)UICollectionView *collectionView;
/** 购买辅具 */
@property (nonatomic, strong)UIButton *buyDeviceBtn;

@end

static NSString *OMOAssessmentPayAlertGoodsCellID = @"OMOAssessmentPayAlertGoodsCellID";

@implementation OMOPayShareSuccessDeviceView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        self.backgroundColor = WHITECOLORA(1);
        
        UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.lwb_width, lwb_smallMargin)];
        lineView1.backgroundColor = mainBackColor;
        [self addSubview:lineView1];

        [self addSubview:self.titleLab];
        [self addSubview:self.detailLab];
        [self addSubview:self.buyDeviceBtn];
        [self addSubview:self.collectionView];
        
        UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, self.lwb_height - lwb_smallMargin, self.lwb_width, lwb_smallMargin)];
        lineView2.backgroundColor = mainBackColor;
        [self addSubview:lineView2];
    }
    return self;
}
- (void)setKangFuBaoModel:(OMOKangFuBaoModel *)kangFuBaoModel{
    
    _kangFuBaoModel = kangFuBaoModel;
    
    _items = kangFuBaoModel.mt_item;
    
    [self.collectionView reloadData];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [_titleLab sizeToFit];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(lwb_margin * 2);
        make.top.equalTo(self.mas_top).offset(lwb_margin * 2);
    }];
    
    [_detailLab sizeToFit];
    [_detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.mas_right).offset(-lwb_margin * 2);
        make.left.equalTo(self.mas_left).offset(lwb_margin * 2);
        make.top.equalTo(self.titleLab.mas_bottom).offset(lwb_margin);
    }];
    
    [_buyDeviceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(120.f, 30.f));
        make.centerY.equalTo(self.titleLab.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-lwb_margin*2);
    }];
}

- (UILabel *)titleLab{
    
    if(_titleLab == nil){
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.textColor = textColour;
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.font = BoldFont(20);
        _titleLab.text = @"推荐训练辅具";
    }
    return _titleLab;
}
- (UILabel *)detailLab{
    
    if(_detailLab == nil){
        
        _detailLab = [[UILabel alloc]init];
        _detailLab.textColor = DetailColor;
        _detailLab.textAlignment = NSTextAlignmentLeft;
        _detailLab.text = @"元新康复辅具比市面上的价格便宜,仅限APP用户购买!";
        _detailLab.font = defoultFont;
    }
    return _detailLab;
}
- (UIButton *)buyDeviceBtn{
    
    if(_buyDeviceBtn == nil){
        
        _buyDeviceBtn = [[UIButton alloc]init];
        _buyDeviceBtn.backgroundColor = backColor;
        _buyDeviceBtn.titleLabel.font = navTitleFont;
        [_buyDeviceBtn setTitle:@"购买辅具" forState:UIControlStateNormal];
        [_buyDeviceBtn setTitleColor:WHITECOLORA(1) forState:UIControlStateNormal];
        _buyDeviceBtn.layer.cornerRadius = 15.f;
        [_buyDeviceBtn addTarget:self action:@selector(omo_neebDevice:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buyDeviceBtn;
}
- (UICollectionView *)collectionView{
    
    if(_collectionView == nil){
        
        UICollectionViewFlowLayout *collectionLayout = [[UICollectionViewFlowLayout alloc]init];
        
        collectionLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 100, SCREENW, (SCREENW - lwb_margin * 4) * 0.5) collectionViewLayout:collectionLayout];
        
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
    buyDevicesVC.numType = 2;
    buyDevicesVC.buyType = 2;
    buyDevicesVC.kangFuBaoModel = _kangFuBaoModel;
    [[OMOIphoneManager getCurrentVC].navigationController pushViewController:buyDevicesVC animated:YES];
}
@end
