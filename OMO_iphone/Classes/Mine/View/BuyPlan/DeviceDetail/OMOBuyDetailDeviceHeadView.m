//
//  OMOBuyDetailDeviceHeadView.m
//  OMO_iphone
//
//  Created by wy on 2018/10/20.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOBuyDetailDeviceHeadView.h"

@interface OMOBuyDetailDeviceHeadView()

/** 名称 */
@property (nonatomic, strong)UILabel *nameLab;
/** 价格 */
@property (nonatomic, strong)UILabel *priceLab;
/** 数量 */
@property (nonatomic, strong)UILabel *numLab;

@end

@implementation OMOBuyDetailDeviceHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        self.backgroundColor = mainBackColor;
        [self addSubview:self.nameLab];
        [self addSubview:self.priceLab];
        [self addSubview:self.numLab];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.lwb_height - 2, self.lwb_width, 2)];
        lineView.backgroundColor = WHITECOLORA(1);
        [self addSubview:lineView];
    }
    return self;
}
- (UILabel *)nameLab{
    
    if(_nameLab == nil){
        
        _nameLab = [[UILabel alloc]init];
        _nameLab.text = @"名称";
        _nameLab.textAlignment = NSTextAlignmentLeft;
        _nameLab.textColor = DetailColor;
        _nameLab.font = navTitleFont;
    }
    return _nameLab;
}
- (UILabel *)priceLab{
    
    if(_priceLab == nil){
        
        _priceLab = [[UILabel alloc]init];
        _priceLab.text = @"价格";
        _priceLab.textAlignment = NSTextAlignmentCenter;
        _priceLab.textColor = DetailColor;
        _priceLab.font = navTitleFont;
    }
    return _priceLab;
}
- (UILabel *)numLab{
    
    if(_numLab == nil){
        
        _numLab = [[UILabel alloc]init];
        _numLab.text = @"数量";
        _numLab.textAlignment = NSTextAlignmentRight;
        _numLab.textColor = DetailColor;
        _numLab.font = navTitleFont;
    }
    return _numLab;
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self.nameLab sizeToFit];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(lwb_margin * 3);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.priceLab sizeToFit];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.numLab sizeToFit];
    [self.numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-lwb_margin * 3);
        make.centerY.equalTo(self.mas_centerY);
    }];
}

@end
