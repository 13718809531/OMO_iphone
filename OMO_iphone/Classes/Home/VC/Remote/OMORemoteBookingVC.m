//
//  OMORemoteBookingVC.m
//  OMO_iphone
//
//  Created by wy on 2018/10/9.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMORemoteBookingVC.h"
/**  */
#import "OMORemoteBookingModel.h"
/**  */
#import "OMORemoteBookingDetailCell.h"
#import "OMOBookingStrongFootView.h"
#import "OMORemoteTimeListVC.h"
/** 支付 */
#import "OMORemoteBookingPayView.h"
/** 预约支付成功 */
#import "OMOBookingSuccessVC.h"
/** 预约列表 */
#import "OMOMyBookingList.h"

/**  */
#import "AppDelegate.h"

@interface OMORemoteBookingVC ()
<UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
thridDelegate>

@property (nonatomic,strong)UICollectionView *collectionView;

/** 数据 */
@property (nonatomic, strong)NSArray *titleDataSouce;
/** 保存信息 */
@property (nonatomic, strong)OMORemoteBookingModel *bookingModel;
/** 立即预约 */
@property (nonatomic, strong)UIButton *immediatelyBtn;

@end

static NSString *OMORemoteBookingDetailCellID = @"OMORemoteBookingDetailCellID";
static NSString *OMOBookingStrongFootViewID = @"OMOBookingStrongFootViewID";

@implementation OMORemoteBookingVC

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.collectionView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatBar];
    [self.bar addTitltLabelWithText:@"远程预约" Font:navTitleFont];
    [self.bar addLeftButtonWithImage:[UIImage imageNamed:@"App_Back"]];
    
    [self omo_setDataSouce];
    [self.view addSubview:self.immediatelyBtn];
}
- (void)omo_setDataSouce{
    
    NSDictionary *dic1 = @{@"title":@"预约用户:",@"type":@"0"};
    NSDictionary *dic2 = @{@"title":@"康复项目:",@"type":@"0"};
    NSDictionary *dic3 = @{@"title":@"预约挂号:",@"type":@"0"};
    NSArray *array1 = @[dic1,dic2,dic3];
    
    NSDictionary *diction2 = @{@"title":@"预约时间",@"type":@"1"};
    NSArray *array3 = @[diction2];
    
    _bookingModel = [[OMORemoteBookingModel alloc]init];
    _bookingModel.cate_name = [OMOIphoneManager sharedData].cate_name;
    _bookingModel.realname = [OMOIphoneManager sharedData].nickname;
    _bookingModel.price = @"3元 首次免费";
    _bookingModel.time = @"";
    _bookingModel.consult_question = @"";
    
    _titleDataSouce = @[array1,array3];
    
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
        [_collectionView registerClass:[OMORemoteBookingDetailCell class] forCellWithReuseIdentifier:OMORemoteBookingDetailCellID];
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
    
    OMORemoteBookingDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:OMORemoteBookingDetailCellID forIndexPath:indexPath];
    
    NSArray *array = _titleDataSouce[indexPath.section];
    
    cell.dict = array[indexPath.row];
    
    if(indexPath.section == 0){
        
        if(indexPath.row == 0){
            
            cell.detailText = _bookingModel.realname;
        }else if(indexPath.row == 1){
            
            cell.detailText = _bookingModel.cate_name;
        }else if(indexPath.row == 2){
            
            cell.detailText = _bookingModel.price;
        }
    }else if(indexPath.section == 1){
        
        cell.detailText = _bookingModel.time;
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
//    __weak typeof(self) weakSelf = self;
    
    if(indexPath.section == 0){
        
        return;
    }
    if(indexPath.section == 1){
        
        if(indexPath.row == 0){
            
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
    
    if(section == 0){
        
        return UIEdgeInsetsMake( 10, 0, 10, 0);
    }
    return UIEdgeInsetsMake( 0, 0, 10, 0);
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
    
    if(indexPath.section == 1){
        
        if(kind == UICollectionElementKindSectionFooter){
            OMOBookingStrongFootView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                                                                    withReuseIdentifier:OMOBookingStrongFootViewID forIndexPath:indexPath];
            
            footView.desc = _bookingModel.consult_question;
            
            __weak typeof(self) weakSelf = self;
            
            footView.endEditing = ^(NSString *text) {
                
                weakSelf.bookingModel.consult_question = text;
            };
            return footView;
        }
    }
    return nil;
}

// 分区尾视图高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    if(section == 1){
        
        return CGSizeMake(SCREENW, 200);
    }
    return CGSizeMake(SCREENW, 0);
}
#pragma mark -------- 选择部位 ----------
- (void)omo_selectParts{
    
//    OMOSelectPartsVC *selectPartsVC = [[OMOSelectPartsVC alloc]init];
//    selectPartsVC.pushType = 1;
//    [self.navigationController pushViewController:selectPartsVC animated:YES];
}
#pragma mark --------- 未选择预约时间 --------
- (void)omo_selectBookingTime{
    
    OMORemoteTimeListVC *storeTimeVC = [[OMORemoteTimeListVC alloc]init];
    
    __weak typeof(self) weakSelf = self;
    
    storeTimeVC.selectTimeBlock = ^(NSString *selectTime, NSString *last_price) {
        
        weakSelf.bookingModel.time = selectTime;
        weakSelf.bookingModel.price = last_price;
        [weakSelf.collectionView reloadData];
    };
    [self.navigationController pushViewController:storeTimeVC animated:YES];
}
#pragma mark ------- 立即预约 -------
- (void)omo_immediatelyBookingStore{
    
    if(_bookingModel.time.length <= 0){
        
        [MBProgress showInfoMessage:@"请选择预约时间"];
        [self omo_selectBookingTime];
        return;
    }
    
    if(_bookingModel.price.doubleValue > 0){
        
        OMORemoteBookingPayView *payView = [[OMORemoteBookingPayView alloc]init];
        payView.price = _bookingModel.price;
        __weak typeof(self) weakSelf = self;
        payView.selectPayTypeBlock = ^(NSString *payType) {
          
            [weakSelf omo_payWithType:payType];
        };
        [payView show];
    }else{
        
        [self omo_payWithType:@"3"];
    }
}

#pragma mark ---------- 支付方式 ----------
- (void)omo_payWithType:(NSString *)payType{
    
    NSMutableDictionary *parmars = [NSMutableDictionary dictionary];
    parmars[@"pay_type"] = payType;
    parmars[@"last_price"] = checkNull(_bookingModel.price);
    NSArray *dateArray = [_bookingModel.time componentsSeparatedByString:@" "];
    parmars[@"date"] = dateArray.firstObject;
    NSArray *timeArray = [dateArray.lastObject componentsSeparatedByString:@"-"];
    parmars[@"str_start_time"] = timeArray.firstObject;
    parmars[@"str_end_time"] = timeArray.lastObject;
    parmars[@"cate_id"] = [OMOIphoneManager sharedData].cate_id;
    parmars[@"consult_question"] = checkNull(_bookingModel.consult_question);
    
    if([payType isEqualToString:@"1"]){
        
        [self wechatPayWithOrderData:parmars];
    }else if ([payType isEqualToString:@"2"]){
        
        [self aliPayWithOrderData:parmars];
    }else if ([payType isEqualToString:@"3"]){
        
        [[OMONetworkManager sharedData]postWithURLString:@"41010" parameters:parmars success:^(id responseObject) {
            
            if(responseObject){
                
                [MBProgress showInfoMessage:@"预约成功"];
                OMOMyBookingList *myAppointmentVC = [[OMOMyBookingList alloc]init];
                [self.navigationController pushViewController:myAppointmentVC animated:YES];
            }
        } failure:^(NSError *error) {
            
            [MBProgress hideAllHUD];
        }];
    }
}
#pragma mark - 微信支付
- (void)wechatPayWithOrderData:(NSDictionary *)dictionary{
    
    [[OMONetworkManager sharedData]postWithURLString:@"41010" parameters:dictionary success:^(id responseObject) {
        
        if(responseObject){
            
            NSDictionary *dic = (NSDictionary *)responseObject;
            
            NSLog(@"%@",dic);
            //需要创建这个支付对象
            PayReq *req   = [[PayReq alloc] init];
            //由用户微信号和AppID组成的唯一标识，用于校验微信用户
            req.openID = dic[@"appid"];
            
            // 商家id，在注册的时候给的
            req.partnerId = dic[@"partnerid"];
            
            // 预支付订单这个是后台跟微信服务器交互后，微信服务器传给你们服务器的，你们服务器再传给你
            req.prepayId  = dic[@"prepayid"];
            
            // 根据财付通文档填写的数据和签名
            //这个比较特殊，是固定的，只能是即req.package = Sign=WXPay
            req.package   = dic[@"package"];
            
            // 随机编码，为了防止重复的，在后台生成
            req.nonceStr  = dic[@"noncestr"];
            
            // 这个是时间戳，也是在后台生成的，为了验证支付的
            NSString * stamp = dic[@"timestamp"];
            req.timeStamp = stamp.intValue;
            
            // 这个签名也是后台做的
            req.sign = dic[@"sign"];
            
            //发送请求到微信，等待微信返回onResp
            [WXApi sendReq:req];
        }
    } failure:^(NSError *error) {
        
        [MBProgress hideAllHUD];
    }];
}
#pragma mark - 支付宝支付
- (void)aliPayWithOrderData:(NSDictionary *)dictionary{
    
    [[OMONetworkManager sharedData]postWithURLString:@"41010" parameters:dictionary success:^(id responseObject) {
        
        if(responseObject){
            
            NSLog(@"zhizhihzi%@",responseObject);
            
            NSString * appScheme = @"yuanxinkangfu";
            
            [[AlipaySDK defaultService] payOrder:responseObject fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                
                NSLog(@"%@",resultDic);
            }];
        }
    } failure:^(NSError *error) {
        
        [MBProgress hideAllHUD];
    }];
}
#pragma mark -------- 支付回调 -----------
- (void)aliPayReturn:(BOOL)isSuccess{
    
    if(isSuccess){
        
        OMOBookingSuccessVC *bookingSuccessVC = [[OMOBookingSuccessVC alloc]init];
        [self.navigationController pushViewController:bookingSuccessVC animated:YES];
    }
}
@end
