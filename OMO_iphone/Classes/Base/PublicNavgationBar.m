//
//  PublicNavgationBar.m
//  JXYH
//
//  Created by 惠发 on 2017/11/23.
//  Copyright © 2017年 友惠家(北京)信息科技有限公司. All rights reserved.
//

#import "PublicNavgationBar.h"

@implementation PublicNavgationBar
-(instancetype)init{
    self = [super init];
    //底部线
    self.line = [[UIView alloc] init];
    self.line.backgroundColor = mainBackColor;
    [self addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREENW, 1));
        make.left.equalTo(self);
        make.bottom.equalTo(self.mas_bottom);
    }];
    return self;
}
//添加标题
-(void)addTitltLabelWithText:(NSString *)text Font:(UIFont *)font{
    [self addSubview:self.titleLabel];
    self.titleLabel.text = text;
    self.titleLabel.font = font;
    [self.titleLabel sizeToFit];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        if (kDevice_Is_iPhoneX) {
          make.centerY.equalTo(self.mas_centerY).offset(22);
        }else{
          make.centerY.equalTo(self.mas_centerY).offset(10);
        }
    }];
}
//添加自定义颜色标题
-(void)addTitltLabelWithText:(NSString *)text Font:(UIFont *)font Color:(UIColor *)color{
    [self addTitltLabelWithText:text Font:font];
    self.titleLabel.textColor = color;
}
//添加左侧按钮
-(void)addLeftButtonWithImage:(UIImage *)image{
    [self addSubview:self.leftButton];
    [self.leftButton setImage:image forState:UIControlStateNormal];
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.left.equalTo(self);
        make.bottom.equalTo(self.mas_bottom);
    }];
}

//添加右侧图片按钮
-(void)addRightButtonWithImage:(UIImage *)image{
    [self addSubview:self.rightButton];
    [self.rightButton setImage:image forState:UIControlStateNormal];
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
    }];
}

//添加右侧图片按钮
- (void)addRightButtonWithButton:(UIButton *)button
{
    self.rightButton = button;
    [self addSubview:self.rightButton];
//    [self.rightButton setImage:image forState:UIControlStateNormal];
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 40));
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
    }];
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = textColour;
    }
    return _titleLabel;
}
- (UIButton *)leftButton{
    if (!_leftButton) {
        _leftButton = [[UIButton alloc] init];
    }
    return _leftButton;
}
- (UIButton *)rightButton{
    if (!_rightButton) {
        _rightButton = [[UIButton alloc] init];
    }
    return _rightButton;
}
@end
