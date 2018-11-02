//
//  OMOHomeHeadView.m
//  OMO_iphone
//
//  Created by wy on 2018/10/25.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOHomeHeadView.h"
#import "OMOHomeExclusiveCell.h"
/**  */
#import "OMOHomeExclusiveModel.h"
/**  */
#import "OMOBuyDevicesVC.h"
/**  */
#import "OMOHomeExclusiveDetailVC.h"

@interface OMOHomeHeadView()
<UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout,
UICollectionViewDataSourcePrefetching>

/**  */
@property (nonatomic, strong)NSArray <OMOHomeExclusiveModel *> *dataSouce;
@property(strong,nonatomic)UILabel *titleLab;//
@property(strong,nonatomic)UICollectionView *collectionView;// 展示视图

@end

static NSString *OMOHomeExclusiveCellID = @"OMOHomeExclusiveCellID";

@implementation OMOHomeHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        self.backgroundColor = WHITECOLORA(1);
        
        [self addSubview:self.titleLab];
        
        [self omo_requestDataSouce];
    }
    return self;
}
- (void)omo_requestDataSouce{
    
    __weak typeof(self) weakSelf = self;
    
    [[OMONetworkManager sharedData]postWithURLString:@"62000" parameters:nil success:^(id responseObject) {
        
        if(responseObject){
            
            NSDictionary *dataSouce = (NSDictionary *)responseObject;
            
            weakSelf.dataSouce = [OMOHomeExclusiveModel mj_objectArrayWithKeyValuesArray:dataSouce[@"service_item_list"]];
            
            [weakSelf addSubview:weakSelf.collectionView];
        }
    } failure:^(NSError *error) {
        
        [MBProgress hideAllHUD];
    }];
}
- (UILabel *)titleLab{
    
    if(_titleLab == nil){
        
        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(lwb_margin * 2, 0, self.lwb_width - lwb_margin * 4, 44)];
        _titleLab.text = @"专属服务";
        _titleLab.textColor = textColour;
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.font = navTitleFont;
    }
    return _titleLab;
}
- (UICollectionView *)collectionView{
    
    if(_collectionView == nil){
        
        UICollectionViewFlowLayout *collectionLayout = [[UICollectionViewFlowLayout alloc]init];
        
        collectionLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 44, SCREENW, self.lwb_height - 44 - lwb_margin * 2) collectionViewLayout:collectionLayout];
        
        //自适应大小
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        
        _collectionView.backgroundColor = WHITECOLORA(1);
        // 允许多选
        _collectionView.allowsMultipleSelection = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = NO;
        _collectionView.bounces = NO;// 默认为YES。如果该属性为YES，视图滚动时可以越过边界，越过边界后会被弹回。
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.alwaysBounceHorizontal = YES;
        
        // 分区cell
        [_collectionView registerClass:[OMOHomeExclusiveCell class] forCellWithReuseIdentifier:OMOHomeExclusiveCellID];
    }
    return _collectionView;
}
// 分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}
// 行数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    return _dataSouce.count;
}
// cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    OMOHomeExclusiveCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:OMOHomeExclusiveCellID forIndexPath:indexPath];
    
    cell.exclusiveModel = _dataSouce[indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    OMOHomeExclusiveDetailVC *exclusiveDetailVC = [[OMOHomeExclusiveDetailVC alloc]init];
    OMOHomeExclusiveModel *model = _dataSouce[indexPath.row];
    exclusiveDetailVC.exclusive_id = model.exclusive_id;
    [[OMOIphoneManager getCurrentVC].navigationController pushViewController:exclusiveDetailVC animated:YES];
}

// iteam大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(collectionView.lwb_width - lwb_margin * 5, collectionView.lwb_height);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, lwb_margin * 2, 0, lwb_margin * 2);
}// 列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return lwb_margin * 2;
}
// 行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}

@end
