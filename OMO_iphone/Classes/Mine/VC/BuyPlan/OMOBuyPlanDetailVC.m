//
//  OMOBuyPlanDetailVC.m
//  OMO_iphone
//
//  Created by wy on 2018/10/19.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOBuyPlanDetailVC.h"
/**  */
#import "OMOBuyPlanDetailModel.h"

/** 头部 */
#import "OMOBuyPalnDetailHeadView.h"
/**  */
#import "OMOBuyPlanMoneyCell.h"
/**  */
#import "OMOBuyPlanTotalPriceCell.h"
/**  */
#import "OMOBuyDetailCell.h"
/**  */
#import "OMOBuyPlanFootView.h"
/**  */
//#import "OMOBuyPlanBottomView.h"

@interface OMOBuyPlanDetailVC ()
<UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout,
UICollectionViewDataSourcePrefetching>
//OMOPlanOrderDelegate>

@property(strong,nonatomic)UICollectionView *collectionView;// 展示视图
/**  */
@property (nonatomic, strong)OMOBuyPlanDetailModel *model;
/** 头部数据 */
@property (nonatomic, strong)NSDictionary *headSouce;
/** 第一分区数据 */
@property (nonatomic, strong)NSArray *oneSectionSouce;
/** 第二分区数据 */
@property (nonatomic, strong)NSArray *twoSectionSouce;
/**  */
//@property (nonatomic, strong)OMOBuyPlanBottomView *bottomView;

@end

static NSString *OMOBuyPalnDetailHeadViewID = @"OMOBuyPalnDetailHeadViewID";
static NSString *OMOBuyPlanMoneyCellID = @"OMOBuyPlanMoneyCellID";
static NSString *OMOBuyPlanTotalPriceCellID = @"OMOBuyPlanTotalPriceCellID";
static NSString *OMOBuyDetailCellID = @"OMOBuyDetailCellID";
static NSString *OMOBuyPlanFootViewID = @"OMOBuyPlanFootViewID";

@implementation OMOBuyPlanDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatBar];
    [self.bar addLeftButtonWithImage:[UIImage imageNamed:@"App_Back"]];
    [self.bar addTitltLabelWithText:@"购买方案明细" Font:navTitleFont];
    
    [self omo_requestData];
}
- (void)omo_requestData{
    
    __weak typeof(self) weakSelf = self;
    
    [[OMONetworkManager sharedData]postWithURLString:@"20010" parameters:@{@"pe_order_id":_pe_order_id} success:^(id responseObject) {
        
        if(responseObject){
            
            NSDictionary *dataSouce = (NSDictionary *)responseObject;
            
            weakSelf.model = [OMOBuyPlanDetailModel mj_objectWithKeyValues:dataSouce[@"info"]];
            
            [weakSelf omo_setDataSouce];
        }
    } failure:^(NSError *error) {
        
        [MBProgress hideAllHUD];
    }];
}
- (void)omo_setDataSouce{
    
    _headSouce = @{@"cate":checkNull(_model.cate),@"content":checkNull(_model.content),@"pay_time":checkNull(_model.pay_time)};
    
    NSDictionary *dict1 = @{@"title":@"方案价",@"price":checkNull(_model.total_price)};
    NSDictionary *dict2 = @{@"title":@"健康豆抵扣",@"price":checkNull(_model.discount_price)};
    NSDictionary *dict3 = @{@"title":@"实付价",@"price":checkNull(_model.last_price)};
    _oneSectionSouce = @[dict1,dict2,dict3];
    
    NSDictionary *dic1 = @{@"title":@"订单号",@"detail":checkNull(_model.out_trade_no)};
    NSDictionary *dic2 = @{@"title":@"付款时间",@"detail":checkNull(_model.pay_time)};
    NSDictionary *dic3 = @{@"title":@"支付方式",@"detail":checkNull(_model.pay_type)};
    _twoSectionSouce = @[dic1,dic2,dic3];
    
    [self.view addSubview:self.collectionView];
    
//    if([_model.state isEqualToString:@"1"]){
//
//        [self.view addSubview:self.bottomView];
//    }
}
//- (OMOBuyPlanBottomView *)bottomView{
//
//    if(_bottomView == nil){
//
//        _bottomView = [[OMOBuyPlanBottomView alloc]init];
//        _bottomView.delegate = self;
//    }
//    return _bottomView;
//}
- (UICollectionView *)collectionView{
    if(_collectionView == nil){
        
        UICollectionViewFlowLayout *collectionLayout = [[UICollectionViewFlowLayout alloc]init];
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, IphoneY, SCREENW, SCREENH - IphoneY - 100) collectionViewLayout:collectionLayout];
        
        _collectionView.scrollEnabled = NO;
        //自适应大小
        //        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        
        _collectionView.backgroundColor = WHITECOLORA(1);
        // 允许多选
        //        _collectionView.allowsMultipleSelection = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = NO;
        _collectionView.bounces = NO;// 默认为YES。如果该属性为YES，视图滚动时可以越过边界，越过边界后会被弹回。
        //        _collectionView.alwaysBounceVertical = YES;
        //        _collectionView.alwaysBounceHorizontal = YES;
        
        // 头部
        [_collectionView registerClass:[OMOBuyPalnDetailHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:OMOBuyPalnDetailHeadViewID];
        // 第一分区cell
        [_collectionView registerClass:[OMOBuyPlanMoneyCell class] forCellWithReuseIdentifier:OMOBuyPlanMoneyCellID];
        [_collectionView registerClass:[OMOBuyPlanTotalPriceCell class] forCellWithReuseIdentifier:OMOBuyPlanTotalPriceCellID];
        // FOOT部
        [_collectionView registerClass:[OMOBuyPlanFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:OMOBuyPlanFootViewID];
        
        // 第2分区cell
        [_collectionView registerClass:[OMOBuyDetailCell class] forCellWithReuseIdentifier:OMOBuyDetailCellID];
    }
    return _collectionView;
}
// 分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    NSInteger count = 1;
    
    if([_model.state isEqualToString:@"2"]){
        
        count += 1;
    }
    return count;
}
// 行数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if(section == 0){
        
        return _oneSectionSouce.count;
    }else if (section == 1){
        
        return _twoSectionSouce.count;
    }
    return 0;
}
// cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0){
        
        if(indexPath.row == 0){
            
            OMOBuyPlanMoneyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:OMOBuyPlanMoneyCellID forIndexPath:indexPath];
            cell.dict = _oneSectionSouce[indexPath.row];
            return cell;
        }
        OMOBuyPlanTotalPriceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:OMOBuyPlanTotalPriceCellID forIndexPath:indexPath];
        
        cell.dict = _oneSectionSouce[indexPath.row];
        
        return cell;
    }else if(indexPath.section == 1){
        
        OMOBuyDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:OMOBuyDetailCellID forIndexPath:indexPath];
        
        cell.dict = _twoSectionSouce[indexPath.row];
        
        return cell;
    }
    return nil;
}

//创建头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0){
        
        if(kind == UICollectionElementKindSectionHeader){
            OMOBuyPalnDetailHeadView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:OMOBuyPalnDetailHeadViewID
                                                                                                 forIndexPath:indexPath];
            headView.dict = _headSouce;
            
            return headView;
        }else{
            
            OMOBuyPlanFootView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:OMOBuyPlanFootViewID
                                                                                     forIndexPath:indexPath];
            
            return footView;
        }
    }
    return nil;
}
// iteam大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0){
        
        if(indexPath.row == 0){
            
            return CGSizeMake(collectionView.lwb_width, 60);
        }
    }
    return CGSizeMake(collectionView.lwb_width, 40);
}
// 分区头视图高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    if (section == 0){
        
        return CGSizeMake(SCREENW, 110);
    }
    return CGSizeMake(SCREENW, 0);
}
// 分区头视图高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    if (section == 0){
        
        return CGSizeMake(SCREENW, lwb_smallMargin);
    }
    return CGSizeMake(SCREENW, 0);
}
// 分区间隔
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake( 0, 0, 0, 0);
}

// 行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}
// 列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}
//#pragma mark ------- 取消或者支付 --------
//- (void)omo_planCancelOrPayWithType:(NSInteger)type{
//
//    switch (type) {
//        case 0:
//            [self omo_cancelOrder];
//            break;
//
//        case 1:
//            [self omo_payOrder];
//            break;
//
//        default:
//            break;
//    }
//}
//#pragma mark ------ 取消订单 ---------
//- (void)omo_cancelOrder{
//
//    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
//    parmas[@"id"] = _model.order_id;
//    parmas[@"type"] = @"1";
//
//    [[OMONetworkManager sharedData]postWithURLString:@"" parameters:parmas success:^(id responseObject) {
//
//        if(responseObject){
//
////            NSDictionary *dataSouce = (NSDictionary *)responseObject;
//
//            [self.navigationController popViewControllerAnimated:YES];
//        }
//    } failure:^(NSError *error) {
//
//        [MBProgress hideAllHUD];
//    }];
//}
//#pragma mark -------- 支付订单 --------
//- (void)omo_payOrder{
//
//
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
