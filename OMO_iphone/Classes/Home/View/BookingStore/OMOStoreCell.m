//
//  OMOStoreCell.m
//  OMO_iphone
//
//  Created by wy on 2018/10/10.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOStoreCell.h"

@interface OMOStoreCell()

/** 店名 */
@property (nonatomic, strong)UILabel *storeNameLab;
/** 地址 */
@property (nonatomic, strong)UILabel *addressLab;
/** 店大图 */
@property (nonatomic, strong)UIImageView *storeImg;
/** 人数 */
@property (nonatomic, strong)UILabel *peopleLab;
/** 距离 */
@property (nonatomic, strong)UILabel *placeLab;

@end

@implementation OMOStoreCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        self.backgroundColor = WHITECOLORA(1);
        [self addSubview:self.storeNameLab];
        [self addSubview:self.addressLab];
        [self addSubview:self.storeNameLab];
        [self addSubview:self.storeImg];
        [self addSubview:self.peopleLab];
        [self addSubview:self.placeLab];
        self.layer.cornerRadius = lwb_margin;
    }
    return self;
}
- (void)setStoreModel:(OMOStoreModel *)storeModel{
    
    _storeModel = storeModel;
    
    _storeNameLab.text = storeModel.store_name;
    _addressLab.text = [NSString stringWithFormat:@"%@%@%@%@",storeModel.province,storeModel.city,storeModel.country,storeModel.address];
    [_storeImg sd_setImageWithURL:[NSURL URLWithString:storeModel.logo_url] placeholderImage:[UIImage imageNamed:@""]];
    _peopleLab.text = storeModel.people;
    _placeLab.text = storeModel.place;
    
    [self setSubViewsFrame];
}
- (void)setSubViewsFrame{
    
    [_storeNameLab sizeToFit];
    [_storeNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(lwb_margin * 2);
        make.top.equalTo(self.mas_top).offset(lwb_margin * 2);
    }];
    
    [_addressLab sizeToFit];
    [_addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.storeNameLab.mas_bottom).offset(lwb_smallMargin);
        make.left.equalTo(self.mas_left).offset(lwb_margin * 2);
    }];

    [_storeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(lwb_margin * 2);
        make.right.equalTo(self.mas_right).offset(-lwb_margin * 2);
        make.top.mas_equalTo(self.addressLab.mas_bottom).offset(lwb_margin);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-60);
    }];
    
    [_peopleLab sizeToFit];
    [_peopleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(lwb_margin * 2);
        make.bottom.equalTo(self.mas_bottom).offset(-lwb_margin * 2);
    }];
    
    [_placeLab sizeToFit];
    [_placeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_bottom).offset(-lwb_margin * 2);
    }];
}
- (UILabel *)storeNameLab{
    
    if(_storeNameLab == nil){
        
        _storeNameLab = [[UILabel alloc]init];
        _storeNameLab.font = BoldFont(18);
        _storeNameLab.textColor = textColour;
        _storeNameLab.textAlignment = NSTextAlignmentLeft;
    }
    return _storeNameLab;
}
- (UILabel *)addressLab{
    
    if(_addressLab == nil){
        
        _addressLab = [[UILabel alloc]init];
        _addressLab.font = Font(18);
        _addressLab.textColor = DetailColor;
        _addressLab.textAlignment = NSTextAlignmentLeft;
    }
    return _addressLab;
}
- (UIImageView *)storeImg{
    
    if(_storeImg == nil){
        
        _storeImg = [[UIImageView alloc]init];
        _storeImg.clipsToBounds = YES;
        _storeImg.contentMode = UIViewContentModeScaleAspectFill;
        _storeImg.layer.cornerRadius = lwb_margin;
        _storeImg.backgroundColor = DetailColor;
    }
    return _storeImg;
}
- (UILabel *)peopleLab{
    
    if(_peopleLab == nil){
        
        _peopleLab = [[UILabel alloc]init];
        _peopleLab.font = [UIFont systemFontOfSize:13];
        _peopleLab.textColor = DetailColor;
        _peopleLab.textAlignment = NSTextAlignmentLeft;
    }
    return _peopleLab;
}
- (UILabel *)placeLab{
    
    if(_placeLab == nil){
        
        _placeLab = [[UILabel alloc]init];
        _placeLab.font = [UIFont systemFontOfSize:13];
        _placeLab.textColor = DetailColor;
        _placeLab.textAlignment = NSTextAlignmentLeft;
    }
    return _placeLab;
}
@end
