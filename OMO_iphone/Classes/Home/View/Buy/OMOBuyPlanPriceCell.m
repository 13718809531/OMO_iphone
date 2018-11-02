//
//  OMOBuyPlanPriceCell.m
//  OMO_iphone
//
//  Created by wy on 2018/10/19.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOBuyPlanPriceCell.h"

@interface OMOBuyPlanPriceCell()

@property (nonatomic,strong)UILabel *titleLab;
/**  */
@property (nonatomic, strong)UILabel *detailLab;

@end

@implementation OMOBuyPlanPriceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = mainBackColor;
        
        [self addSubview:self.titleLab];
        [self addSubview:self.detailLab];
    }return self;
}
- (void)setTitle:(NSString *)title{
    
    _title = title;
    
    _titleLab.text = title;
}
- (void)setDetail:(NSString *)detail{
    
    _detail = detail;
    
    _detailLab.text = [NSString stringWithFormat:@"¥%@",detail];
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat width = (SCREENW - lwb_margin * 6) * 0.5;
    [_titleLab sizeToFit];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(lwb_margin * 2);
        make.width.equalTo(@(width));
    }];
    
    [_detailLab sizeToFit];
    [_detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-lwb_margin * 2);
        make.width.equalTo(@(width));
    }];
}
- (UILabel *)titleLab{
    
    if(_titleLab == nil){
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.textColor = textColour;
        _titleLab.font = bigFont;
        _titleLab.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLab;
}
- (UILabel *)detailLab{
    
    if(_detailLab == nil){
        
        _detailLab = [[UILabel alloc]init];
        _detailLab.textColor = textColour;
        _detailLab.font = bigFont;
        _detailLab.textAlignment = NSTextAlignmentRight;
    }
    return _detailLab;
}
@end
