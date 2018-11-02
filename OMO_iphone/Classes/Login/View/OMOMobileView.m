//
//  YXMobileView.m
//  OMO_iphone
//
//  Created by 刘卫兵 on 2018/9/6.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOMobileView.h"

@interface OMOMobileView()

/** 提示文字 */
@property (nonatomic, strong)UILabel *promptLab;
@property(strong,nonatomic)UIView *HorizontalLine;// 横线

@end

@implementation OMOMobileView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.promptLab];
        [self addSubview:self.mobileTfd];
        [self addSubview:self.HorizontalLine];
    }
    return self;
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [_promptLab sizeToFit];
    [_promptLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(IFFitFloat6(50));
        make.top.equalTo(self.mas_top);
    }];
    
    [_mobileTfd mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(IFFitFloat6(50));
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom).offset(-1);
        make.right.mas_equalTo(self.mas_right).offset(IFFitFloat6(50));
    }];
    
    [_HorizontalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.height.equalTo(@(1));
    }];
}
- (UILabel *)promptLab{
    
    if(_promptLab == nil){
        
        _promptLab = [[UILabel alloc]init];
        _promptLab.text = @"输入手机号";
        _promptLab.textColor = textColour;
        _promptLab.font = Font(28);
        _promptLab.textAlignment = NSTextAlignmentLeft;
    }
    return _promptLab;
}
- (UITextField *)mobileTfd{
    
    if(_mobileTfd == nil){
        
        _mobileTfd = [[UITextField alloc]init];
        _mobileTfd.textColor = textColour;
        _mobileTfd.font = Font(IFFitFloat6(16));
        _mobileTfd.placeholder = @"输入手机号";
        _mobileTfd.clearButtonMode = UITextFieldViewModeAlways;
        _mobileTfd.keyboardType = UIKeyboardTypeNumberPad;
        [_mobileTfd addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _mobileTfd;
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
    if (textField == self.mobileTfd) {
        
        if (textField.text.length > 11) {
            
            textField.text = [textField.text substringToIndex:11];
        }
    }
}
#pragma mark ---------- 清楚输入框文字 ------------
- (void)yx_clearMobileText{
    
    if(_mobileTfd.text.length > 0){
        
        _mobileTfd.text = @"";
    }
}
@end
