//
//  OMOAddressListVC.m
//  OMO_iphone
//
//  Created by wy on 2018/10/11.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOAddressListVC.h"
/** 新增收货地址 */
#import "OMOAddAddressVC.h"
/**  */
#import "OMOUserAddressModel.h"
/** 地址cell */
#import "OMOAddressCell.h"

@interface OMOAddressListVC ()<UITableViewDelegate,UITableViewDataSource>

/**  */
@property (nonatomic, strong)NSArray <OMOUserAddressModel *> *addressList;
/**  */
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)UIButton *addAddressBtn;

@end

static NSString *OMOAddressCellID = @"OMOAddressCellID";

@implementation OMOAddressListVC

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self omo_requestAddressListData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = mainBackColor;
    [self creatBar];
    [self.bar addTitltLabelWithText:@"我的收货地址" Font:navTitleFont];
    [self.bar addLeftButtonWithImage:[UIImage imageNamed:@"App_Back"]];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.addAddressBtn];
}
- (void)omo_requestAddressListData{
    
    __weak typeof(self) weakSelf = self;
    [[OMONetworkManager sharedData]postWithURLString:@"20002" parameters:nil success:^(id responseObject) {
        
        if(responseObject){
            
            NSDictionary *dataSouce = (NSDictionary *)responseObject;
            
            weakSelf.addressList = [OMOUserAddressModel mj_objectArrayWithKeyValuesArray:dataSouce[@"address_list"]];
            
            if(weakSelf.addressList.count > 0){
                
                [weakSelf.tableView reloadData];
            }
        }
    } failure:^(NSError *error) {
        
        [MBProgress hideAllHUD];
    }];
}
#pragma mark ----------- 下一步跳转 ----------
- (UIButton *)addAddressBtn{
    
    if(_addAddressBtn == nil){
        
        _addAddressBtn = [[UIButton alloc]init];
        _addAddressBtn.lwb_size = CGSizeMake(SCREENW - 100, 40);
        _addAddressBtn.lwb_centerX = self.view.lwb_centerX;
        _addAddressBtn.lwb_bottom = SCREENH - 30;
        [_addAddressBtn setTitle:@"新增收货地址" forState:UIControlStateNormal];
        _addAddressBtn.backgroundColor = backColor;
        [_addAddressBtn setTitleColor:WHITECOLORA(1) forState:UIControlStateNormal];
        _addAddressBtn.layer.masksToBounds = YES;
        _addAddressBtn.layer.cornerRadius = 20.f;
        _addAddressBtn.titleLabel.font = bigFont;
        [_addAddressBtn addTarget:self action:@selector(omo_addAddressButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addAddressBtn;
}
- (UITableView *)tableView{
    
    if(_tableView == nil){
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, IphoneY, SCREENW, SCREENH - IphoneY - 80) style:UITableViewStylePlain];
        _tableView.backgroundColor = mainBackColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[OMOAddressCell class] forCellReuseIdentifier:OMOAddressCellID];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc]init];
    }
    return _tableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _addressList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        
    OMOAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:OMOAddressCellID];
    
    cell.addressModel = _addressList[indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(self.selectAddress){

        self.selectAddress(_addressList[indexPath.row]);
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100.f;
}
#pragma mark ------- 侧滑功能 ----------
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
    }
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return YES;
}
//
- (UITableViewCellEditingStyle)tableView:(UITableView*)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
}
//设置滑动时显示多个按钮
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OMOUserAddressModel *addressModel = _addressList[indexPath.row];
    
    __weak typeof(self) weakSelf = self;
    //添加一个默认按钮
    UITableViewRowAction *defaultAction = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDestructive) title:@"设为默认" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        
        if([addressModel.is_default isEqualToString:@"2"])return ;
        [weakSelf omo_edtingAddressWithAddressModel:addressModel];
    }];
    defaultAction.backgroundColor = DetailColor;
    
    // 添加删除按钮
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDestructive) title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        
        [self omo_deleteAddressWithAddress_id:addressModel.ID];
    }];
    deleteAction.backgroundColor = backColor;
    
    return @[deleteAction,defaultAction];
}
#pragma mark ------- 更改收货地址为默认 -----------
- (void)omo_edtingAddressWithAddressModel:(OMOUserAddressModel *)addressModel{
    
    NSMutableDictionary *parmars = [NSMutableDictionary dictionary];
    parmars[@"address_id"] = addressModel.ID;
    parmars[@"address"] = addressModel.address;
    parmars[@"mobile"] = addressModel.mobile;
    parmars[@"name"] = addressModel.name;
    parmars[@"province"] = addressModel.province;
    parmars[@"city"] = addressModel.city;
    parmars[@"country"] = addressModel.country;
    parmars[@"is_default"] = @"2";
    
    [[OMONetworkManager sharedData]postWithURLString:@"20003" parameters:parmars success:^(id responseObject) {
        
        if(responseObject){
            
            [MBProgress showInfoMessage:@"设置默认地址成功"];
            [self omo_requestAddressListData];
        }
    } failure:^(NSError *error) {
        
        [MBProgress hideAllHUD];
    }];
}
#pragma mark ------- 删除收货地址 -----------
- (void)omo_deleteAddressWithAddress_id:(NSString *)address_id{
    
    NSMutableDictionary *parmars = [NSMutableDictionary dictionary];
    parmars[@"address_ids"] = address_id;
    
    [[OMONetworkManager sharedData]postWithURLString:@"20005" parameters:parmars success:^(id responseObject) {
        
        if(responseObject){
            
            [MBProgress showInfoMessage:@"删除收货地址成功"];
            [self omo_requestAddressListData];
        }
    } failure:^(NSError *error) {
        
        [MBProgress hideAllHUD];
    }];
}
#pragma mark -------- 新增收货地址 ----------
- (void)omo_addAddressButtonClick{
    
    OMOAddAddressVC *addAddressVC = [[OMOAddAddressVC alloc]init];
    addAddressVC.addressModel = [[OMOUserAddressModel alloc]init];
    [self.navigationController pushViewController:addAddressVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
