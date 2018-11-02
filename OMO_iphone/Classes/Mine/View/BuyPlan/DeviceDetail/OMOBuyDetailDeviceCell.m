//
//  OMOBuyDetailDeviceCell.m
//  OMO_iphone
//
//  Created by wy on 2018/10/20.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOBuyDetailDeviceCell.h"

@interface OMOBuyDetailDeviceCell()

/** 名称 */
@property (nonatomic, strong)UILabel *nameLab;
/** 价格 */
@property (nonatomic, strong)UILabel *priceLab;
/** 数量 */
@property (nonatomic, strong)UILabel *numLab;

@end

@implementation OMOBuyDetailDeviceCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        self.backgroundColor = mainBackColor;
        [self addSubview:self.nameLab];
        [self addSubview:self.priceLab];
        [self addSubview:self.numLab];
    }
    return self;
}
- (void)setItemModel:(OMOKangFuBaoMtItemModel *)itemModel{
    
    _itemModel = itemModel;
    
    _nameLab.text = itemModel.name;
    
    _priceLab.text = [NSString stringWithFormat:@"¥%@",itemModel.unit_price];
    
    _numLab.text = itemModel.num;
}
- (UILabel *)nameLab{
    
    if(_nameLab == nil){
        
        _nameLab = [[UILabel alloc]init];
        _nameLab.textAlignment = NSTextAlignmentLeft;
        _nameLab.textColor = textColour;
        _nameLab.font = navTitleFont;
    }
    return _nameLab;
}
- (UILabel *)priceLab{
    
    if(_priceLab == nil){
        
        _priceLab = [[UILabel alloc]init];
        _priceLab.textAlignment = NSTextAlignmentCenter;
        _priceLab.textColor = textColour;
        _priceLab.font = navTitleFont;
    }
    return _priceLab;
}
- (UILabel *)numLab{
    
    if(_numLab == nil){
        
        _numLab = [[UILabel alloc]init];
        _numLab.textAlignment = NSTextAlignmentRight;
        _numLab.textColor = textColour;
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
