//
//  OMOEditUserDetailVC.m
//  OMO_iphone
//
//  Created by wy on 2018/9/17.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOEditUserDetailVC.h"
#import "OMOEditUserHeadImgCell.h"// 更换头像
#import "OMOUserDetailShowCell.h"// 用户信息
/**  */
#import "OMONickNameEditVC.h"

#import "BRPickerView.h"

@interface OMOEditUserDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSArray *dataSouce;

@end

static NSString *OMOEditUserHeadImgCellID = @"OMOEditUserHeadImgCellID";
static NSString *OMOUserDetailShowCellID = @"OMOUserDetailShowCellID";

@implementation OMOEditUserDetailVC
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self omo_setUserDataSouce];
}
- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatBar];
    [self.bar addLeftButtonWithImage:[UIImage imageNamed:@"App_Back"]];
    [self.bar addTitltLabelWithText:@"编辑资料" Font:navTitleFont];
    
    [self.view addSubview:self.tableView];
}
- (void)omo_setUserDataSouce{
    
    _dataSouce = @[@"nickname",@"gender",@"height",@"weight",@"birthday",@"mobile"];
    [self.tableView reloadData];
}

- (UITableView *)tableView{
    
    if(_tableView == nil){
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, IphoneY, SCREENW, SCREENH - IphoneY - Between) style:UITableViewStylePlain];
        _tableView.backgroundColor = mainBackColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 1, 0);
        [_tableView registerClass:[OMOEditUserHeadImgCell class] forCellReuseIdentifier:OMOEditUserHeadImgCellID];
        [_tableView registerClass:[OMOUserDetailShowCell class] forCellReuseIdentifier:OMOUserDetailShowCellID];
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
    
    return _dataSouce.count + 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 0){
        
        OMOEditUserHeadImgCell *cell = [tableView dequeueReusableCellWithIdentifier:OMOEditUserHeadImgCellID];
        
        return cell;
    }else{
        
        OMOUserDetailShowCell *cell = [tableView dequeueReusableCellWithIdentifier:OMOUserDetailShowCellID];
        
        cell.type = _dataSouce[indexPath.row - 1];
        
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row != 0){
        
        NSMutableArray *dataSouce = [NSMutableArray array];
        
        OMOIphoneManager *manager = [OMOIphoneManager sharedData];
        
        OMOUserDetailShowCell *showCell = [tableView cellForRowAtIndexPath:indexPath];
        
        NSString *type = showCell.type;
        
        if([type isEqualToString:@"nickname"]){
            
            OMONickNameEditVC *nickNameEditVC = [[OMONickNameEditVC alloc]init];
            [self.navigationController pushViewController:nickNameEditVC animated:YES];
        }else if([type isEqualToString:@"gender"]){
            
            
        }else if([type isEqualToString:@"height"]){
            
            for (int i = 40; i < 230; i ++) {
                
                [dataSouce addObject:[NSString stringWithFormat:@"%d",i]];
            }
            // 自定义单列字符串
            [BRStringPickerView showStringPickerWithTitle:@"请选择身高" dataSource:dataSouce defaultSelValue:manager.gender isAutoSelect:NO themeColor:nil resultBlock:^(id selectValue) {
                
                [self omo_editUserDetailsWithTableViewCell:showCell Type:type Value:selectValue];
            }];
        }else if([type isEqualToString:@"weight"]){
            
            for (int i = 20; i < 300; i ++) {
                
                [dataSouce addObject:[NSString stringWithFormat:@"%d",i]];
            }
            // 自定义单列字符串
            [BRStringPickerView showStringPickerWithTitle:@"请选择体重" dataSource:dataSouce defaultSelValue:manager.gender isAutoSelect:NO themeColor:nil resultBlock:^(id selectValue) {
                
                [self omo_editUserDetailsWithTableViewCell:showCell Type:type Value:selectValue];
            }];
        }else if([type isEqualToString:@"birthday"]){
            
            //得到当前的时间
            NSDate * nowDate = [NSDate date];
            NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
           
            NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            NSDateComponents *comps = nil;
//            comps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitMonth fromDate:mydate];
            comps = [calendar components:NSCalendarUnitYear fromDate:nowDate];
            NSDateComponents *adcomps = [[NSDateComponents alloc] init];
            [adcomps setYear:-40];
            NSDate *defaultDate = [calendar dateByAddingComponents:adcomps toDate:nowDate options:0];
            NSString *defaultDateStr = [dateFormatter stringFromDate:defaultDate];
            
            if([OMOIphoneManager sharedData].birthday.length > 9){
                
                defaultDateStr = [OMOIphoneManager sharedData].birthday;
            }
            [adcomps setYear:-100];
            NSDate *minDate = [calendar dateByAddingComponents:adcomps toDate:nowDate options:0];
            
            [BRDatePickerView showDatePickerWithTitle:@"请选择出生日期" dateType:BRDatePickerModeDate defaultSelValue:defaultDateStr minDate:minDate  maxDate:nowDate isAutoSelect:NO themeColor:nil resultBlock:^(NSString *selectValue) {
                
                if([selectValue isEqualToString:[OMOIphoneManager sharedData].birthday])return ;
                
                [self omo_editUserDetailsWithTableViewCell:showCell Type:type Value:selectValue];
            }];
        }else if([type isEqualToString:@"mobile"]){
            
            
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 0)return IFFitFloat6(120.f);
    return 60.f;
}
- (void)omo_editUserDetailsWithTableViewCell:(OMOUserDetailShowCell *)cell Type:(NSString *)type Value:(NSString *)value{
    
    NSDictionary *parmars = @{type:value};
    
//    __weak typeof(self) weakSelf = self;
    
    [[OMONetworkManager sharedData] postWithURLString:@"20001" parameters:parmars success:^(id responseObject) {
        
        if(responseObject){
            
            NSDictionary *dataSouce = (NSDictionary *)responseObject;
            
            [OMOIphoneManager initWithDictionary:dataSouce];
            
//            [weakSelf.tableView reloadData];
            cell.type = type;
        }
    } failure:^(NSError *error) {
        
        [MBProgress hideAllHUD];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
