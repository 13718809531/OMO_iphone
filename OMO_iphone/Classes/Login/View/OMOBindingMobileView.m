//
//  YXMobileView.m
//  OMO_iphone
//
//  Created by 刘卫兵 on 2018/9/6.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOBindingMobileView.h"

@interface OMOBindingMobileView()

@property(strong,nonatomic)UILabel *areaLab;// +86
//@property(strong,nonatomic)UIView *verticalLine;// 竖线
@property(strong,nonatomic)UIButton *clearBtn;
@property(strong,nonatomic)UIView *HorizontalLine;// 横线

@end

@implementation OMOBindingMobileView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.areaLab];
//        [self addSubview:self.verticalLine];
        [self addSubview:self.mobileTfd];
        [self addSubview:self.clearBtn];
        [self addSubview:self.HorizontalLine];
    }
    return self;
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [_areaLab sizeToFit];
    [_areaLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-lwb_smallMargin * 0.5);
    }];
    
    [_mobileTfd mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.areaLab.mas_right).offset(lwb_margin);
        make.top.equalTo(self.areaLab.mas_top);
        make.bottom.equalTo(self.areaLab.mas_bottom);
        make.right.mas_equalTo(self.mas_right).offset(lwb_margin * 2);
    }];
    
    [_clearBtn sizeToFit];
    [_clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
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
- (UILabel *)areaLab{
    
    if(_areaLab == nil){
        
        _areaLab = [[UILabel alloc]init];
        _areaLab.text = @"+86";
        _areaLab.textColor = textColour;
        _areaLab.font = Font(IFFitFloat6(16));
        _areaLab.textAlignment = NSTextAlignmentCenter;
    }
    return _areaLab;
}
//- (UIView *)verticalLine{
//
//    if(_verticalLine == nil){
//
//        _verticalLine = [[UIView alloc]init];
//        _verticalLine.backgroundColor = DetailColor;
//    }
//    return _verticalLine;
//}
- (UITextField *)mobileTfd{
    
    if(_mobileTfd == nil){
        
        _mobileTfd = [[UITextField alloc]init];
        _mobileTfd.textColor = textColour;
        _mobileTfd.font = Font(IFFitFloat6(16));
        _mobileTfd.placeholder = @"输入手机号";
        _mobileTfd.keyboardType = UIKeyboardTypeNumberPad;
        [_mobileTfd addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _mobileTfd;
}
- (UIButton *)clearBtn{
    
    if(_clearBtn == nil){
        
        _clearBtn = [[UIButton alloc]init];
        _clearBtn.hidden = YES;
        [_clearBtn setImage:[UIImage imageNamed:@"Clear_text"] forState:UIControlStateNormal];
        [_clearBtn setTitleColor:textColour forState:UIControlStateNormal];
        [_clearBtn addTarget:self action:@selector(yx_clearMobileText) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clearBtn;
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
        
        if(textField.text.length > 0){
            
            self.clearBtn.hidden = NO;
        }else{
            
            self.clearBtn.hidden = YES;
        }
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
