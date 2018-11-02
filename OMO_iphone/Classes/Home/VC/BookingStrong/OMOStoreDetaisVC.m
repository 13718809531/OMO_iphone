//
//  OMOStrongDetaisVC.m
//  OMO_iphone
//
//  Created by wy on 2018/10/9.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOStoreDetaisVC.h"
/** 顶部 */
#import "OMOStoreDetailsHeadView.h"
//** 预约门店 */
#import "OMOBookingStoreVC.h"
/** 门店联系信息 */
#import "OMOStoreUserCell.h"
/** 描述信息 */
#import "OMOStoreDescCell.h"
/** 登录 */
#import "OMOLoginMobileVC.h"

@interface OMOStoreDetaisVC ()<UITableViewDelegate,UITableViewDataSource>

/** 顶部 */
@property (nonatomic, strong)OMOStoreDetailsHeadView *headView;
/**  */
@property (nonatomic, strong)UITableView *tableView;
/** 预约 */
@property (nonatomic, strong)UIButton *bookingBtn;

@end

static NSString *OMOStoreUserCellID = @"OMOStoreUserCellID";
static NSString *OMOStoreDescCellID = @"OMOStoreDescCellID";

@implementation OMOStoreDetaisVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self omo_requestStoreDetailsData];
    
    [self.view addSubview:self.bookingBtn];
}
- (void)omo_requestStoreDetailsData{
    
    NSDictionary *parmars = @{@"store_id":_storeModel.store_id};
    
    __weak typeof(self) weakSelf = self;
    
    [[OMONetworkManager sharedData]postWithURLString:@"41002" parameters:parmars success:^(id responseObject) {
        
        if(responseObject){
            
            NSDictionary *dataSouce = (NSDictionary *)responseObject;
            
            weakSelf.storeModel = [OMOStoreModel mj_objectWithKeyValues:dataSouce[@"store_info"]];
            
            [weakSelf.view addSubview:weakSelf.tableView];
        }
    } failure:^(NSError *error) {
        
        [MBProgress hideAllHUD];
    }];
}
- (OMOStoreDetailsHeadView *)headView{
    
    if(_headView == nil){
        
        _headView = [[OMOStoreDetailsHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREENW, IFFitFloat6(300))];
        _headView.storeModel = _storeModel;
    }
    return _headView;
}
- (UIButton *)bookingBtn{
    
    if(_bookingBtn == nil){
        
        _bookingBtn = [[UIButton alloc]init];
        _bookingBtn.lwb_x = 0;
        _bookingBtn.lwb_width = SCREENW;
        _bookingBtn.lwb_height = 40.f;
        _bookingBtn.lwb_bottom = SCREENH;
        _bookingBtn.backgroundColor = backColor;
        [_bookingBtn setTitle:@"预约" forState:UIControlStateNormal];
        [_bookingBtn setTitleColor:WHITECOLORA(1) forState:UIControlStateNormal];
        _bookingBtn.titleLabel.font = navTitleFont;
        [_bookingBtn addTarget:self action:@selector(omo_bookingStore) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bookingBtn;
}
- (UITableView *)tableView{
    
    if(_tableView == nil){
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENW, SCREENH - 44) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = mainBackColor;
        [_tableView registerClass:[OMOStoreUserCell class] forCellReuseIdentifier:OMOStoreUserCellID];
        [_tableView registerClass:[OMOStoreDescCell class] forCellReuseIdentifier:OMOStoreDescCellID];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _tableView.tableHeaderView = self.headView;
        
        if (@available(iOS 11.0, *)) {
            
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
        }else {
            
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _tableView;
}
#pragma mark ------- UITableViewDataSouce -----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(section == 0){
        
       return 1;
    }
    return _storeModel.sowing_map.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0){
            
        OMOStoreUserCell *cell = [tableView dequeueReusableCellWithIdentifier:OMOStoreUserCellID];
        
        cell.contacts = _storeModel.contacts;
        cell.mobile = _storeModel.mobile;
        
        return cell;
    }
    OMOStoreDescCell *cell = [tableView dequeueReusableCellWithIdentifier:OMOStoreDescCellID];
    
    cell.sowing_mapModel = _storeModel.sowing_map[indexPath.row];
    
    return cell;;
}
#pragma mark ---------- UITableViewDalegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0){
        
        return 130.f;
    }
    OMOStoreSowing_mapModel *sowing_mapModel = _storeModel.sowing_map[indexPath.row];
    
    CGFloat height = sowing_mapModel.titleHeight + sowing_mapModel.imageHeight;
    
    return height;
}
- (void)omo_bookingStore{
    
    OMOBookingStoreVC *bookingStoreVC = [[OMOBookingStoreVC alloc]init];
    bookingStoreVC.storeModel = _storeModel;
    [self.navigationController pushViewController:bookingStoreVC animated:YES];
//    if([OMOIphoneManager sharedData].user_id.length > 0){
//        
//        OMOBookingStoreVC *bookingStoreVC = [[OMOBookingStoreVC alloc]init];
//        [self.navigationController pushViewController:bookingStoreVC animated:YES];
//    }else{
//        
//        OMOLoginMobileVC *loginMobileVC = [[OMOLoginMobileVC alloc]init];
//        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:loginMobileVC];
//        [self.navigationController presentViewController:nav animated:YES completion:nil];
//    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
