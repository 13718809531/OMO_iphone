//
//  OMOBuyPlanBottomView.m
//  OMO_iphone
//
//  Created by wy on 2018/10/20.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOBuyPlanBottomView.h"

@interface OMOBuyPlanBottomView()

@property(strong,nonatomic)UIButton *cancelBtn;//
@property(strong,nonatomic)UIButton *payBtn;//

@end

@implementation OMOBuyPlanBottomView

- (instancetype)init{
    
    if(self = [super init]){
        self.frame = CGRectMake(0, SCREENH - 80, SCREENW, 80);
        [self addSubview:self.cancelBtn];
        [self addSubview:self.payBtn];
    }
    return self;
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat x = (SCREENW - 120 * 2) / 5;
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(x * 2);
        make.size.mas_equalTo(CGSizeMake(120, 40));
        make.bottom.equalTo(self.mas_bottom).offset(-40);
    }];
    _cancelBtn.layer.masksToBounds = YES;
    _cancelBtn.layer.cornerRadius = 20.f;
    _cancelBtn.layer.borderWidth = 1.f;
    _cancelBtn.layer.borderColor = backColor.CGColor;
    
    [_payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.mas_right).offset(-x * 2);
        make.size.mas_equalTo(CGSizeMake(120, 40));
        make.bottom.equalTo(self.mas_bottom).offset(-40);
    }];
    _payBtn.layer.masksToBounds = YES;
    _payBtn.layer.cornerRadius = 20.f;
}
- (UIButton *)cancelBtn{
    if(!_cancelBtn){
        
        _cancelBtn = [[UIButton alloc]init];
        _cancelBtn.backgroundColor = WHITECOLORA(1);
        _cancelBtn.tag = 100;
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = navTitleFont;
        [_cancelBtn setTitleColor:backColor forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(md_xunLianButtonDidClickWithButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}
- (UIButton *)payBtn{
    if(!_payBtn){
        
        _payBtn = [[UIButton alloc]init];
        _payBtn.backgroundColor = backColor;
        _payBtn.tag = 200;
        [_payBtn setTitle:@"付款" forState:UIControlStateNormal];
        _payBtn.titleLabel.font = navTitleFont;
        [_payBtn setTitleColor:WHITECOLORA(1) forState:UIControlStateNormal];
        [_payBtn addTarget:self action:@selector(md_xunLianButtonDidClickWithButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _payBtn;
}
- (void)md_xunLianButtonDidClickWithButton:(UIButton *)sender{
    
    NSInteger type;
    
    if(sender.tag == 100){
        
        type = 0;
    }else{
        
        type = 1;
    }
    if([self.delegate respondsToSelector:@selector(omo_planCancelOrPayWithType:)]){
        
        [self.delegate omo_planCancelOrPayWithType:type];
    }
}

@end
