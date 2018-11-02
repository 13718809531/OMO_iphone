//
//  OMOBuyDevicesVC.m
//  OMO_iphone
//
//  Created by wy on 2018/10/9.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOBuyDevicesVC.h"
/** 收货地址列表 */
#import "OMOAddressListVC.h"
/** 方案,辅具一起支付 */
#import "OMOAllPaySuccessVC.h"
/** 方案支付 */
#import "OMOPlanPaySuccessVC.h"
/** 辅具支付 */
#import "OMODevicePaySuccessVC.h"

//** 添加收货地址 */
#import "OMOAddUserAddressCell.h"
/** 已选择的收货地址 */
#import "OMOBuyAddressCell.h"
/** 训练方案头 */
#import "OMOBuyTrainingPlanHeadView.h"
/** 方案cell */
#import "OMOBuyPlanPriceCell.h"
/** 积分抵扣 */
#import "OMOBuySelectPointCell.h"
/** 方案尾 */
#import "OMOBuyTraningPlanFootView.h"
/** 辅具row == 0cell */
#import "OMOGoodsDetailHeadCell.h"
/** 辅具 */
#import "OMOGoodsDetailsCell.h"
/** 辅具foot */
#import "OMOBuyDeviceFootView.h"
/** 支付 */
#import "OMOPayTypeCell.h"
/**  */
#import "OMOBuyDeviceBottomView.h"

/**  */
#import "AppDelegate.h"
/** 本页面用到的信息:地址,积分抵扣,运费 */
#import "OMOBuyModel.h"
/** 商品 */
#import "OMOKangFuBaoMtItemModel.h"

@interface OMOBuyDevicesVC ()
<UITableViewDelegate,
UITableViewDataSource,
OMOSwitchPointDeductionDelegate,// 积分抵扣开关
OMOGoodsBuyDelegate,// 商品个数选中开关
OMOSubmitOrderDelegate,// 支付
thridDelegate// 支付回调
>

/**  */
@property (nonatomic, strong)OMOBuyModel *buyModel;

@property (nonatomic, strong)UITableView *tableView;
/** 方案尾 */
@property (nonatomic, strong)OMOBuyTraningPlanFootView *planFootView;
/** 辅具尾 */
@property (nonatomic, strong)OMOBuyDeviceFootView *deviceFootView;
/**  */
@property (nonatomic, strong)OMOBuyDeviceBottomView *bottomView;

/** 方案价 */
@property (nonatomic,assign)double planPrice;
/** 商品总价 */
@property (nonatomic,assign)double goodsTotalPrice;
/** 支付总价 */
@property (nonatomic,assign)double totalPrice;

/** 记录支付方式,默认微信 */
@property (nonatomic,assign)NSInteger payType;

@end

static NSString *OMOAddUserAddressCellID = @"OMOAddUserAddressCellID";
static NSString *OMOBuyAddressCellID = @"OMOBuyAddressCellID";
static NSString *OMOBuyPlanPriceCellID = @"OMOBuyPlanPriceCellID";
static NSString *OMOBuySelectPointCellID = @"OMOBuySelectPointCellID";
static NSString *OMOGoodsDetailHeadCellID = @"OMOGoodsDetailHeadCellID";
static NSString *OMOGoodsDetailsCellID = @"OMOGoodsDetailsCellID";
static NSString *OMOPayTypeCellID = @"OMOPayTypeCellID";

@implementation OMOBuyDevicesVC

- (void)viewWillLayoutSubviews{
    
    [super viewWillLayoutSubviews];
    
    // 不允许自动调整 scrollView 的内边距(隐藏滚动条)
    if (@available(iOS 11.0, *)) {
        
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.tableView setContentInset:UIEdgeInsetsZero];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatBar];
    [self.bar addLeftButtonWithImage:[UIImage imageNamed:@"App_Back"]];
    [self.bar addTitltLabelWithText:@"购买辅具" Font:navTitleFont];
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    app.thirdDelegate = self;
    _payType = 0;
        
    [self omo_requestData];
}
- (void)setPe_order_id:(NSString *)pe_order_id{
    
    _pe_order_id = pe_order_id;
    
    __weak typeof(self) weakSelf = self;
    
    [[OMONetworkManager sharedData]postWithURLString:@"61000" parameters:@{@"pe_order_id":pe_order_id} success:^(id responseObject) {
        
        if(responseObject){
            
            NSDictionary *dataSouce = (NSDictionary *)responseObject;
            
            weakSelf.items = [OMOKangFuBaoMtItemModel mj_objectArrayWithKeyValuesArray:dataSouce[@"mt_list"]];
        }
    } failure:^(NSError *error) {
        
        [MBProgress hideAllHUD];
    }];
}
- (void)setItems:(NSArray<OMOKangFuBaoMtItemModel *> *)items{
    
    _items = items;
    
    NSMutableArray *nowItems = [NSMutableArray array];
    
    double goodsTotalPrice = 0.0;
    
    if(_buyType != 1){
        
        for (OMOKangFuBaoMtItemModel *itemModel in items) {
            
            itemModel.isSelect = YES;
            goodsTotalPrice += itemModel.unit_price.doubleValue * itemModel.num.integerValue;
            [nowItems addObject:itemModel];
        }
    }
    self.goodsTotalPrice = goodsTotalPrice;
    
    _items = nowItems;
}
- (void)setKangFuBaoModel:(OMOKangFuBaoModel *)kangFuBaoModel{
    
    _kangFuBaoModel = kangFuBaoModel;
    
    NSMutableArray *items = [NSMutableArray array];
    
    double goodsTotalPrice = 0.0;
    
    if(_buyType != 1){
        
        for (OMOKangFuBaoMtItemModel *itemModel in kangFuBaoModel.mt_item) {
            
            itemModel.isSelect = YES;
            goodsTotalPrice += itemModel.unit_price.doubleValue * itemModel.num.integerValue;
            [items addObject:itemModel];
        }
    }
    self.goodsTotalPrice = goodsTotalPrice;
    
    _items = items;
}
- (void)setPlanPrice:(double)planPrice{
    
    _planPrice = planPrice;
    
    self.planFootView.planPrice = planPrice;
    
    [self omo_calculateTotalPrice];
}
- (void)setGoodsTotalPrice:(double)goodsTotalPrice{
    
    _goodsTotalPrice = goodsTotalPrice;
    
    self.deviceFootView.goodsTotalPrice = goodsTotalPrice;
    
    [self omo_calculateTotalPrice];
}
- (void)omo_calculateTotalPrice{
    
    if(_buyType == 0){
        
        if(_goodsTotalPrice > 0){
            
            if(_goodsTotalPrice >= _buyModel.free_ship_price.doubleValue){
                
                _totalPrice = _goodsTotalPrice + _planPrice;
                self.bottomView.isFree = YES;
            }else{
                
                _totalPrice = _goodsTotalPrice + _buyModel.ship_price.doubleValue + _planPrice;
                self.bottomView.isFree = NO;
            }
        }else{
            
            _totalPrice = _planPrice;
            self.bottomView.isFree = NO;
        }
    }
    
    if(_buyType == 1){
        
        _totalPrice = _planPrice;
        self.bottomView.isFree = YES;
    }
    if(_buyType == 2){
        
        if(_goodsTotalPrice >= _buyModel.free_ship_price.doubleValue){
            
            _totalPrice = _goodsTotalPrice;
            self.bottomView.isFree = YES;
        }else{
            
            _totalPrice = _goodsTotalPrice + _buyModel.ship_price.doubleValue;
            self.bottomView.isFree = NO;
        }
    }
    
    self.bottomView.totalPrice = [NSString stringWithFormat:@"%.2f",_totalPrice];
}
- (void)omo_requestData{
    
    __weak typeof(self) weakSelf = self;
    
    [[OMONetworkManager sharedData]postWithURLString:@"20009" parameters:nil success:^(id responseObject) {
        
        if(responseObject){
            
            NSDictionary *dict = (NSDictionary *)responseObject;
            
            weakSelf.buyModel = [OMOBuyModel mj_objectWithKeyValues:dict];
            
            weakSelf.bottomView.ship_price = weakSelf.buyModel.ship_price;
            
            if(weakSelf.buyModel.point_rules.point.doubleValue == 0.0){
                
                weakSelf.planPrice = weakSelf.kangFuBaoModel.discount_price.doubleValue;
            }else{
                
                double planPrice = weakSelf.kangFuBaoModel.discount_price.doubleValue - weakSelf.buyModel.point_rules.discount_price.doubleValue;
                weakSelf.planPrice = planPrice;
            }
            
            [weakSelf.view addSubview:weakSelf.tableView];
            [weakSelf.view addSubview:weakSelf.bottomView];
        }
    } failure:^(NSError *error) {
        
        [MBProgress hideAllHUD];
    }];
}
- (OMOBuyTraningPlanFootView *)planFootView{
    
    if(_planFootView == nil){
        
        _planFootView = [[OMOBuyTraningPlanFootView alloc]init];
    }
    return _planFootView;
}
- (OMOBuyDeviceFootView *)deviceFootView{
    
    if(_deviceFootView == nil){
        
        _deviceFootView = [[OMOBuyDeviceFootView alloc]init];
        _deviceFootView.freightPrice = _buyModel.free_ship_price.doubleValue;
    }
    return _deviceFootView;
}
- (OMOBuyDeviceBottomView *)bottomView{
    
    if(_bottomView == nil){
        
        _bottomView = [[OMOBuyDeviceBottomView alloc]init];
        _bottomView.delegate = self;
    }
    return _bottomView;
}
- (UITableView *)tableView{
    
    if(_tableView == nil){
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, IphoneY, SCREENW, SCREENH - IphoneY - 44 - Between) style:UITableViewStylePlain];
        _tableView.backgroundColor = mainBackColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[OMOAddUserAddressCell class] forCellReuseIdentifier:OMOAddUserAddressCellID];
        [_tableView registerClass:[OMOBuyAddressCell class] forCellReuseIdentifier:OMOBuyAddressCellID];
        [_tableView registerClass:[OMOBuyPlanPriceCell class] forCellReuseIdentifier:OMOBuyPlanPriceCellID];
        [_tableView registerClass:[OMOBuySelectPointCell class] forCellReuseIdentifier:OMOBuySelectPointCellID];
        [_tableView registerClass:[OMOGoodsDetailHeadCell class] forCellReuseIdentifier:OMOGoodsDetailHeadCellID];
        [_tableView registerClass:[OMOGoodsDetailsCell class] forCellReuseIdentifier:OMOGoodsDetailsCellID];
        [_tableView registerClass:[OMOPayTypeCell class] forCellReuseIdentifier:OMOPayTypeCellID];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc]init];
    }
    return _tableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if(_buyType == 0){

        return 4;
    }
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(section == 0){
        
        return 1;
    }else if (section == 1){
        
        if(_buyType == 0 || _buyType == 1){
            
            if(_buyModel.point_rules.point.doubleValue == 0.0){

                return 1;
            }else{

                return 2;
            }
        }else{
            
            return _items.count + 1;
        }
    }else if (section == 2){
        
        if(_buyType == 0){
            
            return _items.count + 1;
        }else{
            
            return 2;
        }
    }
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0){
        
        if(_buyModel.address.ID.length <= 0){
            
            OMOAddUserAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:OMOAddUserAddressCellID];
            
            return cell;
        }else{
            
            OMOBuyAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:OMOBuyAddressCellID];
            
            cell.addressModel = _buyModel.address;
            
            return cell;
        }
    }else if (indexPath.section == 1){
        
        if(_buyType == 0 || _buyType == 1){
            
            if(indexPath.row == 0){
                
                OMOBuyPlanPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:OMOBuyPlanPriceCellID];
                cell.title = _kangFuBaoModel.treat_name;
                cell.detail = _kangFuBaoModel.discount_price;
                return cell;
            }else{
                
                OMOBuySelectPointCell *cell = [tableView dequeueReusableCellWithIdentifier:OMOBuySelectPointCellID];
                cell.title = _buyModel.point_rules.point_desc;
                cell.delegate = self;
                return cell;
            }
        }else{
            
            if(indexPath.row == 0){
                
                OMOGoodsDetailHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:OMOGoodsDetailHeadCellID];
                return cell;
            }else{
                
                OMOGoodsDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:OMOGoodsDetailsCellID];
                cell.itemModel = _items[indexPath.row - 1];
                cell.delegate = self;
                return cell;
            }
        }
    }else if(indexPath.section == 2){
        
        if(_buyType == 0){
            
            if(indexPath.row == 0){
                
                OMOGoodsDetailHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:OMOGoodsDetailHeadCellID];
                return cell;
            }else{
                
                OMOGoodsDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:OMOGoodsDetailsCellID];
                cell.itemModel = _items[indexPath.row - 1];
                cell.delegate = self;
                return cell;
            }
        }else{
            
            OMOPayTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:OMOPayTypeCellID];
            cell.payType = indexPath.row;
            if(indexPath.row == _payType){
                
                cell.isSelect = YES;
            }
            return cell;
        }
    }else{
        
        OMOPayTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:OMOPayTypeCellID];
        cell.payType = indexPath.row;
        if(indexPath.row == _payType){
            
            cell.isSelect = YES;
        }
        return cell;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    __weak typeof(self) weakSelf = self;
    
    if(indexPath.section == 0){
        
        OMOAddressListVC *addressListVC = [[OMOAddressListVC alloc]init];
        
        addressListVC.selectAddress = ^(OMOUserAddressModel *addressModel) {
            
            weakSelf.buyModel.address = addressModel;
            NSIndexSet *indexSet = [[NSIndexSet alloc]initWithIndex:0];
            [weakSelf.tableView reloadSections:indexSet withRowAnimation:YES];
        };
        [self.navigationController pushViewController:addressListVC animated:YES];
    }else if (indexPath.section == 1){
        
        return;
    }else if (indexPath.section == 2){
        
        if(_buyType != 0){
            
            if(_payType == indexPath.row)return;
            
            _payType = indexPath.row;
            
            [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
            
            NSLog(@"%ld",_payType);
        }
    }else{
        
        if(_payType == indexPath.row)return;
        
        _payType = indexPath.row;
        
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        NSLog(@"%ld",_payType);
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0)return 120.f;
    return 60.f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if(section == 1){
        
        if(_buyType == 0 || _buyType == 1){
            
            OMOBuyTrainingPlanHeadView *headView = [[OMOBuyTrainingPlanHeadView alloc]init];
            headView.title = @"康复方案";
            return headView;
        }else if(_buyType == 2){
            
            OMOBuyTrainingPlanHeadView *headView = [[OMOBuyTrainingPlanHeadView alloc]init];
            headView.title = @"康复辅具";
            return headView;
        }
    }else if (section == 2){
        
        if(_buyType == 1 || _buyType == 2){
            
            return nil;
        }else{
            
            OMOBuyTrainingPlanHeadView *headView = [[OMOBuyTrainingPlanHeadView alloc]init];
            headView.title = @"康复辅具";
            return headView;
        }
    }else{
        
        
    }
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if(section == 1){
        
        if(_buyType == 0 || _buyType == 1){
            
            return self.planFootView;
        }else if(_buyType == 2){
            
            return self.deviceFootView;
        }
    }else if (section == 2){
        
        if(_buyType == 1 || _buyType == 2){
            
            return nil;
        }else{
            
            return self.deviceFootView;
        }
    }else{
        
        
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if(section == 0){
        
        return lwb_smallMargin;
    }else if(section == 1){

        return IFFitFloat6(80);
    }else if (section == 2){

        if(_buyType == 1 || _buyType == 2){

            return 0.f;
        }else{

            return IFFitFloat6(80);
        }
    }else{

        return 0.f;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if(section == 0){
        
        return lwb_smallMargin;
    }else if(section == 1){
    
        return IFFitFloat6(80);
    }else if (section == 2){

//        if(_buyType == 1 || _buyType == 2){
//
//            return 5.f;
//        }else{
//
//            return IFFitFloat6(80);
//        }
        return IFFitFloat6(80);
    }
//    return 5.f;
    return IFFitFloat6(lwb_margin);
}
#pragma mark -------- 积分抵扣开关按钮监测 --------
- (void)OMO_SwitchPointDeductionWithOn:(BOOL)isOn{
    
    if(isOn){
        
        double planPrice = _kangFuBaoModel.discount_price.doubleValue - _buyModel.point_rules.discount_price.doubleValue;
        self.planPrice = planPrice;
    }else{
    
        self.planPrice = _planPrice + _buyModel.point_rules.discount_price.doubleValue;
    }
}
#pragma mark ------- 是否选中 ----------
- (void)omo_goodsBuyWithGoodsId:(NSString *)goodsId Select:(BOOL)isSelect{
    
    double goodsTotalPrice = 0.0;
    
    for (OMOKangFuBaoMtItemModel *itemModel in _items) {
        
        if([itemModel.item_id isEqualToString:goodsId]){
            
            itemModel.isSelect = isSelect;
        }
        if(itemModel.isSelect){
            
            goodsTotalPrice += itemModel.unit_price.doubleValue * itemModel.num.integerValue;
        }
    }
    self.goodsTotalPrice = goodsTotalPrice;
}
#pragma mark ------ 商品数量变化 -------------
- (void)omo_goodsBuyWithGoodsId:(NSString *)goodsId GoodsNum:(NSInteger)goodsNum{
    
    double goodsTotalPrice = 0.0;
    
    for (OMOKangFuBaoMtItemModel *itemModel in _items) {
        
        if([itemModel.item_id isEqualToString:goodsId]){
            
            itemModel.num = [NSString stringWithFormat:@"%ld",goodsNum];
        }
        if(itemModel.isSelect){
            
            goodsTotalPrice += itemModel.unit_price.doubleValue * itemModel.num.integerValue;
        }
    }
    self.goodsTotalPrice = goodsTotalPrice;
}
#pragma mark ---------- 提交支付 ----------
- (void)omo_submitOrderDidClik{
    
    [self omo_payWithType:[NSString stringWithFormat:@"%ld",_payType + 1]];
}
#pragma mark ---------- 支付方式 ----------
- (void)omo_payWithType:(NSString *)payType{
    
    NSMutableDictionary *parmars = [NSMutableDictionary dictionary];
    
    if(_buyModel.address.ID.length <= 0){
        
        [MBProgress showErrorMessage:@"请选择收货地址"];
        return;
    }
    parmars[@"address_id"] = _buyModel.address.ID;// 收货地址
    parmars[@"pay_type"] = payType;// 支付类型:1微信,2支付宝,3通过分享获得
    
    parmars[@"pe_order_id"] = _kangFuBaoModel.pe_order_id.length > 0 ? _kangFuBaoModel.pe_order_id : _pe_order_id;// 支付订单号
    
    NSString *have_mt_order;
    NSMutableArray *array = [NSMutableArray array];
    
    if(_goodsTotalPrice > 0){
        
        have_mt_order = @"0";
        for (OMOKangFuBaoMtItemModel *itemModel in _items) {
            
            if(itemModel.isSelect){
                
                NSDictionary *dict = @{@"id":itemModel.item_id,@"num":itemModel.num};
                [array addObject:dict];
            }
        }
    }else{
        
        have_mt_order = @"1";
    }
    
    NSString *type;
    
    if(_numType == 1){
        
        type = @"init";
    }else{
        
        if(_buyType == 0){
            
            if(_goodsTotalPrice > 0){
                
                type = @"all";
            }else{
                
                type = @"treat_package_order";
            }
        }else if(_buyType == 1){
            
            type = @"treat_package_order";
        }else{
            
            type = @"mt_order";
        }
    }
    parmars[@"have_mt_order"] = have_mt_order;// 是否选择辅具订单
    parmars[@"mt_order"] = array;// 商品信息
    parmars[@"mt_total_price"] = [NSString stringWithFormat:@"%.2f",_goodsTotalPrice];// 辅具的总价,保留两位小数
    parmars[@"total_fee"] = [NSString stringWithFormat:@"%.2f",_totalPrice];
    parmars[@"type"] = type;
    
    if([payType isEqualToString:@"1"]){
        
        [self wechatPayWithOrderData:parmars];
    }else if ([payType isEqualToString:@"2"]){
        
        [self aliPayWithOrderData:parmars];
    }else if ([payType isEqualToString:@"3"]){
        
        
    }
}
#pragma mark - 微信支付
- (void)wechatPayWithOrderData:(NSDictionary *)dictionary{
    
    [[OMONetworkManager sharedData]postWithURLString:@"60000" parameters:dictionary success:^(id responseObject) {
        
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
    
    [[OMONetworkManager sharedData]postWithURLString:@"60000" parameters:dictionary success:^(id responseObject) {
        
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
        
        switch (_buyType) {
            case 0:{
                if(_goodsTotalPrice > 0){
                    
                    OMOAllPaySuccessVC *allPaySuccessVC = [[OMOAllPaySuccessVC alloc]init];
                    allPaySuccessVC.kangFuBaoModel = _kangFuBaoModel;
                    [self.navigationController pushViewController:allPaySuccessVC animated:YES];
                }else{
                    
                    OMOPlanPaySuccessVC *planPaySuccessVC = [[OMOPlanPaySuccessVC alloc]init];
                    planPaySuccessVC.kangFuBaoModel = _kangFuBaoModel;
                    [self.navigationController pushViewController:planPaySuccessVC animated:YES];
                }
                break;
            }
            case 1:{
                OMOPlanPaySuccessVC *planPaySuccessVC = [[OMOPlanPaySuccessVC alloc]init];
                planPaySuccessVC.kangFuBaoModel = _kangFuBaoModel;
                [self.navigationController pushViewController:planPaySuccessVC animated:YES];
                break;}
            case 2:{
                OMODevicePaySuccessVC *devicePaySuccessVC = [[OMODevicePaySuccessVC alloc]init];
                devicePaySuccessVC.pe_order_id = _pe_order_id.length > 0 ? _pe_order_id : _kangFuBaoModel.pe_order_id;
                [self.navigationController pushViewController:devicePaySuccessVC animated:YES];
                break;}
            default:
                break;
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
