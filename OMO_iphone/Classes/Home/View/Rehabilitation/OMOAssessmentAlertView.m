//
//  OMONoLoginAlertView.m
//  OMO_iphone
//
//  Created by wy on 2018/10/10.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOAssessmentAlertView.h"
#import "OMOLoginMobileVC.h"

@interface OMOAssessmentAlertView()

/** 弹窗视图 */
@property (nonatomic, strong)UIView *alertView;

@end

@implementation OMOAssessmentAlertView

- (instancetype)init{
    
    if(self = [super init]){
        
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.alertView];
    }
    return self;
}
- (UIView *)alertView{
    
    if(_alertView == nil){
        
        _alertView = [[UIView alloc]init];
        _alertView.lwb_width = SCREENW - IFFitFloat6(lwb_margin) * 4;
        _alertView.lwb_height = SCREENH / 3;
        _alertView.center = self.center;
        _alertView.backgroundColor = WHITECOLORA(1);
        _alertView.layer.masksToBounds = YES;
        _alertView.layer.cornerRadius = lwb_margin;
        
        UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _alertView.lwb_width, 40)];
        titleLab.backgroundColor = [UIColor clearColor];
        titleLab.text = @"温馨提示";
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.textColor = textColour;
        titleLab.font = BoldFont(22);
        [_alertView addSubview:titleLab];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, titleLab.lwb_bottom, _alertView.lwb_width, 2)];
        lineView.backgroundColor = mainBackColor;
        [_alertView addSubview:lineView];
        
        CGFloat height = _alertView.lwb_height - 102;
        CGFloat width = _alertView.lwb_width - lwb_margin * 2;
        UILabel *titleLab1 = [[UILabel alloc]initWithFrame:CGRectMake(lwb_margin, lineView.lwb_bottom, width, height)];
        titleLab1.backgroundColor = [UIColor clearColor];
        NSString *str1 = @"111111111111111";
        NSString *str2 = @"222222222222222";
        NSString *text = [NSString stringWithFormat:@"%@\n%@",str1,str2];
        titleLab1.text = text;
        [titleLab1 setLabelSpaceOfLineSpacing:6.f Kern:1.f];
        titleLab1.textAlignment = NSTextAlignmentCenter;
        titleLab1.textColor = textColour;
        titleLab1.font = navTitleFont;
        titleLab1.numberOfLines = 2;
        [_alertView addSubview:titleLab1];
        
        UIButton *loginBtn = [[UIButton alloc]init];
        [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [loginBtn setTitleColor:WHITECOLORA(1) forState:UIControlStateNormal];
        loginBtn.titleLabel.font = navTitleFont;
        loginBtn.backgroundColor = backColor;
        loginBtn.layer.masksToBounds = YES;
        loginBtn.layer.cornerRadius = 20.f;
        loginBtn.lwb_y = _alertView.lwb_height - 60;
        loginBtn.lwb_width = _alertView.lwb_width - IFFitFloat6(80) * 2;
        loginBtn.lwb_height = 40.f;
        loginBtn.lwb_x = IFFitFloat6(80);
        [loginBtn addTarget:self action:@selector(omo_login) forControlEvents:UIControlEventTouchUpInside];
        [_alertView addSubview:loginBtn];
    }
    return _alertView;
}
- (void)omo_login{
    
    OMOLoginMobileVC *loginMobileVC = [[OMOLoginMobileVC alloc]init];
    [[OMOIphoneManager getCurrentVC].navigationController pushViewController:loginMobileVC animated:YES];
}
@end
