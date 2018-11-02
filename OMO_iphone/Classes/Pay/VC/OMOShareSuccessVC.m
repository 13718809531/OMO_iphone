//
//  OMOShareSuccessVC.m
//  OMO_iphone
//
//  Created by wy on 2018/10/17.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOShareSuccessVC.h"
/**  */
#import "OMOPayShareSuccessTopView.h"
/**  */
#import "OMOPayShareSuccessDeviceView.h"
/**  */
#import "OMOTrainingListVC.h"

@interface OMOShareSuccessVC ()

/**  */
@property (nonatomic, strong)OMOPayShareSuccessTopView *topView;
/**  */
@property (nonatomic, strong)OMOPayShareSuccessDeviceView *deviceView;
/** 开始训练 */
@property (nonatomic, strong)UIButton *startBtn;

@end

@implementation OMOShareSuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatBar];
    [self.bar addLeftButtonWithImage:[UIImage imageNamed:@"App_Back"]];
    [self.bar addTitltLabelWithText:@"分享成功" Font:navTitleFont];
    
    self.view.backgroundColor = WHITECOLORA(1);
    
    [self.view addSubview:self.topView];
    [self.view addSubview:self.deviceView];
    [self.view addSubview:self.startBtn];
}

- (OMOPayShareSuccessTopView *)topView{
    
    if(_topView == nil){
        
        _topView = [[OMOPayShareSuccessTopView alloc]initWithFrame:CGRectMake(0, IphoneY, SCREENW, (SCREENH - IphoneY - 80) * 0.5)];
        _topView.payType = 2;
    }
    return _topView;
}
- (OMOPayShareSuccessDeviceView *)deviceView{
    
    if(_deviceView == nil){
        
        _deviceView = [[OMOPayShareSuccessDeviceView alloc]initWithFrame:CGRectMake(0, self.topView.lwb_bottom, SCREENW, (SCREENH - IphoneY - 80) * 0.5)];
        _deviceView.kangFuBaoModel = _kangFuBaoModel;
    }
    return _deviceView;
}
- (UIButton *)startBtn{
    
    if(_startBtn == nil){
        
        _startBtn = [[UIButton alloc]initWithFrame:CGRectMake(IFFitFloat6(lwb_pblicX), SCREENH - 80, SCREENW - IFFitFloat6(lwb_pblicX) * 2, 40)];
        _startBtn.backgroundColor = backColor;
        _startBtn.titleLabel.font = navTitleFont;
        [_startBtn setTitle:@"开始训练" forState:UIControlStateNormal];
        [_startBtn setTitleColor:WHITECOLORA(1) forState:UIControlStateNormal];
        _startBtn.layer.cornerRadius = 20.f;
        [_startBtn addTarget:self action:@selector(omo_startStaining:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startBtn;
}
#pragma mark ------- 开始训练 --------
- (void)omo_startStaining:(UIButton *)sender{
    
    OMOTrainingListVC *trainingListVC = [[OMOTrainingListVC alloc]init];
    [self.navigationController pushViewController:trainingListVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
