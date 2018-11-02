//
//  OMOBuyDeviceBottomView.m
//  OMO_iphone
//
//  Created by wy on 2018/10/17.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOBuyDeviceBottomView.h"

@interface OMOBuyDeviceBottomView()

/**  */
@property (nonatomic, strong)UILabel *freightLab;
/**  */
@property (nonatomic, strong)UILabel *priceLab;
/**  */
@property (nonatomic, strong)UIButton *submitBtn;

@end

@implementation OMOBuyDeviceBottomView

- (instancetype)init{
    
    if(self = [super init]){
        
        self.backgroundColor = WHITECOLORA(1);
        self.frame = CGRectMake(0, SCREENH - 44 - Between, SCREENW, 44);
        
        [self addSubview:self.submitBtn];
        [self addSubview:self.priceLab];
        [self addSubview:self.freightLab];
    }
    return self;
}
- (void)setIsFree:(BOOL)isFree{
    
    _isFree = isFree;
    
    if(isFree){
        
        _freightLab.text = @"运费:¥0";
    }
}
- (void)setShip_price:(NSString *)ship_price{
    
    _ship_price = ship_price;
    
    _freightLab.text = [NSString stringWithFormat:@"运费:¥%@",ship_price];
}
- (void)setTotalPrice:(NSString *)totalPrice{
    
    _totalPrice = totalPrice;
    
    _priceLab.text = [NSString stringWithFormat:@"合计:¥%@",totalPrice];
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat width1 = self.lwb_width * 0.25;
    
    [_freightLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(width1, self.lwb_height));
        make.left.equalTo(self.mas_left).offset(lwb_margin * 2);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    CGFloat width2 = self.lwb_width * 0.5 - lwb_margin * 3;
    [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(width2, self.lwb_height));
        make.left.equalTo(self.freightLab.mas_right);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [_submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.lwb_width * 0.25, self.lwb_height));
        make.right.equalTo(self.mas_right);
        make.centerY.equalTo(self.mas_centerY);
    }];
}
- (UILabel *)freightLab{
    
    if(_freightLab == nil){
        
        _freightLab = [[UILabel alloc]init];
        _freightLab.textAlignment = NSTextAlignmentLeft;
        _freightLab.textColor = DetailColor;
        _freightLab.font = navTitleFont;
    }
    return _freightLab;
}
- (UILabel *)priceLab{
    
    if(_priceLab == nil){
        
        _priceLab = [[UILabel alloc]init];
        _priceLab.textAlignment = NSTextAlignmentRight;
        _priceLab.textColor = textColour;
        _priceLab.font = navTitleFont;
    }
    return _priceLab;
}
- (UIButton *)submitBtn{
    if(_submitBtn == nil){
        
        _submitBtn = [[UIButton alloc]init];
        _submitBtn.backgroundColor = backColor;
        [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        _submitBtn.titleLabel.font = navTitleFont;
        [_submitBtn setTitleColor:WHITECOLORA(1) forState:UIControlStateNormal];
        [_submitBtn addTarget:self action:@selector(omo_submitOrder) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}
- (void)omo_submitOrder{
    
    if([self.delegate respondsToSelector:@selector(omo_submitOrderDidClik)]){
        
        [self.delegate omo_submitOrderDidClik];
    }
}
@end
