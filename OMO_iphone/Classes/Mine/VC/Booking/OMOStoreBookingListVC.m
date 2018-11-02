//
//  OMOStoreBookingListVC.m
//  OMO_iphone
//
//  Created by wy on 2018/10/25.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOStoreBookingListVC.h"
/**  */
#import "OMOStoreBookingModel.h"
/**  */
#import "OMOStoreBookingCell.h"

@interface OMOStoreBookingListVC ()
<UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout,
OMOCancelStoreBookingDelegate>

@property(strong,nonatomic)UICollectionView *collectionView;
@property(strong,nonatomic)NSMutableArray <OMOStoreBookingModel *> *dataSouce;

@end

static NSString *OMOStoreBookingCellID = @"OMOStoreBookingCellID";

@implementation OMOStoreBookingListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _dataSouce = [NSMutableArray array];
    
    [self md_requestPhaseData];
    
    self.view.backgroundColor = mainBackColor;
}
#pragma mark ------- 请求列表数据 -----------
- (void)md_requestPhaseData{
    
    NSMutableDictionary *parmars = [NSMutableDictionary dictionary];
    if(_dataSouce.count > 0){
        
        OMOStoreBookingModel *model = _dataSouce.lastObject;
        parmars[@"last_id"] = model.booking_id;
    }
    
    __weak typeof(self) weakSelf = self;
    
    [[OMONetworkManager sharedData]postWithURLString:@"41008" parameters:parmars success:^(id responseObject) {
        
        if(responseObject){
            
            NSDictionary *dataSouce = (NSDictionary *)responseObject;
            
            [weakSelf.collectionView.mj_footer endRefreshing];
            
            NSArray *array = [NSArray arrayWithArray:[OMOStoreBookingModel mj_objectArrayWithKeyValuesArray:dataSouce[@"store_appoint_list"]]];
            
            NSDictionary *page = dataSouce[@"page"];
            NSInteger total_row = [page[@"total_row"] integerValue];
            NSInteger current_page_size = [page[@"current_page_size"] integerValue];
            if(current_page_size + weakSelf.dataSouce.count == total_row){
                
                [weakSelf.collectionView.mj_footer endRefreshingWithNoMoreData];
                weakSelf.collectionView.mj_footer.hidden = YES;
            }else{
                
                [weakSelf.collectionView.mj_footer resetNoMoreData];
                weakSelf.collectionView.mj_footer.hidden = NO;
            }
            
            [weakSelf.dataSouce addObjectsFromArray:array];
            
            if(weakSelf.dataSouce.count == 0){
                
                
            }else{
                
                if(weakSelf.collectionView.superview){
                    
                    [weakSelf.collectionView reloadData];
                }else{
                    
                    [weakSelf.view addSubview:weakSelf.collectionView];
                }
            }
        }
    } failure:^(NSError *error) {
        
        [MBProgress hideAllHUD];
        [weakSelf.collectionView.mj_footer endRefreshing];
    }];
}
- (UICollectionView *)collectionView{
    if(_collectionView == nil){
        
        UICollectionViewFlowLayout *collectionLayout = [[UICollectionViewFlowLayout alloc]init];
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREENW, self.view.lwb_height) collectionViewLayout:collectionLayout];
        
        _collectionView.backgroundColor = mainBackColor;
        _collectionView.scrollEnabled = YES;
        //自适应大小
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        
        // 允许多选
        _collectionView.allowsMultipleSelection = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = NO;
        _collectionView.bounces = YES;// 默认为YES。如果该属性为YES，视图滚动时可以越过边界，越过边界后会被弹回。
        _collectionView.alwaysBounceVertical = YES;
        //        _collectionView.alwaysBounceHorizontal = YES;
        
        [_collectionView registerClass:[OMOStoreBookingCell class] forCellWithReuseIdentifier:OMOStoreBookingCellID];
        
        __weak typeof(self) weakSelf = self;
        // 上拉刷新
        _collectionView.mj_footer = [MJRefreshAutoNormalFooter  footerWithRefreshingBlock:^{
            
            [weakSelf md_requestPhaseData];
        }];
        _collectionView.mj_footer.hidden = YES;
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
    
    OMOStoreBookingCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:OMOStoreBookingCellID forIndexPath:indexPath];
    
    cell.model = _dataSouce[indexPath.row];
    
    cell.delegate = self;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
// iteam大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(SCREENW - lwb_margin * 4, 270);
}

// 分区间隔
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake( 0, lwb_margin * 2, lwb_margin * 2, lwb_margin * 2);
}

// 行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return lwb_margin * 2;
}
// 列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return lwb_margin * 2;
}
#pragma mark ------ 取消门店预约 ------
- (void)OMOCancelStoreBookingWithBookingId:(NSString *)booking_id{
    
    NSDictionary *parmars = @{@"store_appoint_id":booking_id};
    
    __weak typeof(self) weakSelf = self;
    
    [[OMONetworkManager sharedData]postWithURLString:@"41009" parameters:parmars success:^(id responseObject) {
        
        if(responseObject){
            
            NSInteger index = 0;
            
            for (OMOStoreBookingModel *model in weakSelf.dataSouce) {
                
                if([model.booking_id isEqualToString:booking_id]){
                    
                    model.state = @"3";
                    index = [weakSelf.dataSouce indexOfObject:model];
                    break;
                }
            }
            [weakSelf.collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:index inSection:0], nil]];
        }
    } failure:^(NSError *error) {
        
        [MBProgress hideAllHUD];
    }];
}
@end
