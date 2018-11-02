//
//  OMOAccountManageVC.m
//  OMO_iphone
//
//  Created by wy on 2018/10/13.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOAccountManageVC.h"
/** 微信解绑 */
#import "OMOAccountWXCell.h"
/**  */
#import "OMOAccountMobileCell.h"
/**  */
#import "OMOChangeMobileVC.h"

@interface OMOAccountManageVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;

@end

static NSString *OMOAccountWXCellID = @"OMOAccountWXCellID";
static NSString *OMOAccountMobileCellID = @"OMOAccountMobileCellID";

@implementation OMOAccountManageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatBar];
    [self.bar addLeftButtonWithImage:[UIImage imageNamed:@"App_Back"]];
    [self.bar addTitltLabelWithText:@"账号管理" Font:navTitleFont];
    
    [self.view addSubview:self.tableView];
}
- (UITableView *)tableView{
    
    if(_tableView == nil){
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, IphoneY, SCREENW, SCREENH - IphoneY - Between) style:UITableViewStylePlain];
        _tableView.backgroundColor = mainBackColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 1, 0);
        [_tableView registerClass:[OMOAccountWXCell class] forCellReuseIdentifier:OMOAccountWXCellID];
        [_tableView registerClass:[OMOAccountMobileCell class] forCellReuseIdentifier:OMOAccountMobileCellID];
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
    
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 0){
        
        OMOAccountWXCell *cell = [tableView dequeueReusableCellWithIdentifier:OMOAccountWXCellID];
        
        return cell;
    }
    OMOAccountMobileCell *cell = [tableView dequeueReusableCellWithIdentifier:OMOAccountMobileCellID];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 1){
        
        OMOChangeMobileVC *changeMobileVC = [[OMOChangeMobileVC alloc]init];
        [self.navigationController pushViewController:changeMobileVC animated:YES];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60.f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
