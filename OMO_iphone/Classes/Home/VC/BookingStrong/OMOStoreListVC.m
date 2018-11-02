//
//  OMOStrongListVC.m
//  OMO_iphone
//
//  Created by wy on 2018/10/9.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOStoreListVC.h"
/** 门店model */
#import "OMOStoreModel.h"
//** 门店详情 */
#import "OMOStoreDetaisVC.h"
/** 模型UI */
#import "OMOStoreCell.h"

@interface OMOStoreListVC ()
<UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout>

/**  */
@property (nonatomic, strong)UICollectionView *collectionView;
/** 门店数据 */
@property (nonatomic, strong)NSMutableArray <OMOStoreModel *> *storeList;
/** 分页 */
@property (nonatomic,assign)NSInteger page;

@end

static NSString *OMOStoreCellID = @"OMOStoreCellID";

@implementation OMOStoreListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _page = -1;
    _storeList = [NSMutableArray array];
    [self creatBar];
    [self.bar addTitltLabelWithText:@"服务中心" Font:navTitleFont];
    [self.bar addLeftButtonWithImage:[UIImage imageNamed:@"App_Back"]];
    
    [self omo_requestStoreData];
    [self.view addSubview:self.collectionView];
}
- (void)omo_requestStoreData{
    
    NSDictionary *parmas = @{@"page":[NSString stringWithFormat:@"%ld",_page]};
    
    __weak typeof(self) weakSelf = self;
    
    [[OMONetworkManager sharedData]postWithURLString:@"41000" parameters:parmas success:^(id responseObject) {
        
        [weakSelf.collectionView.mj_footer endRefreshing];
        
        if(responseObject){
            
            NSDictionary *dataSouce = (NSDictionary *)responseObject;
            
            NSArray *array = [OMOStoreModel mj_objectArrayWithKeyValuesArray:dataSouce[@"store_list"]];
            
            if(array.count > 0){
                
                if(array.count == 10){
                    
                    [weakSelf.collectionView.mj_footer resetNoMoreData];
                    weakSelf.collectionView.mj_footer.hidden = NO;
                }else{
                    
                    [weakSelf.collectionView.mj_footer endRefreshingWithNoMoreData];
                    weakSelf.collectionView.mj_footer.hidden = YES;
                }
                [weakSelf.storeList addObjectsFromArray:array];
                [weakSelf.collectionView reloadData];
            }
        }
    } failure:^(NSError *error) {
        
        [MBProgress hideAllHUD];
    }];
}
- (UICollectionView *)collectionView{
    if(_collectionView == nil){
        
        //        self.automaticallyAdjustsScrollViewInsets = NO;
        
        UICollectionViewFlowLayout *collectionLayout = [[UICollectionViewFlowLayout alloc]init];
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, IphoneY, SCREENW, SCREENH - IphoneY) collectionViewLayout:collectionLayout];
        
        //自适应大小
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        
        _collectionView.backgroundColor = mainBackColor;
        // 允许多选
        _collectionView.allowsMultipleSelection = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = NO;
        _collectionView.bounces = YES;// 默认为YES。如果该属性为YES，视图滚动时可以越过边界，越过边界后会被弹回。
        _collectionView.alwaysBounceVertical = NO;
        _collectionView.alwaysBounceHorizontal = NO;
        
        [_collectionView registerClass:[OMOStoreCell class] forCellWithReuseIdentifier:OMOStoreCellID];
        
        __weak typeof(self) weakSelf = self;
        // 上拉刷新
        _collectionView.mj_footer = [MJRefreshAutoNormalFooter  footerWithRefreshingBlock:^{
            
            weakSelf.page ++;
            
            [weakSelf omo_requestStoreData];
            [weakSelf.collectionView.mj_footer  beginRefreshing];
        }];
    }
    return _collectionView;
}
#pragma mark --------- UICollectionViewDataSource -----------
// 分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}
// 行数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _storeList.count;
}
// cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
        
    OMOStoreCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:OMOStoreCellID forIndexPath:indexPath];
    
    cell.storeModel = _storeList[indexPath.row];
    
    return cell;
}

#pragma mark --------- UICollectionViewDelegate -----------
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    OMOStoreModel *storeModel = _storeList[indexPath.row];
    
    OMOStoreDetaisVC *storeDetaisVC = [[OMOStoreDetaisVC alloc]init];
    storeDetaisVC.storeModel = storeModel;
    [self.navigationController pushViewController:storeDetaisVC animated:YES];
}
#pragma mark --------- UICollectionViewDelegateFlowLayout -----------
// iteam大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(collectionView.lwb_width - lwb_margin * 4, IFFitFloat6(300));
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(lwb_margin * 2, lwb_margin * 2, lwb_margin * 2, lwb_margin * 2);
}
// 行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return lwb_margin;
}
// 列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
