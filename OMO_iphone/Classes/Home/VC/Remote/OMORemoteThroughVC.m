//
//  OMORemoteThroughVC.m
//  OMO_iphone
//
//  Created by wy on 2018/10/9.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMORemoteThroughVC.h"

@interface OMORemoteThroughVC ()

/** 远程医师 */
@property (nonatomic, strong)UILabel *nameLab;
/**  */
@property (nonatomic, strong)UILabel *invitationLab;
/** 挂断 */
@property (nonatomic, strong)UIButton *hangUpBtn;
/** 接通 */
@property (nonatomic, strong)UIButton *receiveBtn;

@end

@implementation OMORemoteThroughVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = WHITECOLORA(0);
    
    [self.view addSubview:self.nameLab];
    [self.view addSubview:self.invitationLab];
    [self.view addSubview:self.hangUpBtn];
    [self.view addSubview:self.receiveBtn];
}
- (UILabel *)nameLab{
    
    if(_nameLab == nil){
        
        _nameLab = [[UILabel alloc]init];
        _nameLab.text = @"1111111";
        _nameLab.textAlignment = NSTextAlignmentCenter;
        _nameLab.textColor = textColour;
        _nameLab.font = Font(18);
        _nameLab.lwb_width = SCREENW - lwb_pblicX * 2;
        _nameLab.lwb_height = 20;
        _nameLab.lwb_x = lwb_pblicX;
        _nameLab.lwb_bottom = SCREENH * 0.5 - lwb_smallMargin;
    }
    return _nameLab;
}
- (UILabel *)invitationLab{
    
    if(_invitationLab == nil){
        
        _invitationLab = [[UILabel alloc]init];
        _invitationLab.text = @"邀请您进行视频评估";
        _invitationLab.textAlignment = NSTextAlignmentCenter;
        _invitationLab.textColor = textColour;
        _invitationLab.font = bigFont;
        _invitationLab.lwb_width = SCREENW - lwb_pblicX * 2;
        _invitationLab.lwb_height = 20;
        _invitationLab.lwb_x = lwb_pblicX;
        _invitationLab.lwb_y = SCREENH * 0.5 + lwb_smallMargin;
    }
    return _invitationLab;
}

- (UIButton *)hangUpBtn{
    
    if(_hangUpBtn == nil){
        
        _hangUpBtn = [[UIButton alloc]init];
        [_hangUpBtn setImage:[UIImage imageNamed:@"App_Back"] forState:UIControlStateNormal];
        _hangUpBtn.size = CGSizeMake(30, 30);
        _hangUpBtn.lwb_right = SCREENW * 0.5 - lwb_margin;
        _hangUpBtn.lwb_bottom = SCREENH - Between - 40;
        [_hangUpBtn addTarget:self action:@selector(omo_back) forControlEvents:UIControlEventTouchUpInside];
    }
    return _hangUpBtn;
}
- (UIButton *)receiveBtn{
    
    if(_receiveBtn == nil){
        
        _receiveBtn = [[UIButton alloc]init];
        _receiveBtn = [[UIButton alloc]init];
        [_receiveBtn setImage:[UIImage imageNamed:@"App_Back"] forState:UIControlStateNormal];
        _receiveBtn.size = CGSizeMake(30, 30);
        _receiveBtn.lwb_x = SCREENW * 0.5 + lwb_margin;
        _receiveBtn.lwb_bottom = SCREENH - Between - 40;
        [_receiveBtn addTarget:self action:@selector(omo_back) forControlEvents:UIControlEventTouchUpInside];
    }
    return _receiveBtn;
}
- (void)omo_back{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
