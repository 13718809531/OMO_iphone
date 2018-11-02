//
//  OMOEditAppDetaiVC.m
//  OMO_iphone
//
//  Created by wy on 2018/9/17.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOEditAppDetaiVC.h"
/** 收货地址 */
#import "OMOAddressListVC.h"
/** 账号设置 */
#import "OMOAccountManageVC.h"
/**  */
#import "OMOPublicAgreementVC.h"
/**  */
#import "OMOClearCacheVC.h"
/**  */
#import <JPUSHService.h>
/**  */
#import "OMOLoginMobileVC.h"

#import "OMOMineShowCell.h"

@interface OMOEditAppDetaiVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSArray *dataSouce;

@end

static NSString *OMOMineShowCellID = @"OMOMineShowCellID";

@implementation OMOEditAppDetaiVC
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
    
    self.view.backgroundColor = mainBackColor;
    [self creatBar];
    [self.bar addLeftButtonWithImage:[UIImage imageNamed:@"App_Back"]];
    [self.bar addTitltLabelWithText:@"设置" Font:navTitleFont];
    [self setDataSouce];
    [self.view addSubview:self.tableView];
    
    UIButton *defaultBtn = [[UIButton alloc]initWithFrame:CGRectMake(IFFitFloat6(lwb_margin * 4), SCREENH - 80, SCREENW - IFFitFloat6(lwb_margin * 8), 40)];
    [defaultBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [defaultBtn setTitleColor:textColour forState:UIControlStateNormal];
    defaultBtn.titleLabel.font = navTitleFont;
    defaultBtn.backgroundColor = WHITECOLORA(1);
    defaultBtn.layer.cornerRadius = 20.f;
    [defaultBtn addTarget:self action:@selector(omo_exitLogin) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:defaultBtn];
}
- (void)setDataSouce{
    
    NSDictionary *dict1 = @{@"image":@"Mine_About",@"title":@"关于我们"};
    NSDictionary *dict2 = @{@"image":@"Mine_About",@"title":@"收货地址"};
    NSDictionary *dict3 = @{@"image":@"Mine_About",@"title":@"账号管理"};
    NSDictionary *dict4 = @{@"image":@"Mine_Clear",@"title":@"清除缓存"};
    
    _dataSouce = @[dict1,dict2,dict3,dict4];
}
- (UITableView *)tableView{
    
    if(_tableView == nil){
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, IphoneY + lwb_margin, SCREENW, SCREENH - lwb_margin - IphoneY - TabBarHeight) style:UITableViewStylePlain];
        _tableView.backgroundColor = mainBackColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 1, 0);
        [_tableView registerClass:[OMOMineShowCell class] forCellReuseIdentifier:OMOMineShowCellID];
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
    
    return _dataSouce.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        
    OMOMineShowCell *cell = [tableView dequeueReusableCellWithIdentifier:OMOMineShowCellID];
    cell.dataSouce = _dataSouce[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 0){
        
        OMOPublicAgreementVC *aboutVC = [[OMOPublicAgreementVC alloc]init];
        aboutVC.agreementType = 4;
        [self.navigationController pushViewController:aboutVC animated:YES];
    }else if(indexPath.row == 1){
        
        OMOAddressListVC *addressListVC = [[OMOAddressListVC alloc]init];
        [self.navigationController pushViewController:addressListVC animated:YES];
    }else if(indexPath.row == 2){
        
        OMOAccountManageVC *accountManageVC = [[OMOAccountManageVC alloc]init];
        [self.navigationController pushViewController:accountManageVC animated:YES];
    }else if(indexPath.row == 3){
        
        OMOClearCacheVC *clearCacheVC = [[OMOClearCacheVC alloc]init];
        [self.navigationController pushViewController:clearCacheVC animated:YES];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60.f;
}
#pragma mark ------- 退出登录 --------
- (void)omo_exitLogin{
    
    // 退出激光
    NSString *mobile = [OMOIphoneManager sharedData].mobile;
    [JPUSHService deleteTags:[NSSet setWithObject:mobile] completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
        
    } seq:0];
    
    // 退出网易
    [[NIMSDK sharedSDK].loginManager logout:^(NSError * _Nullable error) {
        
        if(error){
            
//            [MBProgress showErrorMessage:@"退出网易失败"];
        }
    }];
    
    [OMOIphoneManager sharedData].user_id = @"";
    [OMOIphoneManager sharedData].mobile = @"";
    [OMOIphoneManager sharedData].avatar_url = @"";
    
    OMOLoginMobileVC *loginMobileVC = [[OMOLoginMobileVC alloc]init];
    [self.navigationController pushViewController:loginMobileVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
