//
//  OMOBuyPlanCell.m
//  OMO_iphone
//
//  Created by wy on 2018/10/17.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOBuyPlanCell.h"

@interface OMOBuyPlanCell()

@property (nonatomic,strong)UILabel *titleLab;
@property (nonatomic,strong)UILabel *detailLab;

@end

@implementation OMOBuyPlanCell

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
    
    [_titleLab sizeToFit];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(lwb_margin * 2);
        make.width.equalTo(@(self.lwb_width * 0.5 - lwb_margin * 3));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [_detailLab sizeToFit];
    [_detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(self.lwb_width * 0.5 - lwb_margin * 3));
        make.right.equalTo(self.mas_right).offset(-lwb_margin * 2);
        make.centerY.equalTo(self.mas_centerY);
    }];
}

- (UILabel *)titleLab{
    
    if(_titleLab == nil){
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.textColor = textColour;
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.font = bigFont;
    }
    return _titleLab;
}
- (UILabel *)detailLab{
    
    if(_detailLab == nil){
        
        _detailLab = [[UILabel alloc]init];
        _detailLab.textColor = textColour;
        _detailLab.textAlignment = NSTextAlignmentRight;
        _detailLab.font = bigFont;
    }
    return _detailLab;
}
@end
