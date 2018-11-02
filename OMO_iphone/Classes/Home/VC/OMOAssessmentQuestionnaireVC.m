//
//  OMOAssessmentQuestionnaireVC.m
//  OMO_iphone
//
//  Created by wy on 2018/9/28.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOAssessmentQuestionnaireVC.h"
#import "OMOPingGuTiChooseView.h"// 选择题视图
#import "OMOPingGuTiVASView.h"// vas进度条题
#import "OMOPingGuTiModel.h"
/** 问卷 */
#import "OMOQuestionnaireVC.h"
/** 康复训练计划 */
#import "OMORehabilitationProgrammeVC.h"
/** 转诊 */
#import "OMOReferralStrongListVC.h"
/** 预约门诊 */
#import "OMOResultStoreVC.h"
/** 远程 */
#import "OMOResultRemoteVC.h"

@interface OMOAssessmentQuestionnaireVC ()<OMOPingGuTiSelectDelegate,OMOPingGuTiVasDelegate>

@property (nonatomic, strong)OMOPingGuTiModel *pingGuTiModel;// 数据
@property (nonatomic, strong)UIButton *nextStepBtn;// 下一步
@property (nonatomic, strong)NSMutableArray *selectPingGuTiData;// 选中的题数据

@end

@implementation OMOAssessmentQuestionnaireVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatBar];
    [self.bar addTitltLabelWithText:@"评估答题" Font:navTitleFont];
    [self.bar addLeftButtonWithImage:[UIImage imageNamed:@"App_Back"]];
    
    DATIIDS = [NSMutableArray array];
    
    _selectPingGuTiData = [NSMutableArray array];
    
    [self omo_requestDataSouce];
    
    [self.view addSubview:self.nextStepBtn];
}
- (void)backClick{
    
    if(DATIIDS.count > 0){
        
        [DATIIDS removeAllObjects];
    }
    [super backClick];
}
- (void)omo_requestDataSouce{
    
    NSMutableDictionary *parmars = [NSMutableDictionary dictionary];
    parmars[@"cate_id"] = [OMOIphoneManager sharedData].cate_id;
    parmars[@"type_id"] = [OMOIphoneManager sharedData].type_id;
    parmars[@"acography_id"] = [OMOIphoneManager sharedData].acography_id;
    parmars[@"question_id"] = @"0";
    parmars[@"question_list"] = @"";
    __weak typeof(self) weakSelf = self;
    
    [[OMONetworkManager sharedData]postWithURLString:@"50000" parameters:parmars success:^(id responseObject) {
        
        if(responseObject){
            
            NSDictionary *dict = (NSDictionary *)responseObject;
            
            weakSelf.pingGuTiModel = [OMOPingGuTiModel mj_objectWithKeyValues:dict];
            
            if(![weakSelf.pingGuTiModel.type isEqualToString:@"2"]){

                OMOPingGuTiChooseView *chooseView = [[OMOPingGuTiChooseView alloc]initWithFrame:CGRectMake(0, IphoneY, SCREENW, SCREENH - IphoneY - 80)];
                chooseView.delegate = self;
                chooseView.pingGuTiModel = weakSelf.pingGuTiModel;
                [self.view addSubview:chooseView];
            }else if([weakSelf.pingGuTiModel.type isEqualToString:@"2"]){

                OMOPingGuTiVASView *progressView = [[OMOPingGuTiVASView alloc]initWithFrame:CGRectMake(0, IphoneY, SCREENW, SCREENH - IphoneY - 80)];
                progressView.delegate = self;
                NSDictionary *dic = @{@"value":@"0",@"name":@"无痛"};
                [weakSelf.selectPingGuTiData addObject:dic];

                [weakSelf.view addSubview:progressView];
            }
        }
    } failure:^(NSError *error) {
        
        [MBProgress hideAllHUD];
    }];
}
- (UIButton *)nextStepBtn{
    
    if(_nextStepBtn == nil){
        
        _nextStepBtn = [[UIButton alloc]init];
        _nextStepBtn.lwb_size = CGSizeMake(120, 40);
        _nextStepBtn.lwb_centerX = self.view.lwb_centerX;
        _nextStepBtn.lwb_bottom = SCREENH - 30;
        [_nextStepBtn setTitle:@"下一步" forState:UIControlStateNormal];
        _nextStepBtn.backgroundColor = backColor;
        [_nextStepBtn setTitleColor:WHITECOLORA(1) forState:UIControlStateNormal];
        _nextStepBtn.layer.masksToBounds = YES;
        _nextStepBtn.layer.cornerRadius = 20.f;
        _nextStepBtn.titleLabel.font = bigFont;
        [_nextStepBtn addTarget:self action:@selector(md_switchQuestionOffButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextStepBtn;
}
#pragma mark -------- 选中题 ---------
- (void)omo_pingGuTiSelectFromArray:(NSArray *)array{
    
    _selectPingGuTiData = [NSMutableArray arrayWithArray:array];
}
#pragma mark -------- 选中的vas --------------
- (void)omo_pingGuTiVasFromSlider_Value:(NSString *)slider_Value TitleText:(NSString *)tetx{
    
    BOOL isContains = NO;
    
    for (NSDictionary *dict in _selectPingGuTiData) {
        
        if([dict[@"value"] isEqualToString:slider_Value]){
            
            isContains = YES;
        }
    }
    if(isContains)return;

    NSDictionary *dict = @{@"value":slider_Value,@"name":tetx};
        
    [_selectPingGuTiData replaceObjectAtIndex:0 withObject:dict];
}
#pragma mark ------- 下一步 ---------
- (void)md_switchQuestionOffButton:(UIButton *)sender{
    
    if(_selectPingGuTiData.count > 0){
        
        [self md_requestNextDaTiData];
    }
}
#pragma mark ------- 点击按钮下一步请求数据 -----------
- (void)md_requestNextDaTiData{
    
    BOOL isContains = NO;
    
    for (NSDictionary *dict in DATIIDS) {
        
        if([dict[@"question_id"] isEqualToString:_pingGuTiModel.pingGuTi_id]){
            
            isContains = YES;
        }
    }
    
    if(isContains == NO){
        
        NSDictionary *dict = @{@"question_id":_pingGuTiModel.pingGuTi_id,@"type":_pingGuTiModel.type,@"question_name":_pingGuTiModel.question_name,@"score":_pingGuTiModel.score,@"selected_values":_selectPingGuTiData,@"advise":checkNull(_pingGuTiModel.advise)};
        [DATIIDS addObject:dict];
    }
    
    NSMutableDictionary *parmars = [NSMutableDictionary dictionary];
    parmars[@"cate_id"] = [OMOIphoneManager sharedData].cate_id;
    parmars[@"type_id"] = [OMOIphoneManager sharedData].type_id;
    parmars[@"acography_id"] = [OMOIphoneManager sharedData].acography_id;
    parmars[@"question_id"] = _pingGuTiModel.pingGuTi_id;
    parmars[@"score"] = _pingGuTiModel.score;
    parmars[@"question_name"] = _pingGuTiModel.question_name;
    parmars[@"question_list"] = DATIIDS;
    
    __weak typeof(self) weakSelf = self;
    
    [[OMONetworkManager sharedData]postWithURLString:@"50000" parameters:parmars success:^(id responseObject) {
        
        if(responseObject){
            
            NSDictionary *dict = (NSDictionary *)responseObject;
            
            OMOPingGuTiModel *pingGuTiModel = [OMOPingGuTiModel mj_objectWithKeyValues:dict];
        
            if([pingGuTiModel.result_type isEqualToString:@"1"]){// 评估题
    
                OMOQuestionnaireVC *questionnaireVC = [[OMOQuestionnaireVC alloc]init];
                questionnaireVC.pingGuTiModel = pingGuTiModel;
                [weakSelf.navigationController pushViewController:questionnaireVC animated:YES];
            }else if ([pingGuTiModel.result_type isEqualToString:@"2"]){// 康复包
    
                OMORehabilitationProgrammeVC *rehabilitationProgrammeVC = [[OMORehabilitationProgrammeVC alloc]init];
                rehabilitationProgrammeVC.numType = 1;
                rehabilitationProgrammeVC.kangFuBaoModel = [OMOKangFuBaoModel mj_objectWithKeyValues:dict[@"value"]];
                [weakSelf.navigationController pushViewController:rehabilitationProgrammeVC animated:YES];
            }else if ([pingGuTiModel.result_type isEqualToString:@"3"]){// 转诊
    
                OMOReferralStrongListVC *zhuanZhenVC = [[OMOReferralStrongListVC alloc]init];
                [weakSelf.navigationController pushViewController:zhuanZhenVC animated:YES];
            }else if ([pingGuTiModel.result_type isEqualToString:@"4"]){// 远程
    
                OMOResultRemoteVC *remoteVC = [[OMOResultRemoteVC alloc]init];
                [weakSelf.navigationController pushViewController:remoteVC animated:YES];
            }else if ([pingGuTiModel.result_type isEqualToString:@"5"]){// 弹出提示
    
                OMOResultStoreVC *bookingVC = [[OMOResultStoreVC alloc]init];
                [weakSelf.navigationController pushViewController:bookingVC animated:YES];
            }
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
