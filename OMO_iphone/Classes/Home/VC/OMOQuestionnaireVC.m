//
//  OMOQuestionnaireVC.m
//  OMO_iphone
//
//  Created by wy on 2018/9/29.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOQuestionnaireVC.h"
#import "OMOPingGuTiChooseView.h"// 选择题视图
#import "OMOPingGuTiVASView.h"// vas进度条题
/** 康复训练计划 */
#import "OMORehabilitationProgrammeVC.h"
/** 转诊 */
#import "OMOReferralStrongListVC.h"
/** 预约门诊 */
#import "OMOResultStoreVC.h"
/** 远程 */
#import "OMOResultRemoteVC.h"
/** 康复训练计划model */
#import "OMOKangFuBaoModel.h"

@interface OMOQuestionnaireVC ()<OMOPingGuTiSelectDelegate,OMOPingGuTiVasDelegate>

@property (nonatomic, strong)NSMutableArray *selectPingGuTiData;// 选中的题
@property (nonatomic, strong)UIButton *previousStepBtn;// 上一步
@property (nonatomic, strong)UIButton *nextStepBtn;// 下一步

@end

@implementation OMOQuestionnaireVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatBar];
    [self.bar addTitltLabelWithText:@"评估答题" Font:navTitleFont];
    [self.bar addLeftButtonWithImage:[UIImage imageNamed:@"App_Back"]];
    
    _selectPingGuTiData = [NSMutableArray array];
    [self omo_setUI];
}
- (void)backClick{
    
    NSDictionary *dict = [DATIIDS lastObject];
    
    if([dict[@"question_id"] isEqualToString:_pingGuTiModel.pingGuTi_id]){
        
        [DATIIDS removeLastObject];
    }
    [super backClick];
}
- (void)omo_setUI{
    
    if([_pingGuTiModel.type isEqualToString:@"2"]){
        
        OMOPingGuTiVASView *progressView = [[OMOPingGuTiVASView alloc]initWithFrame:CGRectMake(0, IphoneY, SCREENW, SCREENH - IphoneY - 80)];
        progressView.delegate = self;
        NSDictionary *dic = @{@"value":@"0",@"name":@"无痛"};
        [self.selectPingGuTiData addObject:dic];
        
        [self.view addSubview:progressView];
    }else{
        
        OMOPingGuTiChooseView *chooseView = [[OMOPingGuTiChooseView alloc]initWithFrame:CGRectMake(0, IphoneY, SCREENW, SCREENH - IphoneY - 80)];
        chooseView.delegate = self;
        chooseView.pingGuTiModel = self.pingGuTiModel;
        [self.view addSubview:chooseView];
    }
    [self.view addSubview:self.previousStepBtn];
    [self.view addSubview:self.nextStepBtn];
}
- (UIButton *)previousStepBtn{
    
    if(_previousStepBtn == nil){
        
        _previousStepBtn = [[UIButton alloc]init];
        _previousStepBtn.tag = 100;
        _previousStepBtn.lwb_size = CGSizeMake(IFFitFloat6(120), 40);
        _previousStepBtn.lwb_right = SCREENW * 0.5 - IFFitFloat6(30);
        _previousStepBtn.lwb_bottom = SCREENH - 30;
        [_previousStepBtn setTitle:@"上一步" forState:UIControlStateNormal];
        _previousStepBtn.backgroundColor = backColor;
        [_previousStepBtn setTitleColor:WHITECOLORA(1) forState:UIControlStateNormal];
        _previousStepBtn.layer.masksToBounds = YES;
        _previousStepBtn.layer.cornerRadius = 20.f;
        _previousStepBtn.titleLabel.font = bigFont;
        [_previousStepBtn addTarget:self action:@selector(md_switchQuestionOffButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _previousStepBtn;
}
- (UIButton *)nextStepBtn{
    
    if(_nextStepBtn == nil){
        
        _nextStepBtn = [[UIButton alloc]init];
        _nextStepBtn.tag = 200;
        _nextStepBtn.lwb_size = CGSizeMake(IFFitFloat6(120), 40);
        _nextStepBtn.lwb_x = SCREENW * 0.5 + IFFitFloat6(30);
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
#pragma mark -------- 选择题 ---------
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
#pragma mark ------- 上一步,下一步 ---------
- (void)md_switchQuestionOffButton:(UIButton *)sender{
    
    if(sender.tag == 100){
        
        [self backClick];
    }else if(sender.tag == 200){
        
        if(_selectPingGuTiData.count > 0){
            
            [self md_requestNextDaTiData];
        }
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
