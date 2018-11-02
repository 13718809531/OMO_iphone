//
//  OMOBookingSuccessVC.m
//  OMO_iphone
//
//  Created by wy on 2018/10/24.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOBookingSuccessVC.h"

@interface OMOBookingSuccessVC ()

/** 不需要 */
@property (nonatomic, strong)UIButton *startBtn;

@end

@implementation OMOBookingSuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (UIButton *)startBtn{
    
    if(_startBtn == nil){
        
        _startBtn = [[UIButton alloc]initWithFrame:CGRectMake(IFFitFloat6(lwb_pblicX), SCREENH - 80, SCREENW - IFFitFloat6(lwb_pblicX) * 2, 40)];
        _startBtn.backgroundColor = backColor;
        _startBtn.titleLabel.font = navTitleFont;
        [_startBtn setTitle:@"返回首页" forState:UIControlStateNormal];
        [_startBtn setTitleColor:WHITECOLORA(1) forState:UIControlStateNormal];
        _startBtn.layer.cornerRadius = 20.f;
        [_startBtn addTarget:self action:@selector(omo_startStaining:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startBtn;
}
#pragma mark ------- 返回首页 --------
- (void)omo_startStaining:(UIButton *)sender{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
