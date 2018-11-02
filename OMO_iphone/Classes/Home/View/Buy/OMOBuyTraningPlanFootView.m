//
//  OMOBuyTraningPlanFootView.m
//  OMO_iphone
//
//  Created by wy on 2018/10/17.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOBuyTraningPlanFootView.h"

@interface OMOBuyTraningPlanFootView()

/**  */
@property (nonatomic, strong)UILabel *titleLab;
/**  */
@property (nonatomic, strong)UILabel *priceLab;

@end

@implementation OMOBuyTraningPlanFootView

- (instancetype)init{
    
    if(self = [super init]){
        
        self.backgroundColor = WHITECOLORA(1);
        self.frame = CGRectMake(0, 0, SCREENW, IFFitFloat6(80));
        
        [self addSubview:self.titleLab];
        [self addSubview:self.priceLab];
    }
    return self;
}
- (void)setPlanPrice:(double)planPrice{
    
    _planPrice = planPrice;
    
    _priceLab.text = [NSString stringWithFormat:@"¥%.2f",planPrice];
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

@end
