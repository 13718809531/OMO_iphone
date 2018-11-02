//
//  OMOSelectGoodsNumView.m
//  OMO_iphone
//
//  Created by wy on 2018/10/10.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOSelectGoodsNumView.h"

@interface OMOSelectGoodsNumView()<UITextFieldDelegate>

@property(strong,nonatomic)UIButton *reductionButton;// 减号
@property(strong,nonatomic)UIButton *addButton;// 加号
@property(strong,nonatomic)UITextField *numTextField;// 显示

@end

@implementation OMOSelectGoodsNumView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){

        [self addSubview:self.reductionButton];
        [self addSubview:self.addButton];
        [self addSubview:self.numTextField];
    }
    return self;
}
- (void)setMaxNum:(NSInteger)maxNum{
    
    _maxNum = maxNum;
    
    if([_numTextField.text integerValue] > maxNum){
        
        _numTextField.text = [NSString stringWithFormat:@"%ld",maxNum];
    }
}
- (void)setMinNum:(NSInteger)minNum{
    
    _minNum = minNum;
    
    NSInteger number = [_numTextField.text integerValue];
    
    if(number >= minNum)return;
    
    if([_numTextField.text integerValue] < minNum){
        
        _numTextField.text = [NSString stringWithFormat:@"%ld",minNum];
        
        if([self.delegate respondsToSelector:@selector(omo_selectGoodsNumberOftext:)]){
            
            [self.delegate omo_selectGoodsNumberOftext:_numTextField.text];
        }
    }
}

// 减号
- (UIButton *)reductionButton{
    if(_reductionButton == nil){
        _reductionButton = [[UIButton alloc]init];
        _reductionButton.tag = 100;
        [_reductionButton setImage:[UIImage imageNamed:@"btn_xq_jian"] forState:UIControlStateNormal];
        [_reductionButton addTarget:self action:@selector(aj_selectNumberOfTravel:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reductionButton;
}
- (UITextField *)numTextField{
    if(_numTextField == nil){
        _numTextField = [[UITextField alloc]init];
        _numTextField.text = @"1";
        _numTextField.delegate = self;
        _numTextField.font = Font(18);
        _numTextField.keyboardType = UIKeyboardTypeNumberPad;
        _numTextField.textColor = textColour;
        _numTextField.textAlignment = NSTextAlignmentCenter;
        _numTextField.backgroundColor = WHITECOLORA(1);
    }
    return _numTextField;
}
- (UIButton *)addButton{
    if(_addButton == nil){
        _addButton = [[UIButton alloc]init];
        _addButton.tag = 200;
        [_addButton setImage:[UIImage imageNamed:@"btn_xq_jia"] forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(aj_selectNumberOfTravel:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [_addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.width.equalTo(@(22));
        make.height.equalTo(@(22));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [_numTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 25));
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [_reductionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.width.equalTo(@(22));
        make.height.equalTo(@(22));
        make.centerY.equalTo(self.mas_centerY);
    }];
}
// 按钮的点击事件
- (void)aj_selectNumberOfTravel:(UIButton *)button{
    
    [self resignFirstResponder];
    
    int number = [self.numTextField.text intValue];
    
    if(button.tag == 100){
        
        if(number > _minNum){
            
            self.numTextField.text = [NSString stringWithFormat:@"%d",number - 1];
        }else{
            
            return;
        }
    }else if(button.tag == 200){
        
        if(number < _maxNum){
            
            self.numTextField.text = [NSString stringWithFormat:@"%d",number + 1];
        }else{
            
            return;
        }
    }
    if([self.delegate respondsToSelector:@selector(omo_selectGoodsNumberOftext:)]){
        
        [self.delegate omo_selectGoodsNumberOftext:_numTextField.text];
    }
}

#pragma mark ------ UITextFieldDelegate ------
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    int number = [self.numTextField.text intValue];
    
    if(number < _minNum){
        
        NSString *count = [NSString stringWithFormat:@"本商品最少必须买%ld件",_minNum];
        [MBProgress showInfomationWithMessage:count duration:1.5];
        self.numTextField.text = [NSString stringWithFormat:@"%ld",_minNum];
    }else if(number > _maxNum){
        
        NSString *count = [NSString stringWithFormat:@"本商品最多只能买%ld件",_maxNum];
        [MBProgress showInfomationWithMessage:count duration:1.5];
        self.numTextField.text = [NSString stringWithFormat:@"%ld",_maxNum];
    }
    
    CGFloat width = self.numTextField.intrinsicContentSize.width;
    
    if(width <= 30){
        
        self.numTextField.lwb_width = 40.f;
    }else{
        
        self.numTextField.lwb_width = width + 10.f;
    }
    [self resignFirstResponder];
    
    if([self.delegate respondsToSelector:@selector(omo_selectGoodsNumberOftext:)]){
        
        [self.delegate omo_selectGoodsNumberOftext:_numTextField.text];
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    int number = [self.numTextField.text intValue];
    
    if(number < _minNum){
        
        NSString *count = [NSString stringWithFormat:@"本商品最少必须买%ld件",_minNum];
        [MBProgress showInfomationWithMessage:count duration:1.5];
        self.numTextField.text = [NSString stringWithFormat:@"%ld",_minNum];
    }else if(number > _maxNum){
        
        NSString *count = [NSString stringWithFormat:@"本商品最多只能买%ld件",_maxNum];
        [MBProgress showInfomationWithMessage:count duration:1.5];
        self.numTextField.text = [NSString stringWithFormat:@"%ld",_maxNum];
    }
    
    CGFloat width = self.numTextField.intrinsicContentSize.width;
    
    if(width <= 30){
        
        self.numTextField.lwb_width = 40.f;
    }else{
        
        self.numTextField.lwb_width = width + 10.f;
    }
    
    if([self.delegate respondsToSelector:@selector(omo_selectGoodsNumberOftext:)]){
        
        [self.delegate omo_selectGoodsNumberOftext:_numTextField.text];
    }
    return YES;
}
#pragma Mark ---------- YHSelectNumDelegate -----------
- (void)yh_numberOftext:(NSString *)text{
    
    if([self.delegate respondsToSelector:@selector(omo_selectGoodsNumberOftext:)]){
        
        [self.delegate omo_selectGoodsNumberOftext:text];
    }
}

@end
