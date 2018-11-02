//
//  OMOBuyDetailDeviceFootView.m
//  OMO_iphone
//
//  Created by wy on 2018/10/20.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOBuyDetailDeviceFootView.h"

@interface OMOBuyDetailDeviceFootView()

/**  */
@property (nonatomic, strong)UILabel *titleLab;

@end

@implementation OMOBuyDetailDeviceFootView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        self.backgroundColor = mainBackColor;
        [self addSubview:self.titleLab];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.lwb_width, 2)];
        lineView.backgroundColor = WHITECOLORA(1);
        [self addSubview:lineView];
    }
    return self;
}
- (void)setTitle:(NSString *)title{
    
    _title = title;
    
    _titleLab.text = [NSString stringWithFormat:@"实付价:%@",title];
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
        _titleLab.textAlignment = NSTextAlignmentRight;
        _titleLab.font = navTitleFont;
    }
    return _titleLab;
}

@end
