//
//  OMOMyHealthReport.m
//  OMO_iphone
//
//  Created by 郭越 on 2018/10/18.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOMyHealthReportVC.h"

#import "OMOMyHealthReportCell.h"
/**  */
#import "OMOHealthReportModel.h"

@interface OMOMyHealthReportVC ()<UITableViewDelegate,UITableViewDataSource>

/**  */
@property (nonatomic, strong)NSMutableArray <OMOHealthReportModel *> *reportSouce;

@property (nonatomic, strong)UITableView *tableView;
/**  */
@property (nonatomic,assign)NSInteger page;

@end

static NSString *OMOMyHealthReportCellID = @"OMOMyHealthReportCellID";

@implementation OMOMyHealthReportVC
- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //我的健康报告页面
    [self creatBar];
    [self.bar addLeftButtonWithImage:[UIImage imageNamed:@"App_Back"]];
    [self.bar addTitltLabelWithText:@"我的健康报告" Font:navTitleFont];
    _page = -1;
    _reportSouce = [NSMutableArray array];
    [self omo_requestDataSouce];
    [self.view addSubview:self.tableView];
}
- (void)omo_requestDataSouce{
    
    __weak typeof(self) weakSelf = self;

    NSDictionary *parmars = @{@"page_size":[NSString stringWithFormat:@"%ld",_page]};
    
    [[OMONetworkManager sharedData] postWithURLString:@"20006" parameters:parmars success:^(id responseObject) {
        
        if(responseObject){
            
            NSDictionary *dataSouce = (NSDictionary *)responseObject;
            
            [weakSelf.tableView.mj_footer endRefreshing];
            
            NSArray *array = [NSArray arrayWithArray:[OMOHealthReportModel mj_objectArrayWithKeyValuesArray:dataSouce[@"pe_order_list"]]];
            
            if(array.count < 10){
                
                [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
                weakSelf.tableView.mj_footer.hidden = YES;
            }else{
                
                [weakSelf.tableView.mj_footer resetNoMoreData];
                weakSelf.tableView.mj_footer.hidden = NO;
            }
            if(weakSelf.page == 0){
                
                weakSelf.reportSouce = [NSMutableArray arrayWithArray:array];
            }else{
                
                [weakSelf.reportSouce addObjectsFromArray:array];
            }
            [weakSelf.tableView reloadData];
        }
    } failure:^(NSError *error) {
        
        [MBProgress hideAllHUD];
    }];
}
- (UITableView *)tableView{
    
    if(_tableView == nil){
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, IphoneY, SCREENW, SCREENH - TabBarHeight) style:UITableViewStylePlain];
        _tableView.backgroundColor = mainBackColor;
        [_tableView  setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 1, 0);
        [_tableView registerClass:[OMOMyHealthReportCell class] forCellReuseIdentifier:OMOMyHealthReportCellID];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc]init];
        __weak typeof(self) weakSelf = self;
        // 上拉刷新
        _tableView.mj_footer = [MJRefreshAutoNormalFooter  footerWithRefreshingBlock:^{
            
            weakSelf.page ++;
            
            [weakSelf omo_requestDataSouce];
        }];
        _tableView.mj_footer.hidden = YES;
    }
    return _tableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _reportSouce.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        
    OMOMyHealthReportCell *cell = [tableView dequeueReusableCellWithIdentifier:OMOMyHealthReportCellID];
    cell.reportModel = _reportSouce[indexPath.row];
    cell.backgroundColor = mainBackColor;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 110.f;
}
@end
