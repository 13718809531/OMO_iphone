//
//  OMOBuyDeviceAddressCell.m
//  OMO_iphone
//
//  Created by wy on 2018/10/20.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOBuyDeviceAddressCell.h"

@interface OMOBuyDeviceAddressCell()

@property (nonatomic,strong)UILabel * nameLabel;
@property (nonatomic,strong)UILabel * phoneLable;
@property (nonatomic,strong)UILabel * addressLabel;

@end

@implementation OMOBuyDeviceAddressCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = WHITECOLORA(1);
        
        [self addSubview:self.nameLabel];
        [self addSubview:self.phoneLable];
        [self addSubview:self.addressLabel];
    }return self;
}
- (void)setAddressModel:(OMOUserAddressModel *)addressModel
{
    _addressModel = addressModel;
    self.nameLabel.text = addressModel.name;
    self.phoneLable.text = addressModel.mobile;
    self.addressLabel.text = addressModel.address;
    
    [self setSubViewsFrame];
}
- (void)setSubViewsFrame{
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(lwb_margin * 2);
        make.top.equalTo(self.mas_top).offset(28);
        make.height.mas_equalTo(17);
    }];
    
    [_phoneLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-60);
        make.top.equalTo(self.nameLabel.mas_top);
        make.height.mas_equalTo(17);
    }];
    
    
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(lwb_margin * 2);
        make.bottom.equalTo(self.mas_bottom).offset(-lwb_margin);
        make.right.equalTo(self.mas_right).offset(-60);
    }];
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        UILabel * labe = [[UILabel alloc] init];
        labe.font = defoultFont;
        labe.textColor = TextColor;
        labe.textAlignment = NSTextAlignmentCenter;
        _nameLabel = labe;
    }return _nameLabel;
}
- (UILabel *)phoneLable
{
    if (!_phoneLable) {
        UILabel * labe = [[UILabel alloc] init];
        labe.font = defoultFont;
        labe.textColor = TextColor;
        _phoneLable = labe;
    }return _phoneLable;
}

- (UILabel *)addressLabel
{
    if (!_addressLabel) {
        UILabel * labe = [[UILabel alloc] init];
        labe.font = defoultFont;
        labe.textColor = TextColor;
        labe.numberOfLines = 2;
        _addressLabel = labe;
    }return _addressLabel;
}

@end
