//
//  OMOSelectPartsVC.m
//  OMO_iphone
//
//  Created by wy on 2018/9/12.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOSelectPartsVC.h"
#import "OMOSelectPartsView.h"
#import "OMORiskProblemVC.h"

@interface OMOSelectPartsVC ()

@property (nonatomic, strong)OMOSelectPartsView *partsView;
@property (nonatomic, strong)UIImageView *leftImg;
@property (nonatomic, strong)UIButton *nextStepBtn;

@end

@implementation OMOSelectPartsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [OMOIphoneManager sharedData].cate_id = @"";
    [OMOIphoneManager sharedData].cate_name = @"";
    [OMOIphoneManager sharedData].type_id = @"1";
    
    [self creatBar];
    [self.bar addTitltLabelWithText:@"选择评估部位" Font:navTitleFont];
    [self.bar addLeftButtonWithImage:[UIImage imageNamed:@"App_Back"]];
    
    [self.view addSubview:self.leftImg];
    [self.view addSubview:self.partsView];
    [self.view addSubview:self.nextStepBtn];
}
- (UIImageView *)leftImg{
    
    if(_leftImg == nil){
        
        _leftImg = [[UIImageView alloc]init];
        _leftImg.image = [UIImage imageNamed: @"Select_all"];
        [_leftImg sizeToFit];
        _leftImg.lwb_centerY = self.view.lwb_centerY;
        _leftImg.lwb_centerX = (SCREENW - IFFitFloat6(73.f * 2)) * 0.5;
    }
    return _leftImg;
}
- (OMOSelectPartsView *)partsView{
    
    if(_partsView == nil){

        _partsView = [[OMOSelectPartsView alloc]initWithFrame:CGRectMake(SCREENW - IFFitFloat6(140), IphoneY + lwb_margin, IFFitFloat6(140), SCREENH - IphoneY * 2)];
        
        __weak typeof(self) weakSelf = self;
        
        _partsView.seletPaetsblock = ^(NSString *selectName) {
            
            weakSelf.leftImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"Select_%@",selectName]];
        };
    }
    return _partsView;
}
#pragma mark ----------- 下一步跳转 ----------
- (UIButton *)nextStepBtn{
    
    if(_nextStepBtn == nil){
        
        _nextStepBtn = [[UIButton alloc]init];
        _nextStepBtn.lwb_size = CGSizeMake(120, 40);
        _nextStepBtn.lwb_centerX = self.view.lwb_centerX;
        _nextStepBtn.lwb_bottom = SCREENH - 30;
        
        if(_pushType == 1){
            
            [_nextStepBtn setTitle:@"确定" forState:UIControlStateNormal];
        }else{
            
            [_nextStepBtn setTitle:@"下一步" forState:UIControlStateNormal];
        }
        _nextStepBtn.backgroundColor = backColor;
        [_nextStepBtn setTitleColor:WHITECOLORA(1) forState:UIControlStateNormal];
        _nextStepBtn.layer.masksToBounds = YES;
        _nextStepBtn.layer.cornerRadius = 20.f;
        _nextStepBtn.titleLabel.font = bigFont;
        [_nextStepBtn addTarget:self action:@selector(md_nextStepButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextStepBtn;
}
- (void)md_nextStepButtonClick{
    
    if([OMOIphoneManager sharedData].cate_id.length <= 0){
        
        [MBProgress showErrorMessage:@"请先选择评估部位"];
        return;
    }
    
    [OMOIphoneManager sharedData].cate_id = @"1";
    
    if(_pushType == 1){
        
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    OMORiskProblemVC *riskProblemVC = [[OMORiskProblemVC alloc]init];
    riskProblemVC.cate_id = [OMOIphoneManager sharedData].cate_id;
    [self.navigationController pushViewController:riskProblemVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
