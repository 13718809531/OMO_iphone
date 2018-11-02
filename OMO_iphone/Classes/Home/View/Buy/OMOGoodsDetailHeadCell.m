//
//  OMOGoodsDetailHeadCell.m
//  OMO_iphone
//
//  Created by wy on 2018/10/9.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOGoodsDetailHeadCell.h"

@interface OMOGoodsDetailHeadCell()

/** 名称 */
@property (nonatomic, strong)UILabel *nameLab;
/** 价格 */
@property (nonatomic, strong)UILabel *priceLab;
/** 数量 */
@property (nonatomic, strong)UILabel *numLab;

@end

@implementation OMOGoodsDetailHeadCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        self.backgroundColor = mainBackColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.nameLab];
        [self addSubview:self.priceLab];
        [self addSubview:self.numLab];
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
        make.left.equalTo(self.mas_left).offset(lwb_margin * 5);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.priceLab sizeToFit];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.numLab sizeToFit];
    [self.numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-lwb_margin * 5);
        make.centerY.equalTo(self.mas_centerY);
    }];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
