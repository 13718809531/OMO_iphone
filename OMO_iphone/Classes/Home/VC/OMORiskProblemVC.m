//
//  OMORiskProblemVC.m
//  OMO_iphone
//
//  Created by wy on 2018/9/21.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMORiskProblemVC.h"
#import "OMORiskProblemCell.h"
#import "OMORiskProblemModel.h"
#import "OMORiskProblemHeadView.h"
/** 远程视频,或者线下预约 */
#import "OMOMakeAssessVC.h"
/** 评估问卷 */
#import "OMOAssessmentQuestionnaireVC.h"
/**  */
#import "UIButton+Category.h"
/** 服务协议 */
#import "OMOPublicAgreementVC.h"

@interface OMORiskProblemVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray <OMORiskProblemModel *> *dataSouce;
/** 有 */
@property (nonatomic, strong)UIButton *areBtn;
/** 同意用户协议 */
@property (nonatomic, strong)UIButton *agreementBtn;
/** 查看协议 */
@property (nonatomic, strong)UIButton *checkBtn;
/** 完全没有 */
@property (nonatomic, strong)UIButton *nextStepBtn;
@property (nonatomic, strong)OMORiskProblemHeadView *headView;// 头视图

@end

static NSString *OMORiskProblemCellID = @"OMORiskProblemCellID";

@implementation OMORiskProblemVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatBar];
    [self.bar addTitltLabelWithText:@"康复专业评估" Font:navTitleFont];
    [self.bar addLeftButtonWithImage:[UIImage imageNamed:@"App_Back"]];
    
    _dataSouce = [NSMutableArray array];
    
    [self md_requestClientData];
    [self.view addSubview:self.headView];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.agreementBtn];
    [self.view addSubview:self.checkBtn];
    [self.view addSubview:self.areBtn];
    [self.view addSubview:self.nextStepBtn];
}
#pragma mark ------- 请求列表数据 -----------
- (void)md_requestClientData{
    
    NSMutableDictionary *parmars = [NSMutableDictionary dictionary];
    parmars[@"cate_id"] = [OMOIphoneManager sharedData].cate_id;
    parmars[@"type_id"] = [OMOIphoneManager sharedData].type_id;
    parmars[@"birthday"] = [OMOIphoneManager sharedData].birthday;
    parmars[@"gender"] = [OMOIphoneManager sharedData].gender;
    
    __weak typeof(self) weakSelf = self;
    
    [[OMONetworkManager sharedData]postWithURLString:@"40001" parameters:parmars success:^(id responseObject) {

        if(responseObject){
            
            NSDictionary *data = (NSDictionary *)responseObject;
            
            NSDictionary *dict = data[@"risk_list"];
            NSArray *allSelectArray = [[dict allKeys] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                if ([obj1 integerValue] > [obj2 integerValue]){
                    
                    return NSOrderedDescending;
                }else{
                    
                    return NSOrderedAscending;
                }
            }];
            
            for (NSString *key in allSelectArray) {
             
                OMORiskProblemModel *riskModel = [[OMORiskProblemModel alloc]init];
                riskModel.key = key;
                riskModel.title = dict[key];
                [weakSelf.dataSouce addObject:riskModel];
            }
            
            if(weakSelf.dataSouce.count > 0 ){
                
                [weakSelf.tableView reloadData];
            }
        }
    } failure:^(NSError *error) {

        [MBProgress hideAllHUD];
    }];
}
- (OMORiskProblemHeadView *)headView{
    
    if(_headView == nil){
        
        _headView = [[OMORiskProblemHeadView alloc]initWithFrame:CGRectMake(0, IphoneY, SCREENW, 80)];
    }
    return _headView;
}
#pragma mark ---------- tableView ----------
- (UITableView *)tableView{
    
    if(_tableView == nil){
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(lwb_margin * 2, IphoneY + 80, SCREENW - lwb_margin * 4, SCREENH - IphoneY - 100 - 80 - 40) style:UITableViewStylePlain];
        _tableView.backgroundColor = RGB(254, 248, 247);
        _tableView.layer.cornerRadius = lwb_margin;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[OMORiskProblemCell class] forCellReuseIdentifier:OMORiskProblemCellID];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
    }
    return _tableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _dataSouce.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OMORiskProblemCell *cell = [tableView dequeueReusableCellWithIdentifier:OMORiskProblemCellID];
    
    cell.riskModel = _dataSouce[indexPath.section];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OMORiskProblemModel *chuShaiModel = _dataSouce[indexPath.section];
    
    return chuShaiModel.height;
}
- (UIButton *)agreementBtn{
    
    if(_agreementBtn == nil){
        
        _agreementBtn = [[UIButton alloc]initWithFrame:CGRectMake(lwb_margin * 2, self.tableView.lwb_bottom + lwb_margin, 150, 25)];
        [_agreementBtn setImage:[UIImage imageNamed:@"Agreement_Normal"] forState:UIControlStateNormal];
        [_agreementBtn setImage:[UIImage imageNamed:@"Agreement_Select"] forState:UIControlStateSelected];
        [_agreementBtn setTitle:@"我已阅读并同意" forState:UIControlStateNormal];
        [_agreementBtn setTitleColor:textColour forState:UIControlStateNormal];
        _agreementBtn.titleLabel.font = bigFont;
        [_agreementBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:2.f];
        [_agreementBtn addTarget:self action:@selector(omo_agreedAgreement:) forControlEvents:UIControlEventTouchUpInside];
        _agreementBtn.selected = YES;
    }
    return _agreementBtn;
}
- (UIButton *)checkBtn{
    
    if(_checkBtn == nil){
        
        _checkBtn = [[UIButton alloc]init];
        NSString *title = @"《服务协议》";
        NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc]initWithString:title];
        [attriStr addAttribute:NSForegroundColorAttributeName value:DetailColor range:[title rangeOfString:title]];
        NSDictionary *attriBute = @{NSForegroundColorAttributeName:textColour,NSFontAttributeName:Font(18),NSUnderlineStyleAttributeName:@1,NSUnderlineColorAttributeName:textColour};
        [attriStr addAttributes:attriBute range:[title rangeOfString:title]];
        [_checkBtn setAttributedTitle:attriStr forState:UIControlStateNormal];
        _checkBtn.titleLabel.font = bigFont;
        [_checkBtn sizeToFit];
        _checkBtn.lwb_x = self.agreementBtn.lwb_right;
        _checkBtn.lwb_centerY = self.agreementBtn.lwb_centerY;
        _checkBtn.selected = YES;
        [_checkBtn addTarget:self action:@selector(omo_checkAgreement) forControlEvents:UIControlEventTouchUpInside];
    }
    return _checkBtn;
}
#pragma mark ----------- 有 ----------
- (UIButton *)areBtn{
    
    if(_areBtn == nil){
        
        _areBtn = [[UIButton alloc]init];
        _areBtn.lwb_size = CGSizeMake(120, 40);
        _areBtn.lwb_centerX = self.view.lwb_centerX * 0.5;
        _areBtn.lwb_bottom = SCREENH - 30;
        [_areBtn setTitle:@"有" forState:UIControlStateNormal];
        _areBtn.backgroundColor = backColor;
        [_areBtn setTitleColor:WHITECOLORA(1) forState:UIControlStateNormal];
        _areBtn.layer.masksToBounds = YES;
        _areBtn.layer.cornerRadius = 20.f;
        _areBtn.titleLabel.font = bigFont;
        _areBtn.tag = 100;
        [_areBtn addTarget:self action:@selector(omo_nextStepButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _areBtn;
}
#pragma mark ----------- 完全没有 ----------
- (UIButton *)nextStepBtn{
    
    if(_nextStepBtn == nil){
        
        _nextStepBtn = [[UIButton alloc]init];
        _nextStepBtn.lwb_size = CGSizeMake(120, 40);
        _nextStepBtn.lwb_centerX = SCREENW * 0.75;
        _nextStepBtn.lwb_bottom = SCREENH - 30;
        [_nextStepBtn setTitle:@"全部没有" forState:UIControlStateNormal];
        _nextStepBtn.backgroundColor = backColor;
        [_nextStepBtn setTitleColor:WHITECOLORA(1) forState:UIControlStateNormal];
        _nextStepBtn.layer.masksToBounds = YES;
        _nextStepBtn.layer.cornerRadius = 20.f;
        _nextStepBtn.titleLabel.font = bigFont;
        _nextStepBtn.tag = 200;
        [_nextStepBtn addTarget:self action:@selector(omo_nextStepButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextStepBtn;
}
#pragma mark ------- 同意服务协议 ------------
- (void)omo_agreedAgreement:(UIButton *)sender{
    
    BOOL isSelect = sender.selected;
    sender.selected = !isSelect;
}
- (void)omo_nextStepButtonClick:(UIButton *)sender{
    
    if(!_agreementBtn.selected){
        
        [MBProgress showInfoMessage:@"您需要先阅读并同意元新免责声明"];
        return;
    }
    if(sender.tag == 100){
        
        OMOMakeAssessVC *makeAssessVC = [[OMOMakeAssessVC alloc]init];
        [self.navigationController pushViewController:makeAssessVC animated:YES];
        return;
    }
    NSMutableDictionary *parmars = [NSMutableDictionary dictionary];
    parmars[@"cate_id"] = [OMOIphoneManager sharedData].cate_id;
    parmars[@"type_id"] = [OMOIphoneManager sharedData].type_id;
    
    [[OMONetworkManager sharedData]postWithURLString:@"40002" parameters:parmars success:^(id responseObject) {
        
        if(responseObject){
            
            NSDictionary *dict = (NSDictionary *)responseObject;
    
            [OMOIphoneManager sharedData].acography_id = [NSString stringWithFormat:@"%@",dict[@"acography_id"]];

            OMOAssessmentQuestionnaireVC *assessmentQuestionnaireVC = [[OMOAssessmentQuestionnaireVC alloc]init];
            [self.navigationController pushViewController:assessmentQuestionnaireVC animated:YES];
        }
    } failure:^(NSError *error) {
        
        [MBProgress hideAllHUD];
    }];
}
#pragma mark --------- 查看服务协议 -----------
- (void)omo_checkAgreement{
    
    OMOPublicAgreementVC *agreementVC = [[OMOPublicAgreementVC alloc]init];
    agreementVC.agreementType = 3;
    [self.navigationController pushViewController:agreementVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
