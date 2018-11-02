//
//  OMOTraningPlanResouceVC.m
//  OMO_iphone
//
//  Created by wy on 2018/10/23.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOTrainingPlanResouceVC.h"
/**  */
#import "OMOTrainingPalnResouceCell.h"
/**  */
#import "OMOStratTrainingVC.h"
/**  */
#import "OMOTrainingDetailVC.h"

@interface OMOTrainingPlanResouceVC ()

<UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout>

@property(strong,nonatomic)UICollectionView *collectionView;
/**  */
@property (nonatomic, strong)UIButton *startBtn;

@end

static NSString *OMOTrainingPalnResouceCellID = @"OMOTrainingPalnResouceCellID";

@implementation OMOTrainingPlanResouceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatBar];
    [self.bar addLeftButtonWithImage:[UIImage imageNamed:@"App_Back"]];
    [self.bar addTitltLabelWithText:@"我的训练方案" Font:navTitleFont];
    
    [OMOIphoneManager sharedData].kangFuBao_name = _trainingPlanModel.treat_name;
    [self omo_requestPhaseData];
    [self.view addSubview:self.startBtn];
}
#pragma mark ------- 请求列表数据 -----------
- (void)omo_requestPhaseData{
    
    NSMutableDictionary *parmars = [NSMutableDictionary dictionary];
    parmars[@"pe_order_id"] = _trainingPlanModel.plan_id;;
    __weak typeof(self) weakSelf = self;
    
    [[OMONetworkManager sharedData]postWithURLString:@"20014" parameters:parmars success:^(id responseObject) {
        
        if(responseObject){
            
            NSDictionary *dataSouce = (NSDictionary *)responseObject;
            
            NSArray *array = [OMOTrainResourceModel mj_objectArrayWithKeyValuesArray:dataSouce[@"trainResourceList"]];
            
            weakSelf.trainingPlanModel.trainResourceList = array;
            
            [weakSelf.view addSubview:weakSelf.collectionView];
        }
    } failure:^(NSError *error) {
        
        [MBProgress hideAllHUD];
    }];
}
- (UIButton *)startBtn{
    if(_startBtn == nil){
        
        _startBtn = [[UIButton alloc]init];
        _startBtn.lwb_width = SCREENW - IFFitFloat6(lwb_pblicX) * 2;
        _startBtn.lwb_height = 40.f;
        _startBtn.lwb_centerX = self.view.lwb_centerX;
        _startBtn.lwb_bottom = SCREENH - 40;
        _startBtn.layer.masksToBounds = YES;
        _startBtn.layer.cornerRadius = 20.f;
        _startBtn.backgroundColor = backColor;
        [_startBtn setTitle:@"开始训练" forState:UIControlStateNormal];
        _startBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_startBtn setTitleColor:WHITECOLORA(1) forState:UIControlStateNormal];
        [_startBtn addTarget:self action:@selector(omo_stratTraining) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startBtn;
}
- (UICollectionView *)collectionView{
    if(_collectionView == nil){
        
        UICollectionViewFlowLayout *collectionLayout = [[UICollectionViewFlowLayout alloc]init];
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, IphoneY, SCREENW, SCREENH - IphoneY - 80) collectionViewLayout:collectionLayout];
        
        _collectionView.backgroundColor = WHITECOLORA(1);
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
        
        [_collectionView registerClass:[OMOTrainingPalnResouceCell class] forCellWithReuseIdentifier:OMOTrainingPalnResouceCellID];
    }
    return _collectionView;
}

// 分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}
// 行数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _trainingPlanModel.trainResourceList.count;
}
// cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    OMOTrainingPalnResouceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:OMOTrainingPalnResouceCellID forIndexPath:indexPath];
    
    cell.resouceModel = _trainingPlanModel.trainResourceList[indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    OMOTrainingDetailVC *trainingDetailVC = [[OMOTrainingDetailVC alloc]init];
    trainingDetailVC.resouceModel = _trainingPlanModel.trainResourceList[indexPath.row];
    [self.navigationController pushViewController:trainingDetailVC animated:YES];
}
// iteam大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(SCREENW - lwb_margin * 4, (SCREENW - lwb_margin * 4) / 2.5);
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
#pragma mark -------- 开始训练 ---------
- (void)omo_stratTraining{
    
    if(_trainingPlanModel.trainResourceList.count <= 0)return;
    
    OMOStratTrainingVC *stratTrainingVC = [[OMOStratTrainingVC alloc]init];
    stratTrainingVC.videoSouce = _trainingPlanModel.trainResourceList;
    [self.navigationController pushViewController:stratTrainingVC animated:YES];
}
@end
