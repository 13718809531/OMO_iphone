//
//  OMOOfflinePlanListVC.m
//  OMO_iphone
//
//  Created by wy on 2018/10/19.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOOfflinePlanListVC.h"
/**  */
#import "OMOTrainingPlanModel.h"
/**  */
#import "OMOTrainingPlanCell.h"
/**  */
#import "OMOTrainingPlanResouceVC.h"
/**  */
#import "OMONoAssessmentDataView.h"
/**  */
#import "OMOSelectGenderVC.h"
/**  */
#import "OMOSelectBirthdayVC.h"
/**  */
#import "OMOSelectPartsVC.h"

@interface OMOOfflinePlanListVC ()
<UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout>

/**  */
@property (nonatomic, strong)OMONoAssessmentDataView *noDataView;
@property(strong,nonatomic)UICollectionView *collectionView;
@property(strong,nonatomic)NSMutableArray <OMOTrainingPlanModel *> *dataSouce;
/**  */
@property (nonatomic, strong)UIButton *startBtn;

@end

static NSString *OMOTrainingPlanCellID = @"OMOTrainingPlanCellID";

@implementation OMOOfflinePlanListVC

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    if([OMOIphoneManager sharedData].user_id.length <= 0){
        
        self.collectionView.hidden = YES;
        self.startBtn.hidden = YES;
        self.noDataView.hidden = NO;
    }else{
        
        self.collectionView.hidden = NO;
        self.startBtn.hidden = NO;
        self.noDataView.hidden = YES;
        [self md_requestPhaseData];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _dataSouce = [NSMutableArray array];
    
    [self.view addSubview:self.noDataView];
    
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.startBtn];
}
#pragma mark ------- 请求列表数据 -----------
- (void)md_requestPhaseData{
    
    NSMutableDictionary *parmars = [NSMutableDictionary dictionary];
    parmars[@"type"] = @1;
    if(_dataSouce.count > 0){
        
        OMOTrainingPlanModel *model = _dataSouce.lastObject;
        parmars[@"last_id"] = model.plan_id;
    }
    
    __weak typeof(self) weakSelf = self;
    
    [[OMONetworkManager sharedData]postWithURLString:@"20013" parameters:parmars success:^(id responseObject) {
        
        if(responseObject){
            
            NSDictionary *dataSouce = (NSDictionary *)responseObject;
            
            [weakSelf.collectionView.mj_footer endRefreshing];
            
            NSArray *array = [NSArray arrayWithArray:[OMOTrainingPlanModel mj_objectArrayWithKeyValuesArray:dataSouce[@"self_train_list"]]];
            
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
                
                weakSelf.collectionView.hidden = YES;
                weakSelf.startBtn.hidden = YES;
                weakSelf.noDataView.hidden = NO;
            }else{
                
                weakSelf.collectionView.hidden = NO;
                weakSelf.startBtn.hidden = NO;
                weakSelf.noDataView.hidden = YES;
                [weakSelf.collectionView reloadData];
            }
        }
    } failure:^(NSError *error) {
        
        [MBProgress hideAllHUD];
        [weakSelf.collectionView.mj_footer endRefreshing];
    }];
}
- (OMONoAssessmentDataView *)noDataView{
    
    if(_noDataView == nil){
        
        _noDataView = [[OMONoAssessmentDataView alloc]initWithFrame:CGRectMake(lwb_margin * 2, 0, self.view.lwb_width - lwb_margin * 4, IFFitFloat6(300))];
    }
    return _noDataView;
}
- (UIButton *)startBtn{
    
    if(_startBtn == nil){
        
        _startBtn = [[UIButton alloc]initWithFrame:CGRectMake(IFFitFloat6(lwb_pblicX), self.view.lwb_height - 60, SCREENW - IFFitFloat6(lwb_pblicX) * 2, 40)];
        _startBtn.backgroundColor = backColor;
        _startBtn.titleLabel.font = navTitleFont;
        [_startBtn setTitle:@"开始评估" forState:UIControlStateNormal];
        [_startBtn setTitleColor:WHITECOLORA(1) forState:UIControlStateNormal];
        _startBtn.layer.cornerRadius = 20.f;
        [_startBtn addTarget:self action:@selector(omo_toEvaluate) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startBtn;
}
- (UICollectionView *)collectionView{
    if(_collectionView == nil){
        
        UICollectionViewFlowLayout *collectionLayout = [[UICollectionViewFlowLayout alloc]init];
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREENW, self.view.lwb_height - 80) collectionViewLayout:collectionLayout];
        
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
        
        [_collectionView registerClass:[OMOTrainingPlanCell class] forCellWithReuseIdentifier:OMOTrainingPlanCellID];
        
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
    
    OMOTrainingPlanCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:OMOTrainingPlanCellID forIndexPath:indexPath];
    
    cell.trainModel = _dataSouce[indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    OMOTrainingPlanResouceVC *trainingPlanResouceVC = [[OMOTrainingPlanResouceVC alloc]init];
    trainingPlanResouceVC.trainingPlanModel = _dataSouce[indexPath.row];
    [self.navigationController pushViewController:trainingPlanResouceVC animated:YES];
}
// iteam大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(SCREENW - lwb_margin * 4, 120);
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
// 立即评估
- (void)omo_toEvaluate{
    
    if([OMOIphoneManager sharedData].user_id.length > 0){
        
        if([OMOIphoneManager sharedData].gender.length <= 0){
            
            OMOSelectGenderVC *selectGenderVC = [[OMOSelectGenderVC alloc]init];
            [[OMOIphoneManager getCurrentVC].navigationController pushViewController:selectGenderVC animated:YES];
        }else if ([OMOIphoneManager sharedData].birthday.length <= 0){
            
            OMOSelectBirthdayVC *selectBirthdayVC = [[OMOSelectBirthdayVC alloc]init];
            [[OMOIphoneManager getCurrentVC].navigationController pushViewController:selectBirthdayVC animated:YES];
        }else{
            
            OMOSelectPartsVC *selectPartsVC = [[OMOSelectPartsVC alloc]init];
            [[OMOIphoneManager getCurrentVC].navigationController pushViewController:selectPartsVC animated:YES];
        }
    }else{
        
        OMOSelectGenderVC *selectGenderVC = [[OMOSelectGenderVC alloc]init];
        [[OMOIphoneManager getCurrentVC].navigationController pushViewController:selectGenderVC animated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
