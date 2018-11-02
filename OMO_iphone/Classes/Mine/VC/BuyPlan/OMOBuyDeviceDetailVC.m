//
//  OMOBuyDeviceDetailVC.m
//  OMO_iphone
//
//  Created by wy on 2018/10/19.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOBuyDeviceDetailVC.h"
/**  */
#import "OMOBuyDevicesVC.h"

/**  */
#import "OMOBuyDeviceDetailModel.h"
/**  */
#import "OMOUserAddressModel.h"

/** 头部 */
#import "OMOBuyDeviceTitleCell.h"
/* 地址 */
#import "OMOBuyDeviceAddressCell.h"
/**  */
#import "OMOBuyDetailDeviceHeadView.h"
/**  */
#import "OMOBuyDetailDeviceCell.h"
/**  */
#import "OMOBuyDetailDeviceFootView.h"
/**  */
#import "OMOBuyDetailCell.h"
/**  */
#import "OMOBuyPlanBottomView.h"

@interface OMOBuyDeviceDetailVC ()
<UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout,
UICollectionViewDataSourcePrefetching,
OMOPlanOrderDelegate>

/**  */
@property (nonatomic, strong)OMOBuyDeviceDetailModel *model;
/**  */
@property (nonatomic, strong)OMOUserAddressModel *addressModel;

@property(strong,nonatomic)UICollectionView *collectionView;// 展示视图
/** 头部数据 */
@property (nonatomic, strong)NSDictionary *headSouce;
/** 第二分区数据 */
@property (nonatomic, strong)NSArray *twoSectionSouce;

/**  */
@property (nonatomic, strong)OMOBuyPlanBottomView *bottomView;
/** 确认收货 */
@property (nonatomic, strong)UIButton *confirmBtn;

@end

static NSString *OMOBuyDeviceTitleCellID = @"OMOBuyDeviceTitleCellID";
static NSString *OMOBuyDeviceAddressCellID = @"OMOBuyDeviceAddressCellID";
static NSString *OMOBuyDetailDeviceHeadViewID = @"OMOBuyDetailDeviceHeadViewID";
static NSString *OMOBuyDetailDeviceCellID = @"OMOBuyDetailDeviceCellID";
static NSString *OMOBuyDetailDeviceFootViewID = @"OMOBuyDetailDeviceFootViewID";
static NSString *OMOBuyDetailCellID = @"OMOBuyDetailCellID";

@implementation OMOBuyDeviceDetailVC
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self omo_requestData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatBar];
    [self.bar addLeftButtonWithImage:[UIImage imageNamed:@"App_Back"]];
    [self.bar addTitltLabelWithText:@"购买辅具明细" Font:navTitleFont];
}
- (void)omo_requestData{
    
    __weak typeof(self) weakSelf = self;
    
    [[OMONetworkManager sharedData]postWithURLString:@"20011" parameters:@{@"pe_order_id":_pe_order_id} success:^(id responseObject) {
        
        if(responseObject){
            
            NSDictionary *dataSouce = (NSDictionary *)responseObject;
            
            weakSelf.model = [OMOBuyDeviceDetailModel mj_objectWithKeyValues:dataSouce[@"mt_order_info"]];
            
            [weakSelf omo_setDataSouce];
        }
    } failure:^(NSError *error) {
        
        [MBProgress hideAllHUD];
    }];
}
- (void)omo_setDataSouce{
    
    _addressModel = [[OMOUserAddressModel alloc]init];
    _addressModel.name = _model.name;
    _addressModel.mobile = _model.mobile;
    _addressModel.address = _model.address;
    
    NSDictionary *dic1 = @{@"title":@"订单号",@"detail":checkNull(_model.out_trade_no)};
    NSDictionary *dic2 = @{@"title":@"付款时间",@"detail":checkNull(_model.pay_time)};
    NSDictionary *dic3 = @{@"title":@"支付方式",@"detail":checkNull(_model.pay_type)};
    NSDictionary *dic4 = @{@"title":@"订单状态",@"detail":checkNull(_model.state)};
    _twoSectionSouce = @[dic1,dic2,dic3,dic4];
    
    [self.view addSubview:self.collectionView];
    
    if([_model.state isEqualToString:@"1"]){
        
        [self.view addSubview:self.bottomView];
    }else if([_model.state isEqualToString:@"2"] || [_model.state isEqualToString:@"3"]){
        
        [self.view addSubview:self.confirmBtn];
    }
}
- (UIButton *)confirmBtn{
    if(!_confirmBtn){
        
        _confirmBtn = [[UIButton alloc]init];
        _confirmBtn.size = CGSizeMake(120, 40);
        _confirmBtn.lwb_centerX = self.view.lwb_centerX;
        _confirmBtn.lwb_y = SCREENH - 80;
        _confirmBtn.layer.cornerRadius = 20.f;
        _confirmBtn.backgroundColor = backColor;
        [_confirmBtn setTitle:@"确认收货" forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = navTitleFont;
        [_confirmBtn setTitleColor:WHITECOLORA(1) forState:UIControlStateNormal];
        [_confirmBtn addTarget:self action:@selector(omo_confirmGoods) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}
- (OMOBuyPlanBottomView *)bottomView{
    
    if(_bottomView == nil){
        
        _bottomView = [[OMOBuyPlanBottomView alloc]init];
        _bottomView.delegate = self;
    }
    return _bottomView;
}
- (UICollectionView *)collectionView{
    if(_collectionView == nil){
        
        UICollectionViewFlowLayout *collectionLayout = [[UICollectionViewFlowLayout alloc]init];
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, IphoneY, SCREENW, SCREENH - IphoneY - 100) collectionViewLayout:collectionLayout];
        
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
        
        // 第一分区cell
        [_collectionView registerClass:[OMOBuyDeviceTitleCell class] forCellWithReuseIdentifier:OMOBuyDeviceTitleCellID];
        
        // 第二分区cell
        [_collectionView registerClass:[OMOBuyDeviceAddressCell class] forCellWithReuseIdentifier:OMOBuyDeviceAddressCellID];\
        
        // 商品头部
        [_collectionView registerClass:[OMOBuyDetailDeviceHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:OMOBuyDetailDeviceHeadViewID];
        // cell
        [_collectionView registerClass:[OMOBuyDetailDeviceCell class] forCellWithReuseIdentifier:OMOBuyDetailDeviceCellID];
        // 商品尾部
        [_collectionView registerClass:[OMOBuyDetailDeviceFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:OMOBuyDetailDeviceFootViewID];
        
        // 第3分区cell
        [_collectionView registerClass:[OMOBuyDetailCell class] forCellWithReuseIdentifier:OMOBuyDetailCellID];
    }
    return _collectionView;
}
// 分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    NSInteger count = 3;
    
    if([_model.state isEqualToString:@"2"] || [_model.state isEqualToString:@"3"]){
        
        count += 1;
    }
    return count;
}
// 行数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if(section == 0){
        
        return 1;
    }else if (section == 1){
        
        return 1;
    }else if (section == 2){
        
        return  _model.mt_order_project.count;
    }else{
        
        return _twoSectionSouce.count;
    }
    return 0;
}
// cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0){
        
        OMOBuyDeviceTitleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:OMOBuyDeviceTitleCellID forIndexPath:indexPath];
        
        cell.title = _model.title;
        
        return cell;
    }else if(indexPath.section == 1){
        
        OMOBuyDeviceAddressCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:OMOBuyDeviceAddressCellID forIndexPath:indexPath];
        
        cell.addressModel = _addressModel;
        
        return cell;
    }else if(indexPath.section == 2){
        
        OMOBuyDetailDeviceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:OMOBuyDetailDeviceCellID forIndexPath:indexPath];
        
        cell.itemModel = _model.mt_order_project[indexPath.row];
        
        return cell;
    }else{
        
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
    
    if (indexPath.section == 2){
        
        if(kind == UICollectionElementKindSectionHeader){
            OMOBuyDetailDeviceHeadView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:OMOBuyDetailDeviceHeadViewID
                forIndexPath:indexPath];
            
            return headView;
        }else{
            
            OMOBuyDetailDeviceFootView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:OMOBuyDetailDeviceFootViewID
                forIndexPath:indexPath];
            
            footView.title = _model.last_price;
            
            return footView;
        }
    }
    return nil;
}
// iteam大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0){
        
        return CGSizeMake(collectionView.lwb_width, 60);
    }else if (indexPath.section == 1){
        
        return CGSizeMake(collectionView.lwb_width, 100);
    }else if (indexPath.section == 2){
        
        return CGSizeMake(collectionView.lwb_width, 60);
    }
    return CGSizeMake(collectionView.lwb_width, 40);
}
// 分区头视图高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    if (section == 2){
        
        return CGSizeMake(SCREENW, 60);
    }
    return CGSizeMake(SCREENW, 0);
}
// 分区头视图高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    if (section == 2){
        
        return CGSizeMake(SCREENW, 60);
    }
    return CGSizeMake(SCREENW, 0);
}
// 分区间隔
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake( 0, 0, 0, 0);
}

// 行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    if(section == 2){
        
        return 2;
    }
    return 0;
}
// 列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}
#pragma mark ------- 取消或者支付 --------
- (void)omo_planCancelOrPayWithType:(NSInteger)type{
    
    switch (type) {
        case 0:
            [self omo_cancelOrder];
            break;
            
        case 1:
            [self omo_payOrder];
            break;
            
        default:
            break;
    }
}
#pragma mark ------ 取消订单 ---------
- (void)omo_cancelOrder{
    
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@"id"] = _model.mt_order_id;
    parmas[@"type"] = @"1";
    
    [[OMONetworkManager sharedData]postWithURLString:@"" parameters:parmas success:^(id responseObject) {
        
        if(responseObject){
            
            //            NSDictionary *dataSouce = (NSDictionary *)responseObject;
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {
        
        [MBProgress hideAllHUD];
    }];
}
#pragma mark -------- 支付订单 --------
- (void)omo_payOrder{
    
    OMOBuyDevicesVC *buyDevicesVC = [[OMOBuyDevicesVC alloc]init];
    buyDevicesVC.pe_order_id = _pe_order_id;
    buyDevicesVC.numType = 2;
    buyDevicesVC.buyType = 2;
    [self.navigationController pushViewController:buyDevicesVC animated:YES];
}
#pragma mark --------- 确认收货 --------
- (void)omo_confirmGoods{
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
