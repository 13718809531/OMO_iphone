//
//  OMOAddAddressVC.m
//  OMO_iphone
//
//  Created by wy on 2018/10/11.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOAddAddressVC.h"
#import "BRPickerView.h"
/**  */
#import "UIButton+Category.h"
/**  */
#import "OMOAddAddressCell.h"

@interface OMOAddAddressVC ()<UITableViewDelegate,UITableViewDataSource>

/**  */
@property (nonatomic, strong)NSArray *addressData;
/**  */
@property (nonatomic, strong)UITableView *tableView;
/** 保存 */
@property (nonatomic, strong)UIButton *saveAddressBtn;

@end

static NSString *OMOAddAddressCellID = @"OMOAddAddressCellID";

@implementation OMOAddAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = mainBackColor;
    [self creatBar];
    [self.bar addTitltLabelWithText:@"新增收货地址" Font:navTitleFont];
    [self.bar addLeftButtonWithImage:[UIImage imageNamed:@"App_Back"]];
    
    [self omo_setAddressListData];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.saveAddressBtn];
}
- (void)omo_setAddressListData{
    
    NSString *name = _addressModel.name.length > 0 ? _addressModel.name : [OMOIphoneManager sharedData].nickname;
    NSDictionary *dict1 = @{@"title":@"姓名:",@"placeholder":@"最少2个,最多15个字",@"detail":checkNull(name),@"type":@"name"};
    NSString *mobile = _addressModel.mobile.length > 0 ? _addressModel.mobile : [OMOIphoneManager sharedData].mobile;
    NSDictionary *dict2 = @{@"title":@"电话:",@"placeholder":@"请输入手机号",@"detail":checkNull(mobile),@"type":@"mobile"};
    
    NSString *dress = @"";
    
    if(_addressModel.province.length > 0 || _addressModel.city.length > 0 || _addressModel.country.length > 0){
        
        dress = [NSString stringWithFormat:@"%@  %@  %@",_addressModel.province,_addressModel.city,_addressModel.country];
    }

    NSDictionary *dict3 = @{@"title":@"地区:",@"placeholder":@"省份  城市  区县",@"detail":checkNull(dress),@"type":@""};
    NSDictionary *dict4 = @{@"title":@"地址:",@"placeholder":@"请填写详细地址,5-60个字",@"detail":checkNull(_addressModel.address),@"type":@"detail"};
    
    _addressData = @[dict1,dict2,dict3,dict4];
}
#pragma mark ----------- 下一步跳转 ----------
- (UIButton *)saveAddressBtn{
    
    if(_saveAddressBtn == nil){
        
        _saveAddressBtn = [[UIButton alloc]init];
        _saveAddressBtn.lwb_size = CGSizeMake(SCREENW - 100, 40);
        _saveAddressBtn.lwb_centerX = self.view.lwb_centerX;
        _saveAddressBtn.lwb_bottom = SCREENH - 30;
        [_saveAddressBtn setTitle:@"保存" forState:UIControlStateNormal];
        _saveAddressBtn.backgroundColor = backColor;
        [_saveAddressBtn setTitleColor:WHITECOLORA(1) forState:UIControlStateNormal];
        _saveAddressBtn.layer.masksToBounds = YES;
        _saveAddressBtn.layer.cornerRadius = 20.f;
        _saveAddressBtn.titleLabel.font = bigFont;
        [_saveAddressBtn addTarget:self action:@selector(omo_saveAddressButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveAddressBtn;
}
- (UITableView *)tableView{
    
    if(_tableView == nil){
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, IphoneY, SCREENW, SCREENH - IphoneY - 80) style:UITableViewStylePlain];
        _tableView.backgroundColor = mainBackColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[OMOAddAddressCell class] forCellReuseIdentifier:OMOAddAddressCellID];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENW, 40)];
        footView.backgroundColor = _tableView.backgroundColor;
        
        UIButton *defaultBtn = [[UIButton alloc]initWithFrame:CGRectMake(lwb_margin * 2, lwb_margin, 170, 25)];
        [defaultBtn setImage:[UIImage imageNamed:@"Agreement_Normal"] forState:UIControlStateNormal];
        [defaultBtn setImage:[UIImage imageNamed:@"Agreement_Select"] forState:UIControlStateSelected];
        [defaultBtn setTitle:@"设置成默认收货地址" forState:UIControlStateNormal];
        [defaultBtn setTitleColor:textColour forState:UIControlStateNormal];
        defaultBtn.titleLabel.font = bigFont;
        [defaultBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:2.f];
        [defaultBtn addTarget:self action:@selector(omo_setDefaultAddress:) forControlEvents:UIControlEventTouchUpInside];
        if(_addressModel.is_default.length > 0){
            
            defaultBtn.selected = [_addressModel.is_default isEqualToString:@"1"] ? NO : YES;
        }else{
            
            defaultBtn.selected = YES;
            _addressModel.is_default = @"2";
        }
        [footView addSubview:defaultBtn];
        
        _tableView.tableFooterView = footView;;
    }
    return _tableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _addressData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OMOAddAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:OMOAddAddressCellID];
    
    cell.dict = _addressData[indexPath.row];
    
    if(indexPath.row == 2){
        
        cell.detailTfd.userInteractionEnabled = NO;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 2){
        
        __weak typeof(self) weakSelf = self;
        
        [BRAddressPickerView showAddressPickerWithDefaultSelected:@[@"0",@"0",@"0"] isAutoSelect:YES themeColor:nil resultBlock:^(BRProvinceModel *province, BRCityModel *city, BRAreaModel *area) {
            
            weakSelf.addressModel.province = province.name;
            weakSelf.addressModel.city = city.name;
            weakSelf.addressModel.country = area.name;
            
            OMOAddAddressCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            
            NSString *drss = [NSString stringWithFormat:@"%@  %@  %@",province.name,city.name,area.name];
            cell.detailTfd.text = drss;
        }];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80.f;
}
#pragma mark -------- 设置为默认收货地址 ---------
- (void)omo_setDefaultAddress:(UIButton *)sender{
    
    BOOL select = sender.selected;
    sender.selected = !select;
    _addressModel.is_default = sender.selected ? @"2" : @"1";
}
#pragma mark -------- 保存新增收货地址 ----------
- (void)omo_saveAddressButtonClick{
    
    for (int i = 0; i < _addressData.count; i ++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        OMOAddAddressCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
        
        if(i == 0){
            
            if(cell.detailTfd.text.length < 2){
                
                [MBProgress showErrorMessage:@"请填写正确的收货人姓名"];
                return;
            }else{
                
                NSString *name = cell.detailTfd.text;
                _addressModel.name = name;
            }
        }
        if(i == 1){
            
            if(cell.detailTfd.text.length < 11){
                
                [MBProgress showErrorMessage:@"请填写正确的收货人联系方式"];
                return;
            }else{
                
                NSString *mobile = cell.detailTfd.text;
                _addressModel.mobile = mobile;
            }
        }
        if(i == 2){
            
            if(cell.detailTfd.text.length < 6){
                
                [MBProgress showErrorMessage:@"请填写正确的收货人所在省.市.区"];
                return;
            }
        }
        if(i == 3){
            
            if(cell.detailTfd.text.length < 5){
                
                [MBProgress showErrorMessage:@"请填写详细的收货人地址"];
                return;
            }else{
                
                NSString *address = cell.detailTfd.text;
                _addressModel.address = address;
            }
        }
    }
    
    NSMutableDictionary *parmars = [NSMutableDictionary dictionary];
    if(_addressModel.ID.length > 0){
        
        parmars[@"address_id"] = _addressModel.ID;
    }
    parmars[@"address"] = _addressModel.address;
    parmars[@"mobile"] = _addressModel.mobile;
    parmars[@"name"] = _addressModel.name;
    parmars[@"province"] = _addressModel.province;
    parmars[@"city"] = _addressModel.city;
    parmars[@"country"] = _addressModel.country;
    parmars[@"is_default"] = _addressModel.is_default;
    
    [[OMONetworkManager sharedData]postWithURLString:@"20003" parameters:parmars success:^(id responseObject) {

        if(responseObject){

            [MBProgress showInfoMessage:@"添加收货地址成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {

        [MBProgress hideAllHUD];
    }];
}
@end
