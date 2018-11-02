//
//  OMOBuyDeviceTitleCell.m
//  OMO_iphone
//
//  Created by wy on 2018/10/20.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOBuyDeviceTitleCell.h"

@interface OMOBuyDeviceTitleCell()

/**  */
@property (nonatomic, strong)UILabel *titleLab;

@end

@implementation OMOBuyDeviceTitleCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        self.backgroundColor = WHITECOLORA(1);
        [self addSubview:self.titleLab];
    }
    return self;
}
- (void)setTitle:(NSString *)title{
    
    _title = title;
    
    _titleLab.text = title;
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(lwb_margin * 2);
        make.right.equalTo(self.mas_right).offset(-lwb_margin * 2);
        make.height.equalTo(self.mas_height);
        make.centerY.equalTo(self.mas_centerY);
    }];
}

- (UILabel *)titleLab{
    
    if(_titleLab == nil){
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.textColor = textColour;
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.font = BoldFont(18);
    }
    return _titleLab;
}

@end
