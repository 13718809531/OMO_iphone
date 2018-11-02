//
//  OMORemoteVC.m
//  OMO_iphone
//
//  Created by wy on 2018/9/28.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOResultRemoteVC.h"
//** 接通远程 */
#import "OMORemoteThroughVC.h"
/** 远程预约 */
#import "OMORemoteBookingVC.h"

@interface OMOResultRemoteVC ()

/** 背景图 */
@property (nonatomic, strong)UIImageView *backImgV;
/** 返回 */
@property (nonatomic, strong)UIButton *backBtn;
/** 评估结果 */
@property (nonatomic, strong)UILabel *titleLab;
/** 经过评估 */
@property (nonatomic, strong)UILabel *titleLab1;
/** 您目前 */
@property (nonatomic, strong)UILabel *titleLab2;
/** 需由 */
@property (nonatomic, strong)UILabel *titleLab3;
/** 咨询医师 */
@property (nonatomic, strong)UIButton *consultingBtn;

@end

@implementation OMOResultRemoteVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.backImgV];
    [self.view addSubview:self.titleLab];
    [self.view addSubview:self.backBtn];
    [self.view addSubview:self.consultingBtn];
    [self.view addSubview:self.titleLab3];
    [self.view addSubview:self.titleLab2];
    [self.view addSubview:self.titleLab1];
}
- (UIImageView *)backImgV{
    
    if(_backImgV == nil){
        
        _backImgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREENW, SCREENH)];
    }
    return _backImgV;
}
- (UILabel *)titleLab{
    
    if(_titleLab == nil){
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.text = @"评估结果";
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.textColor = textColour;
        _titleLab.font = Font(18);
        [_titleLab sizeToFit];
        _titleLab.lwb_centerX = self.view.lwb_centerX;
        _titleLab.lwb_y = Between + 32;
    }
    return _titleLab;
}
- (UILabel *)titleLab1{
    
    if(_titleLab1 == nil){
        
        _titleLab1 = [[UILabel alloc]init];
        _titleLab1.text = @"经过评估";
        _titleLab1.textAlignment = NSTextAlignmentLeft;
        _titleLab1.textColor = textColour;
        _titleLab1.font = Font(18);
        _titleLab1.lwb_width = SCREENW - lwb_pblicX - lwb_margin;
        _titleLab1.lwb_height = 20;
        _titleLab1.lwb_x = lwb_pblicX;
        _titleLab1.lwb_bottom = self.titleLab2.lwb_y - lwb_margin;
    }
    return _titleLab1;
}
- (UILabel *)titleLab2{
    
    if(_titleLab2 == nil){
        
        _titleLab2 = [[UILabel alloc]init];
        _titleLab2.text = @"您目前身体状况,不适合自己进行训练";
        _titleLab2.textAlignment = NSTextAlignmentLeft;
        _titleLab2.textColor = textColour;
        _titleLab2.font = bigFont;
        _titleLab2.lwb_width = SCREENW - lwb_pblicX - lwb_margin;
        _titleLab2.lwb_height = 20;
        _titleLab2.lwb_x = lwb_pblicX;
        _titleLab2.lwb_bottom = self.titleLab3.lwb_y - lwb_margin;
    }
    return _titleLab2;
}
- (UILabel *)titleLab3{
    
    if(_titleLab3 == nil){
        
        _titleLab3 = [[UILabel alloc]init];
        _titleLab3.text = @"需由元新康复远程医师端进行在线视频康复评估判断!";
        _titleLab3.textAlignment = NSTextAlignmentLeft;
        _titleLab3.textColor = textColour;
        _titleLab3.font = bigFont;
        _titleLab3.numberOfLines = 0;
        [_titleLab3 sizeToFit];
        _titleLab3.lwb_x = lwb_pblicX;
        _titleLab3.lwb_width = SCREENW - lwb_pblicX - lwb_margin;
        _titleLab3.lwb_height = 40;
        _titleLab3.lwb_bottom = self.consultingBtn.lwb_y - IFFitFloat6(100);
    }
    return _titleLab3;
}
- (UIButton *)backBtn{
    
    if(_backBtn == nil){
        
        _backBtn = [[UIButton alloc]init];
        [_backBtn setImage:[UIImage imageNamed:@"App_Back"] forState:UIControlStateNormal];
        _backBtn.size = CGSizeMake(30, 30);
        _backBtn.lwb_x = 13;
        _backBtn.lwb_centerY = self.titleLab.lwb_centerY;
        [_backBtn addTarget:self action:@selector(omo_back) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}
- (UIButton *)consultingBtn{
    
    if(_consultingBtn == nil){
        
        _consultingBtn = [[UIButton alloc]init];
        [_consultingBtn setImage:[UIImage imageNamed:@"Booking_Remote"] forState:UIControlStateNormal];
        [_consultingBtn setTitle:@"咨询医生" forState:UIControlStateNormal];
        [_consultingBtn setTitleColor:WHITECOLORA(1) forState:UIControlStateNormal];
        _consultingBtn.titleLabel.font = bigFont;
        _consultingBtn.lwb_x = IFFitFloat6(lwb_pblicX);
        _consultingBtn.lwb_width = SCREENW - IFFitFloat6(lwb_pblicX) * 2;
        _consultingBtn.lwb_height = 40.f;
        _consultingBtn.lwb_bottom = SCREENH - IFFitFloat6(40);
        _consultingBtn.backgroundColor = backColor;
        _consultingBtn.layer.masksToBounds = YES;
        _consultingBtn.layer.cornerRadius = 20.f;
        _consultingBtn.backgroundColor = backColor;
        [_consultingBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:5.f];
        [_consultingBtn addTarget:self action:@selector(omo_consultingBtnDidclick) forControlEvents:UIControlEventTouchUpInside];
        _consultingBtn.selected = YES;
    }
    return _consultingBtn;
}
- (void)omo_back{
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark ------- 咨询医生 ----------
- (void)omo_consultingBtnDidclick{
    
//    OMORemoteThroughVC *remoteThroughVC = [[OMORemoteThroughVC alloc]init];
//    [self.navigationController pushViewController:remoteThroughVC animated:YES];
    
    OMORemoteBookingVC *remoteBookingVC = [[OMORemoteBookingVC alloc]init];
    [self.navigationController pushViewController:remoteBookingVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
