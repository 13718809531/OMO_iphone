//
//  OMOCustomTwoTitleButton.m
//  OMO_iphone
//
//  Created by 刘卫兵 on 2018/9/7.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOCustomTwoTitleButton.h"

@implementation OMOCustomTwoTitleButton

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.leftTitleLab];
        [self addSubview:self.rightTitleLab];
        [self addSubview:self.arrowImg];
    }
    return self;
}
- (instancetype)init{
    
    if(self = [super init]){
        
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.leftTitleLab];
        [self addSubview:self.rightTitleLab];
        [self addSubview:self.arrowImg];
    }
    return self;
}
- (void)setLeftTitle:(NSString *)leftTitle{
    
    _leftTitle = leftTitle;
    
    _leftTitleLab.text = leftTitle;
    
    [_leftTitleLab sizeToFit];
    [_leftTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(lwb_margin);
        make.centerY.equalTo(self.mas_centerY);
    }];
}
- (void)setRightTitle:(NSString *)rightTitle{
    
    _rightTitle = rightTitle;
    
    _rightTitleLab.text = rightTitle;
    
    [_rightTitleLab sizeToFit];
    [_rightTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.mas_right).offset(-self.lwb_height);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [_arrowImg sizeToFit];
    [_arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.mas_right).offset(-lwb_margin);
        make.centerY.equalTo(self.mas_centerY);
    }];
}
- (UILabel *)leftTitleLab{
    
    if(_leftTitleLab == nil){
        
        _leftTitleLab = [[UILabel alloc]init];
        _leftTitleLab.textColor = textColour;
        _leftTitleLab.font = defoultFont;
        _leftTitleLab.textAlignment = NSTextAlignmentLeft;
    }
    return _leftTitleLab;
}
- (UILabel *)rightTitleLab{
    
    if(_rightTitleLab == nil){
        
        _rightTitleLab = [[UILabel alloc]init];
        _rightTitleLab.textColor = textColour;
        _rightTitleLab.font = smallFont;
        _rightTitleLab.textAlignment = NSTextAlignmentRight;
    }
    return _rightTitleLab;
}
- (UIImageView *)arrowImg{
    
    if(_arrowImg == nil){
        
        _arrowImg = [[UIImageView alloc]init];
        _arrowImg.image = [UIImage imageNamed:@"Right_arrow"];
    }
    return _arrowImg;
}
@end
