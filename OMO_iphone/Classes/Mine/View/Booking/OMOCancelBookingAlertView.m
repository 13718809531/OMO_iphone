//
//  OMOCancelBookingAlertView.m
//  OMO_iphone
//
//  Created by wy on 2018/10/25.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOCancelBookingAlertView.h"

#import "WTShareManager.h"
#import "OMOCustomButtom.h"
#import <Photos/Photos.h>

@interface OMOCancelBookingAlertView()

@property (nonatomic,strong)UIButton * backButton;
/** 弹窗视图 */
@property (nonatomic, strong)UIView *alertView;

@property (nonatomic,strong)UIButton * cancelButton;

@end

@implementation OMOCancelBookingAlertView

- (instancetype)init
{
    if (self = [super init]) {
        
        self.frame = CGRectMake(0, 0, SCREENW, SCREENH);
        [self addSubview:self.backButton];
        [self addSubview:self.alertView];
    }
    return self;
}
- (UIButton *)backButton{
    
    if(_backButton == nil){
        
        _backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREENW, SCREENH)];
        _backButton.backgroundColor = RGBA(155, 155, 155, 0.4);
        [_backButton addTarget:self action:@selector(dissMiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
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
        
        UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, IFFitFloat6(lwb_margin), _alertView.lwb_width, IFFitFloat6(40))];
        titleLab.backgroundColor = [UIColor clearColor];
        titleLab.text = @"提示";
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.textColor = textColour;
        titleLab.font = BoldFont(22);
        [_alertView addSubview:titleLab];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, IFFitFloat6(60), _alertView.lwb_width, 2)];
        lineView.backgroundColor = mainBackColor;
        [_alertView addSubview:lineView];
        
        CGFloat height = _alertView.lwb_height - 102;
        CGFloat width = _alertView.lwb_width - lwb_margin * 2;
        UILabel *titleLab1 = [[UILabel alloc]initWithFrame:CGRectMake(lwb_margin, lineView.lwb_bottom, width, height)];
        titleLab1.backgroundColor = [UIColor clearColor];
        NSString *str1 = @"您确定要取消预约吗?";
        NSString *str2 = @"若取消成功后,费用将退回原账户.";
        NSString *text = [NSString stringWithFormat:@"%@\n%@",str1,str2];
        titleLab1.text = text;
        [titleLab1 setLabelSpaceOfLineSpacing:6.f Kern:1.f];
        titleLab1.textAlignment = NSTextAlignmentCenter;
        titleLab1.textColor = textColour;
        titleLab1.font = navTitleFont;
        titleLab1.numberOfLines = 2;
        [_alertView addSubview:titleLab1];
        
        CGFloat sepacing = (_alertView.lwb_width - IFFitFloat6(120) * 2) * 0.2;
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelBtn.titleLabel setFont:navTitleFont];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:backColor forState:UIControlStateNormal];
        cancelBtn.backgroundColor = WHITECOLORA(1);
        cancelBtn.lwb_x = sepacing * 2;
        cancelBtn.lwb_y = _alertView.lwb_height - 60;
        cancelBtn.lwb_width = IFFitFloat6(120);
        cancelBtn.lwb_height = 40.f;
        cancelBtn.layer.masksToBounds = YES;
        cancelBtn.layer.cornerRadius = 20.f;
        cancelBtn.layer.borderColor = backColor.CGColor;
        cancelBtn.layer.borderWidth = 1.f;
        [cancelBtn addTarget:self action:@selector(dissMiss) forControlEvents:UIControlEventTouchUpInside];
        [_alertView addSubview:cancelBtn];
        
        UIButton *enterBtn = [[UIButton alloc]init];
        [enterBtn setTitle:@"确定" forState:UIControlStateNormal];
        [enterBtn setTitleColor:WHITECOLORA(1) forState:UIControlStateNormal];
        enterBtn.titleLabel.font = navTitleFont;
        enterBtn.backgroundColor = backColor;
        enterBtn.lwb_y = _alertView.lwb_height - 60;
        enterBtn.lwb_width = IFFitFloat6(120);
        enterBtn.lwb_height = 40.f;
        enterBtn.lwb_x = sepacing * 3 + IFFitFloat6(120);
        enterBtn.layer.masksToBounds = YES;
        enterBtn.layer.cornerRadius = 20.f;
        [enterBtn addTarget:self action:@selector(omo_enterCancelRemoteBooking) forControlEvents:UIControlEventTouchUpInside];
        [_alertView addSubview:enterBtn];
    }
    return _alertView;
}

- (void)show
{
    [[OMOIphoneManager getCurrentVC].view addSubview:self];
    //动画
    [UIView animateWithDuration:0.5 animations:^{
        self.alertView.lwb_centerY = self.bounds.size.height * 0.5;
        self.backButton.alpha = 0.5;
    }];
}
- (void)dissMiss{
    
    //动画
    [UIView animateWithDuration:0.25 animations:^{
        self.alertView.lwb_y = self.bounds.size.height;
        self.backButton.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
#pragma mark -------- 取消远程预约 ----------
- (void)omo_enterCancelRemoteBooking{
    
    if(self.cancelBookingBlock){
        
        self.cancelBookingBlock();
        [self dissMiss];
    }
}
@end
