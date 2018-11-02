//
//  YXMineVC.m
//  OMO_iphone
//
//  Created by 刘卫兵 on 2018/9/6.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOMineVC.h"
#import "OMOMineHeadCell.h"// 顶部cell
#import "OMOEditAppDetaiVC.h"// 用户信息设置
#import "OMOEditUserDetailVC.h"// 设置
#import "OMOMineShowCell.h"// cell
#import "OMOFeedbackVC.h"// 意见反馈
#import "OMOMyHealthReportVC.h"//健康报告
#import "OMOMyBookingList.h"//线下预约
/**  */
#import "OMOLoginMobileVC.h"
/** 我的训练方案 */
#import "OMOTrainingListVC.h"
/** 我的购买方案 */
#import "OMOBuyPlanListVC.h"

@interface OMOMineVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
/** 1,2,3分区数据 */
@property (nonatomic, strong)NSArray *zeroSectionSouce;
@property (nonatomic, strong)NSArray *oneSectionSouce;
@property (nonatomic, strong)NSArray *twoSectionSouce;
/** 记录账户信息 */
@property (nonatomic,copy)NSString *user_id;

@end

static NSString *OMOMineHeadCellID = @"OMOMineHeadCellID";
static NSString *OMOMineShowCellID = @"OMOMineShowCellID";

@implementation OMOMineVC

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
 
    [self omo_determineLoginInformation];
}
- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
}
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
    
    _user_id = [OMOIphoneManager sharedData].user_id;
    [self setDataSouce];
}
- (void)setDataSouce{
    
    NSString *title;
    
    if([OMOIphoneManager sharedData].user_id.length > 0){
        
        title = @"点击编辑资料";
    }else{
        
        title = @"立即登录";
    }
    
    NSString *avatar_url = @"";
    
    if([OMOIphoneManager sharedData].user_id.length > 0){
        
        avatar_url = [OMOIphoneManager sharedData].avatar_url;
    }
    NSDictionary *dictionary = @{@"image":checkNull(avatar_url),@"title":title};
    _zeroSectionSouce = @[dictionary];
    
    NSDictionary *dict1 = @{@"image":@"Mine_xunlian",@"title":@"我的训练方案"};
    NSDictionary *dict2 = @{@"image":@"Mine_report",@"title":@"我的健康报告"};
    NSDictionary *dict3 = @{@"image":@"Mine_order",@"title":@"我的购买方案"};
    NSDictionary *dict4 = @{@"image":@"Mine_make",@"title":@"我的预约"};
    _oneSectionSouce = @[dict1,dict2,dict3,dict4];
    
    NSDictionary *dic1 = @{@"image":@"Mine_opinion",@"title":@"意见反馈"};
    NSDictionary *dic2 = @{@"image":@"Mine_setting",@"title":@"设置"};
    _twoSectionSouce = @[dic1,dic2];
    
    if(self.tableView.superview){
        
        [self.tableView reloadData];
    }else{
        
        [self.view addSubview:self.tableView];
    }
}
- (UITableView *)tableView{
    
    if(_tableView == nil){
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENW, SCREENH - TabBarHeight) style:UITableViewStylePlain];
        _tableView.backgroundColor = mainBackColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 1, 0);
        [_tableView registerClass:[OMOMineHeadCell class] forCellReuseIdentifier:OMOMineHeadCellID];
        [_tableView registerClass:[OMOMineShowCell class] forCellReuseIdentifier:OMOMineShowCellID];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc]init];
    }
    return _tableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(section == 0){
        
        return 1;
    }else if (section == 1){
        
        return _oneSectionSouce.count;
    }
    return _twoSectionSouce.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0){
        
        OMOMineHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:OMOMineHeadCellID];
        cell.dict = _zeroSectionSouce[indexPath.row];
        return cell;
    }else if (indexPath.section == 1){
        
        OMOMineShowCell *cell = [tableView dequeueReusableCellWithIdentifier:OMOMineShowCellID];
        cell.dataSouce = _oneSectionSouce[indexPath.row];
        return cell;
    }else if(indexPath.section == 2){
        
        OMOMineShowCell *cell = [tableView dequeueReusableCellWithIdentifier:OMOMineShowCellID];
        cell.dataSouce = _twoSectionSouce[indexPath.row];
        return cell;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if([OMOIphoneManager sharedData].user_id.length <= 0){
        
        OMOLoginMobileVC *loginVC = [[OMOLoginMobileVC alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
        return;
    }
    if(indexPath.section == 0){
            
        OMOEditUserDetailVC *editUserVC = [[OMOEditUserDetailVC alloc]init];
        [self.navigationController pushViewController:editUserVC animated:YES];
    }else if (indexPath.section == 1){
        
        if(indexPath.row == 0){
            
            OMOTrainingListVC *trainingListVC = [[OMOTrainingListVC alloc]init];
            [self.navigationController pushViewController:trainingListVC animated:YES];
        }else if(indexPath.row == 1){
            
            OMOMyHealthReportVC *healthReport = [[OMOMyHealthReportVC alloc]init];
            [self.navigationController pushViewController:healthReport animated:YES];
        }else if (indexPath.row == 2){
            
            OMOBuyPlanListVC *buyPlanVC = [[OMOBuyPlanListVC alloc]init];
            [self.navigationController pushViewController:buyPlanVC animated:YES];
        }else if (indexPath.row == 3){
            
            OMOMyBookingList *appointment = [[OMOMyBookingList alloc]init];
            [self.navigationController pushViewController:appointment animated:YES];
        }
    }else if (indexPath.section == 2){
        
        if(indexPath.row == 0){
            
            OMOFeedbackVC *feedbackVC = [[OMOFeedbackVC alloc]init];
            [self.navigationController pushViewController:feedbackVC animated:YES];
        }else if(indexPath.row == 1){
            
            OMOEditAppDetaiVC *editAppVC = [[OMOEditAppDetaiVC alloc]init];
            [self.navigationController pushViewController:editAppVC animated:YES];
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0)return 220.f + Between;
    return 60.f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if(section == 1){
        
        UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENW, 10)];
        footView.backgroundColor = mainBackColor;
        return footView;
    }
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if(section == 1){
        
        UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENW, 10)];
        headView.backgroundColor = mainBackColor;
        return headView;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if(section == 1)return lwb_margin;
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if(section == 1)return lwb_margin;
    return 0;
}
#pragma mark ------- 判断登录信息 ----------
- (void)omo_determineLoginInformation{
    
    NSString *newUser_id = [OMOIphoneManager sharedData].user_id;
    
    if(![checkNull(newUser_id) isEqualToString:checkNull(_user_id)]){
        
        [self setDataSouce];
        
        _user_id = newUser_id;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
