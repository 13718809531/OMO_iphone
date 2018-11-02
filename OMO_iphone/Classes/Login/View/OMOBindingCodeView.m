//
//  YXCodeView.m
//  OMO_iphone
//
//  Created by 刘卫兵 on 2018/9/6.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOBindingCodeView.h"

@interface OMOBindingCodeView()

@property(strong,nonatomic)UIView *HorizontalLine;// 横线

@end

@implementation OMOBindingCodeView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.codeTfd];
        [self addSubview:self.getCodeBtn];
        [self addSubview:self.HorizontalLine];
    }
    return self;
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [_codeTfd sizeToFit];
    [_codeTfd mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(lwb_smallMargin);
        make.bottom.equalTo(self.mas_bottom).offset(-lwb_smallMargin * 0.5);
        make.right.equalTo(self.getCodeBtn.mas_left).offset(-lwb_smallMargin);
    }];
    
    [_getCodeBtn sizeToFit];
    [_getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom).offset(-lwb_smallMargin * 0.5);
    }];
    
    [_HorizontalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.height.equalTo(@(1));
    }];
}
- (UITextField *)codeTfd{
    
    if(_codeTfd == nil){
        
        _codeTfd = [[UITextField alloc]init];
        _codeTfd.textColor = textColour;
        _codeTfd.font = Font(IFFitFloat6(16));
        _codeTfd.placeholder = @"输入验证码";
        _codeTfd.keyboardType = UIKeyboardTypeNumberPad;
        [_codeTfd addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _codeTfd;
}
- (UIButton *)getCodeBtn{
    
    if(_getCodeBtn == nil){
        
        _getCodeBtn = [[UIButton alloc]init];
        [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getCodeBtn setTitleColor:backColor forState:UIControlStateNormal];
        _getCodeBtn.titleLabel.font = Font(IFFitFloat6(16));
        [_getCodeBtn addTarget:self action:@selector(requestAuthCodeWithButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _getCodeBtn;
}
- (UIView *)HorizontalLine{
    
    if(_HorizontalLine == nil){
        
        _HorizontalLine = [[UIView alloc]init];
        _HorizontalLine.backgroundColor = backColor;
    }
    return _HorizontalLine;
}
#pragma mark ------- 判断手机号位数 -------
- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == self.codeTfd) {
        
        if (textField.text.length > 4) {
            
            textField.text = [textField.text substringToIndex:4];
        }
    }
}
#pragma mark - 请求验证码
-(void)requestAuthCodeWithButton:(UIButton *)sender{
    
    if([self.delegate respondsToSelector:@selector(yx_getCode:)]){
        
        [self.delegate yx_getCode:sender];
    }
}
@end
