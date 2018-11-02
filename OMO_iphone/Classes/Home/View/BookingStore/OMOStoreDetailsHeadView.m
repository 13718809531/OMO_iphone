//
//  OMOStoreDetailsHeadView.m
//  OMO_iphone
//
//  Created by wy on 2018/10/10.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOStoreDetailsHeadView.h"

@interface OMOStoreDetailsHeadView()

/**  */
@property (nonatomic, strong)UIButton *backBtn;
/** 店大图 */
@property (nonatomic, strong)UIImageView *storeImg;
/** 店名 */
@property (nonatomic, strong)UILabel *storeNameLab;
/** 地址 */
@property (nonatomic, strong)UILabel *addressLab;
/** 距离 */
@property (nonatomic, strong)UILabel *placeLab;

@end

@implementation OMOStoreDetailsHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        self.backgroundColor = WHITECOLORA(1);
        [self addSubview:self.storeNameLab];
        [self addSubview:self.addressLab];
        [self addSubview:self.storeNameLab];
        [self addSubview:self.storeImg];
        [self addSubview:self.placeLab];
        [self addSubview:self.backBtn];
    }
    return self;
}
- (void)setStoreModel:(OMOStoreModel *)storeModel{
    
    _storeModel = storeModel;
    
    _storeNameLab.text = storeModel.store_name;
    _addressLab.text = [NSString stringWithFormat:@"%@%@%@%@",storeModel.province,storeModel.city,storeModel.country,storeModel.address];
    [_storeImg sd_setImageWithURL:[NSURL URLWithString:storeModel.logo_url] placeholderImage:[UIImage imageNamed:@""]];
    _placeLab.text = storeModel.place;
    
    [self setSubViewsFrame];
}
- (void)setSubViewsFrame{
    
    [_storeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.mas_equalTo(self.mas_top);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-80);
    }];
    
    [_storeNameLab sizeToFit];
    [_storeNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(lwb_margin * 2);
        make.top.equalTo(self.storeImg.mas_bottom).offset(lwb_smallMargin * 3);
    }];
    
    [_addressLab sizeToFit];
    [_addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-lwb_smallMargin * 3);
        make.left.equalTo(self.mas_left).offset(lwb_margin * 2);
    }];
    
    [_placeLab sizeToFit];
    [_placeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-lwb_margin * 2);
        make.top.equalTo(self.storeImg.mas_bottom).offset(lwb_margin * 3);
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
        _storeImg.backgroundColor = DetailColor;
    }
    return _storeImg;
}
- (UILabel *)placeLab{
    
    if(_placeLab == nil){
        
        _placeLab = [[UILabel alloc]init];
        _placeLab.font = Font(13);
        _placeLab.textColor = DetailColor;
        _placeLab.textAlignment = NSTextAlignmentRight;
    }
    return _placeLab;
}
- (UIButton *)backBtn{
    
    if(_backBtn == nil){
        
        _backBtn = [[UIButton alloc]init];
        [_backBtn setImage:[UIImage imageNamed:@"App_Back"] forState:UIControlStateNormal];
        _backBtn.size = CGSizeMake(30, 30);
        _backBtn.lwb_x = 13;
        _backBtn.lwb_y = Between + 20 + 7;
        [_backBtn addTarget:self action:@selector(omo_back) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}
- (void)omo_back{
    
    [[OMOIphoneManager getCurrentVC].navigationController popViewControllerAnimated:YES];
}
@end
