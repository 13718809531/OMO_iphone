//
//  OMOBuyPlanListVC.m
//  OMO_iphone
//
//  Created by wy on 2018/10/19.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOBuyPlanListVC.h"
#import "OMOBuyPlanCell.h"
#import "OMOBuyPlanModel.h"

@interface OMOBuyPlanListVC ()
<UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout>

@property (nonatomic , assign)NSInteger page;
@property(strong,nonatomic)UICollectionView *collectionView;
@property(strong,nonatomic)NSMutableArray <OMOBuyPlanModel *> *dataSouce;

@end

static NSString *OMOBuyPlanCellID = @"OMOBuyPlanCellID";

@implementation OMOBuyPlanListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _page = 0;
    _dataSouce = [NSMutableArray array];
    
    [self md_requestPhaseData];
    
    [self creatBar];
    [self.bar addLeftButtonWithImage:[UIImage imageNamed:@"App_Back"]];
    [self.bar addTitltLabelWithText:@"我的购买方案" Font:navTitleFont];
    
    [self.view addSubview:self.collectionView];
}
#pragma mark ------- 请求列表数据 -----------
- (void)md_requestPhaseData{
    
    __weak typeof(self) weakSelf = self;
    
    [[OMONetworkManager sharedData]postWithURLString:@"20008" parameters:nil success:^(id responseObject) {
        
        if(responseObject){
            
            NSDictionary *dataSouce = (NSDictionary *)responseObject;
            
            [weakSelf.collectionView.mj_footer endRefreshing];
            
            NSArray *array = [NSArray arrayWithArray:[OMOBuyPlanModel mj_objectArrayWithKeyValuesArray:dataSouce[@"pe_order_list"]]];
            
            if(array.count < 10){
                
                [weakSelf.collectionView.mj_footer endRefreshingWithNoMoreData];
                weakSelf.collectionView.mj_footer.hidden = YES;
            }else{
                
                [weakSelf.collectionView.mj_footer resetNoMoreData];
                weakSelf.collectionView.mj_footer.hidden = NO;
            }
            if(weakSelf.page == 0){
                
                weakSelf.dataSouce = [NSMutableArray arrayWithArray:array];
            }else{
                
                [weakSelf.dataSouce addObjectsFromArray:array];
            }
            [weakSelf.collectionView reloadData];
        }
    } failure:^(NSError *error) {
        
        [MBProgress hideAllHUD];
    }];
}
- (UICollectionView *)collectionView{
    if(_collectionView == nil){
        
        UICollectionViewFlowLayout *collectionLayout = [[UICollectionViewFlowLayout alloc]init];
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, IphoneY, SCREENW, SCREENH - IphoneY) collectionViewLayout:collectionLayout];
        
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
        
        [_collectionView registerClass:[OMOBuyPlanCell class] forCellWithReuseIdentifier:OMOBuyPlanCellID];
        
        __weak typeof(self) weakSelf = self;
        // 上拉刷新
        _collectionView.mj_footer = [MJRefreshAutoNormalFooter  footerWithRefreshingBlock:^{
            
            weakSelf.page ++;
            
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
    
    OMOBuyPlanCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:OMOBuyPlanCellID forIndexPath:indexPath];
    
    cell.buyPlanModel = _dataSouce[indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
// iteam大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(SCREENW - lwb_margin * 4, 130);
}

// 分区间隔
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake( lwb_margin * 2, lwb_margin * 2, lwb_margin * 2, lwb_margin * 2);
}

// 行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return lwb_margin * 2;
}
// 列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return lwb_margin * 2;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
