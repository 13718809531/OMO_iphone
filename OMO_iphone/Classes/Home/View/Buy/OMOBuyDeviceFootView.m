//
//  OMOBuyDeviceFootView.m
//  OMO_iphone
//
//  Created by wy on 2018/10/17.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOBuyDeviceFootView.h"

@interface OMOBuyDeviceFootView()

/**  */
@property (nonatomic, strong)UILabel *titleLab;
/**  */
@property (nonatomic, strong)UILabel *priceLab;
/**  */
@property (nonatomic, strong)UILabel *freightLab;

@end

@implementation OMOBuyDeviceFootView

- (instancetype)init{
    
    if(self = [super init]){
        
        self.backgroundColor = WHITECOLORA(1);
        self.frame = CGRectMake(0, 0, SCREENW, IFFitFloat6(80));
        
        [self addSubview:self.titleLab];
        [self addSubview:self.priceLab];
        [self addSubview:self.freightLab];
    }
    return self;
}
- (void)setGoodsTotalPrice:(double)goodsTotalPrice{
    
    _goodsTotalPrice = goodsTotalPrice;
    
    _priceLab.text = [NSString stringWithFormat:@"¥%.2f",goodsTotalPrice];
}
- (void)setFreightPrice:(double)freightPrice{
    
    _freightPrice = freightPrice;
    
    _freightLab.text = [NSString stringWithFormat:@"(满%.0f元免运费)",freightPrice];
}
- (UILabel *)titleLab{
    
    if(_titleLab == nil){
        
        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(lwb_margin * 2, 5, self.lwb_width * 2 / 3 - lwb_margin * 4, self.lwb_height * 0.5)];
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.textColor = textColour;
        _titleLab.font = Font(18);
        _titleLab.text = @"实际支付";
    }
    return _titleLab;
}
- (UILabel *)priceLab{
    
    if(_priceLab == nil){
        
        _priceLab = [[UILabel alloc]initWithFrame:CGRectMake(self.lwb_width * 2 / 3, 5, self.lwb_width/ 3 - lwb_margin * 2, self.lwb_height * 0.5)];
        _priceLab.textAlignment = NSTextAlignmentRight;
        _priceLab.textColor = textColour;
        _priceLab.font = BoldFont(18);
    }
    return _priceLab;
}
- (UILabel *)freightLab{
    
    if(_freightLab == nil){
        
        _freightLab = [[UILabel alloc]initWithFrame:CGRectMake(lwb_margin * 2, self.lwb_height * 0.5, self.lwb_width - lwb_margin * 4, self.lwb_height * 0.5)];
        _freightLab.textAlignment = NSTextAlignmentRight;
        _freightLab.textColor = DetailColor;
        _freightLab.font = bigFont;
    }
    return _freightLab;
}
@end
