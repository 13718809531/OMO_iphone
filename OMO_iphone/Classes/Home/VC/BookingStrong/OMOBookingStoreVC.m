//
//  OMOReceiveOrBookingVC.m
//  OMO_iphone
//
//  Created by wy on 2018/9/28.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOBookingStoreVC.h"
#import "OMOStoreBookingModel.h"
#import "OMOBookingStoreCell.h"
#import "OMOBookingStrongFootView.h"
#import "BRPickerView.h"
#import "OMOBookingStoreTimeVC.h"
/**  */
#import "OMOSelectPartsVC.h"
/**  */
#import "OMOMyBookingList.h"

@interface OMOBookingStoreVC ()
<UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)UICollectionView *collectionView;

/** 数据 */
@property (nonatomic, strong)NSArray *titleDataSouce;
/** 保存信息 */
@property (nonatomic, strong)OMOStoreBookingModel *bookingModel;
/** 立即预约 */
@property (nonatomic, strong)UIButton *immediatelyBtn;

@end

static NSString *OMOBookingStoreCellID = @"OMOBookingStoreCellID";
static NSString *OMOBookingStrongFootViewID = @"OMOBookingStrongFootViewID";

@implementation OMOBookingStoreVC

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.collectionView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatBar];
    [self.bar addTitltLabelWithText:@"门店预约" Font:navTitleFont];
    [self.bar addLeftButtonWithImage:[UIImage imageNamed:@"App_Back"]];
    
    [self omo_setDataSouce];
    [self.view addSubview:self.immediatelyBtn];
}
- (void)omo_setDataSouce{
    
    NSDictionary *dic1 = @{@"title":@"选择部位",@"type":@"1"};
    NSDictionary *dic2 = @{@"title":@"服务对象",@"type":@"0"};
    NSDictionary *dic3 = @{@"title":@"联系方式",@"type":@"0"};
    NSArray *array1 = @[dic1,dic2,dic3];
    
    NSDictionary *dict1 = @{@"title":@"服务方式",@"type":@"0"};
    NSDictionary *dict2 = @{@"title":@"服务中心",@"type":@"0"};
    NSDictionary *dict3 = @{@"title":@"中心电话",@"type":@"0"};
    NSArray *array2 = @[dict1,dict2,dict3];
    
    NSDictionary *diction1 = @{@"title":@"预约类型",@"type":@"0"};
    NSDictionary *diction2 = @{@"title":@"预约时间",@"type":@"1"};
    NSArray *array3 = @[diction1,diction2];

    _bookingModel = [[OMOStoreBookingModel alloc]init];
    _bookingModel.cate_name = [OMOIphoneManager sharedData].cate_name;
    _bookingModel.realname = [OMOIphoneManager sharedData].nickname;
    _bookingModel.store_mobile = [OMOIphoneManager sharedData].mobile;
    _bookingModel.service_mode = @"到店";
    _bookingModel.store_name = _storeModel.store_name;
    _bookingModel.store_mobile = _storeModel.mobile;
    _bookingModel.appointmentType = @"普通预约";
    _bookingModel.date = @"";
    _bookingModel.desc = @"";
    
    _titleDataSouce = @[array1,array2,array3];
    
    [self.view addSubview:self.collectionView];
}
- (UIButton *)immediatelyBtn{
    
    if(_immediatelyBtn == nil){
        
        _immediatelyBtn = [[UIButton alloc]init];
        _immediatelyBtn.lwb_x = IFFitFloat6(lwb_pblicX);
        _immediatelyBtn.lwb_width = SCREENW - IFFitFloat6(lwb_pblicX) * 2;
        _immediatelyBtn.lwb_height = 40.f;
        _immediatelyBtn.lwb_bottom = SCREENH - IFFitFloat6(30) - Between;
        _immediatelyBtn.backgroundColor = backColor;
        [_immediatelyBtn setTitle:@"立即预约" forState:UIControlStateNormal];
        [_immediatelyBtn setTitleColor:WHITECOLORA(1) forState:UIControlStateNormal];
        _immediatelyBtn.titleLabel.font = Font(18);
        _immediatelyBtn.layer.masksToBounds = YES;
        _immediatelyBtn.layer.cornerRadius = 20.f;
        [_immediatelyBtn addTarget:self action:@selector(omo_immediatelyBookingStore) forControlEvents:UIControlEventTouchUpInside];
    }
    return _immediatelyBtn;
}
- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, IphoneY, SCREENW, SCREENH - IphoneY - 80) collectionViewLayout:flowLayout];
        //注册cell
        [_collectionView registerClass:[OMOBookingStoreCell class] forCellWithReuseIdentifier:OMOBookingStoreCellID];
        [_collectionView registerClass:[OMOBookingStrongFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:OMOBookingStrongFootViewID];
        _collectionView.backgroundColor = mainBackColor;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}
// 分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return _titleDataSouce.count;
}
#pragma collectionView 数据源、代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    NSArray *array = _titleDataSouce[section];
    
    return array.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    OMOBookingStoreCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:OMOBookingStoreCellID forIndexPath:indexPath];
    
    NSArray *array = _titleDataSouce[indexPath.section];
    
    cell.dict = array[indexPath.row];
    
    if(indexPath.section == 0){
        
        if(indexPath.row == 0){
            
            cell.detailText = _bookingModel.cate_name;
        }else if(indexPath.row == 1){
            
            cell.detailText = _bookingModel.realname;
        }else if(indexPath.row == 2){
            
            cell.detailText = _bookingModel.store_mobile;
        }
    }else if(indexPath.section == 1){
        
        if (indexPath.row == 0) {
            
            cell.detailText = _bookingModel.service_mode;
        }else if(indexPath.row == 1){
            
            cell.detailText = _bookingModel.store_name;
        }else if(indexPath.row == 2){
            
            cell.detailText = _bookingModel.store_mobile;
        }
    }else if(indexPath.section == 2){
        
        if (indexPath.row == 0) {
            
            cell.detailText = _bookingModel.appointmentType;
        }else if(indexPath.row == 1){
            
            cell.detailText = _bookingModel.date;
        }
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    __weak typeof(self) weakSelf = self;
    
    if(indexPath.section == 0){
        
        if(indexPath.row == 0){
            
            [self omo_selectParts];
        }
    }
    if(indexPath.section == 1){
        
        if(indexPath.row == 0){
            
//            // 自定义单列字符串
//            [BRStringPickerView showStringPickerWithTitle:@"请选择服务方式" dataSource:@[@"到店",@"上门"] defaultSelValue:@"到店" isAutoSelect:NO themeColor:nil resultBlock:^(id selectValue) {
//
//                weakSelf.bookingModel.serviceType = selectValue;
//                [weakSelf.collectionView reloadData];
//            }];
        }else if (indexPath.row == 1){
            
//            NSArray *array = @[@"1",@"2",@"3"];
//            // 自定义单列字符串
//            [BRStringPickerView showStringPickerWithTitle:@"请选择服务中心" dataSource:array defaultSelValue:array.firstObject isAutoSelect:NO themeColor:nil resultBlock:^(id selectValue) {
//
//                weakSelf.bookingModel.serviceStrong = selectValue;
//                weakSelf.bookingModel.serviceMobile = selectValue;
//                [weakSelf.collectionView reloadData];
//            }];
        }
    }else if (indexPath.section == 2){
        
        if(indexPath.row == 0){
            
//            NSArray *array = @[@"1",@"2",@"3"];
//            // 自定义单列字符串
//            [BRStringPickerView showStringPickerWithTitle:@"请选择预约方式" dataSource:array defaultSelValue:array.firstObject isAutoSelect:NO themeColor:nil resultBlock:^(id selectValue) {
//                
//                weakSelf.bookingModel.appointmentType = selectValue;
//                [weakSelf.collectionView reloadData];
//            }];
        }else if (indexPath.row == 1){
            
            [self omo_selectBookingTime];
        }
    }
}
// iteam大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(SCREENW, 55);
}

// 分区间隔
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    if(section != 2){
        
        return UIEdgeInsetsMake( 10, 0, 0, 0);
    }
    return UIEdgeInsetsMake( 10, 0, 10, 0);
}

// 行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 1;
}
// 列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}
//创建头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section == 2){
        
        if(kind == UICollectionElementKindSectionFooter){
            OMOBookingStrongFootView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                withReuseIdentifier:OMOBookingStrongFootViewID forIndexPath:indexPath];
            
            footView.desc = _bookingModel.desc;
            
            __weak typeof(self) weakSelf = self;
            
            footView.endEditing = ^(NSString *text) {
              
                weakSelf.bookingModel.desc = text;
            };
            return footView;
        }
    }
    return nil;
}

// 分区尾视图高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    if(section == 2){
        
        return CGSizeMake(SCREENW, 200);
    }
    return CGSizeMake(SCREENW, 0);
}
#pragma mark -------- 选择部位 ----------
- (void)omo_selectParts{
    
    OMOSelectPartsVC *selectPartsVC = [[OMOSelectPartsVC alloc]init];
    selectPartsVC.pushType = 1;
    [self.navigationController pushViewController:selectPartsVC animated:YES];
}
#pragma mark --------- 未选择预约时间 --------
- (void)omo_selectBookingTime{
    
    OMOBookingStoreTimeVC *storeTimeVC = [[OMOBookingStoreTimeVC alloc]init];
    storeTimeVC.storeModel = _storeModel;
    
    __weak typeof(self) weakSelf = self;
    
    storeTimeVC.selctBookingTime = ^(NSString *bookingTime) {
        
        weakSelf.bookingModel.date = bookingTime;
        
        [weakSelf.collectionView reloadData];
    };
    [self.navigationController pushViewController:storeTimeVC animated:YES];
}
#pragma mark ------- 立即预约 -------
- (void)omo_immediatelyBookingStore{
    
    if([OMOIphoneManager sharedData].cate_id.length <= 0){
        
        [MBProgress showInfoMessage:@"请先选择评估部位"];
        [self omo_selectParts];
        return;
    }
    
    if(_bookingModel.date.length <= 0){
        
        [MBProgress showInfoMessage:@"请选择预约时间"];
        [self omo_selectBookingTime];
        return;
    }
    NSMutableDictionary *parmars = [NSMutableDictionary dictionary];
    parmars[@"cate_id"] = [OMOIphoneManager sharedData].cate_id;
    parmars[@"store_id"] = _storeModel.store_id;
    parmars[@"service_mode"] = @"1";
    parmars[@"appoint_type"] = @"1";
    NSUInteger time = [NSString timeIntervalimeFromDateString:_bookingModel.date];
    parmars[@"date"] = @(time);
    parmars[@"desc"] = _bookingModel.desc;
    
    [[OMONetworkManager sharedData]postWithURLString:@"41003" parameters:parmars success:^(id responseObject) {
        
        if(responseObject){
            
            [MBProgress showInfoMessage:@"预约成功"];
            OMOMyBookingList *myAppointmentVC = [[OMOMyBookingList alloc]init];
            [self.navigationController pushViewController:myAppointmentVC animated:YES];
        }
    } failure:^(NSError *error) {
        
        [MBProgress hideAllHUD];
    }];
}
@end
