//
//  OMOAddressCell.m
//  OMO_iphone
//
//  Created by wy on 2018/10/11.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOAddressCell.h"

#import "OMOAddAddressVC.h"

@interface OMOAddressCell()

/** 默认 */
@property (nonatomic, strong)UILabel *defaultLab;
@property (nonatomic,strong)UILabel * nameLabel;
@property (nonatomic,strong)UILabel * phoneLable;
@property (nonatomic,strong)UILabel * addressLabel;
@property (nonatomic,strong)UILabel * topLine;
@property (nonatomic,strong)UILabel * bottomLine;
/**  */
@property (nonatomic, strong)UIButton *edingBtn;

@end

@implementation OMOAddressCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self addSubview:self.defaultLab];
        [self addSubview:self.topLine];
        [self addSubview:self.bottomLine];
        [self addSubview:self.nameLabel];
        [self addSubview:self.phoneLable];
        [self addSubview:self.addressLabel];
        [self addSubview:self.edingBtn];
    }return self;
}
- (void)setAddressModel:(OMOUserAddressModel *)addressModel
{
    _addressModel = addressModel;
    self.nameLabel.text = addressModel.name;
    self.phoneLable.text = addressModel.mobile;
    self.addressLabel.text = [NSString stringWithFormat:@"%@%@%@%@",addressModel.province,addressModel.city,addressModel.country,addressModel.address];
    
    [self setSubViewsFrame];
}
- (void)setSubViewsFrame
{
    [_topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.mas_top);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(lwb_smallMargin);
    }];

    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(lwb_smallMargin);
    }];
    
    CGFloat width = 0;
    
    if([_addressModel.is_default isEqualToString:@"2"]){
        
        width = 40.f;
    }
    [_defaultLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(lwb_margin * 2);
        make.top.equalTo(self.mas_top).offset(28);
        make.width.equalTo(@(width));
        make.height.mas_equalTo(17);
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.defaultLab.mas_right).offset(lwb_margin);
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

    [_edingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(50));
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
    }];
}
- (UILabel *)defaultLab
{
    if (!_defaultLab) {
        UILabel * labe = [[UILabel alloc] init];
        labe.font = defoultFont;
        labe.text = @"默认";
        labe.backgroundColor = backColor;
        labe.textColor = TextColor;
        labe.textAlignment = NSTextAlignmentCenter;
        labe.layer.masksToBounds = YES;
        labe.layer.cornerRadius = lwb_smallMargin;
        _defaultLab = labe;
    }return _defaultLab;
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
- (UIButton *)edingBtn{
    
    if(_edingBtn == nil){
        
        _edingBtn = [[UIButton alloc]init];
        [_edingBtn setImage:[UIImage imageNamed:@"Arrow_Right"] forState:UIControlStateNormal];
        [_edingBtn addTarget:self action:@selector(omo_edtingAddress) forControlEvents:UIControlEventTouchUpInside];
    }
    return _edingBtn;
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
- (UILabel *)topLine
{
    if (!_topLine) {
        UILabel * lable = [[UILabel alloc] init];
        lable.backgroundColor = mainBackColor;
        _topLine = lable;
    }return _topLine;
}
- (UILabel *)bottomLine
{
    if (!_bottomLine) {
        UILabel * lable = [[UILabel alloc] init];
        lable.backgroundColor = mainBackColor;
        _bottomLine = lable;
    }return _bottomLine;
}
#pragma mark -------- 编辑收货地址 ---------
- (void)omo_edtingAddress{
    
    OMOAddAddressVC *addAddressVC = [[OMOAddAddressVC alloc]init];
    addAddressVC.addressModel = _addressModel;
    [[OMOIphoneManager getCurrentVC].navigationController pushViewController:addAddressVC animated:YES];
}
@end
