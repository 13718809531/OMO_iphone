//
//  OMOBuyPlanPriceCell.m
//  OMO_iphone
//
//  Created by wy on 2018/10/20.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOBuyPlanMoneyCell.h"

@interface OMOBuyPlanMoneyCell()

@property (nonatomic,strong)UILabel *titleLab;
@property (nonatomic,strong)UILabel *priceLab;//

@end

@implementation OMOBuyPlanMoneyCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){

        self.backgroundColor = WHITECOLORA(1);
        [self addSubview:self.titleLab];
        [self addSubview:self.priceLab];
    }
    return self;
}
- (void)setDict:(NSDictionary *)dict{
    
    _dict = dict;
    
    _titleLab.text = dict[@"title"];
    
    _priceLab.text = [NSString stringWithFormat:@"¥%@",dict[@"price"]];
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat width = (SCREENW - lwb_margin * 6) * 0.5;
    [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-lwb_margin * 2);
        make.width.equalTo(@(width));
        make.height.equalTo(self.mas_height);
    }];
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(lwb_margin * 2);
        make.width.equalTo(@(width));
        make.height.equalTo(self.mas_height);
    }];
}
- (UILabel *)titleLab
{
    if (!_titleLab) {
        UILabel * label= [[UILabel alloc] init];
        label.font = navTitleFont;
        label.textColor = TextColor;
        label.textAlignment = NSTextAlignmentLeft;
        _titleLab = label;
    }return _titleLab;
}
- (UILabel *)priceLab
{
    if (!_priceLab) {
        UILabel * label= [[UILabel alloc] init];
        label.textColor = textColour;
        label.font = bigFont;
        label.textAlignment = NSTextAlignmentRight;
        _priceLab = label;
    }return _priceLab;
}

@end
