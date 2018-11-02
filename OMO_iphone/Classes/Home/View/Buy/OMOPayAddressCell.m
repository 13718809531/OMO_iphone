//
//  OMOPayAddressCell.m
//  OMO_iphone
//
//  Created by wy on 2018/10/9.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOPayAddressCell.h"

@interface OMOPayAddressCell()

@property (nonatomic,strong)UILabel * nameLabel;
@property (nonatomic,strong)UILabel * phoneLable;
@property (nonatomic,strong)UIImageView * addImage;
@property (nonatomic,strong)UILabel * showlabel;
@property (nonatomic,strong)UILabel * addressLabel;
@property (nonatomic,strong)UIImageView * rightImage;
@property (nonatomic,strong)UILabel * topLine;
@property (nonatomic,strong)UILabel * bottomLine;

@end

@implementation OMOPayAddressCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUI];
    }return self;
}
-(void)setDataWithDic:(NSDictionary *)dic
{
    self.nameLabel.text = @"收货人：菲小樊";
    self.phoneLable.text = @"18613891964";
    self.addressLabel.text = @"北京市朝阳区建国门外大街国贸一座北京市朝阳区建国门外大街国贸一座";
}
-(void)setAddressModel:(OMOUserAddressModel *)addressModel
{
    _addressModel = addressModel;
    self.nameLabel.text = addressModel.name;
    self.phoneLable.text = addressModel.mobile;
    self.addressLabel.text = [NSString stringWithFormat:@"%@ %@",addressModel.province,addressModel.city,addressModel.country,addressModel.address];
}
-(void)setUI
{
    [self.contentView addSubview:self.topLine];
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.top.equalTo(self.contentView.mas_top);
        make.right.equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(8);
    }];
    [self.contentView addSubview:self.bottomLine];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.right.equalTo(self.topLine.mas_right);
        make.height.mas_equalTo(8);
    }];
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(35);
        make.top.equalTo(self.contentView.mas_top).offset(28);
        make.height.mas_equalTo(17);
    }];
    [self.contentView addSubview:self.phoneLable];
    [self.phoneLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-47);
        make.top.equalTo(self.nameLabel.mas_top);
        make.height.mas_equalTo(17);
    }];
    [self.contentView addSubview:self.rightImage];
    [self.rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-14);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.mas_equalTo(11);
        make.height.mas_equalTo(18);
    }];
    [self.contentView addSubview:self.showlabel];
    [self.showlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(16);
        make.height.mas_equalTo(18);
        make.width.mas_equalTo(70);
    }];
    [self.contentView addSubview:self.addressLabel];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.showlabel.mas_right);
        make.top.equalTo(self.showlabel.mas_top);
        make.right.equalTo(self.phoneLable.mas_right);
    }];
    [self.contentView addSubview:self.addImage];
    [self.addImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.showlabel.mas_left).offset(-3);
        make.centerY.equalTo(self.showlabel.mas_centerY);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(12);
    }];
}
-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        UILabel * labe = [[UILabel alloc] init];
        labe.font = [UIFont systemFontOfSize:14];
        labe.textColor = TextColor;
        labe.textAlignment = NSTextAlignmentCenter;
        _nameLabel = labe;
    }return _nameLabel;
}
-(UILabel *)phoneLable
{
    if (!_phoneLable) {
        UILabel * labe = [[UILabel alloc] init];
        labe.font = [UIFont systemFontOfSize:14];
        labe.textColor = TextColor;
        _phoneLable = labe;
    }return _phoneLable;
}
-(UIImageView *)addImage
{
    if (!_addImage) {
        UIImageView * imagev = [[UIImageView alloc] init];
        imagev.image = [UIImage imageNamed:@"setup_location"];
        _addImage = imagev;
    }return _addImage;
}
-(UILabel *)showlabel
{
    if (!_showlabel) {
        UILabel * labe = [[UILabel alloc] init];
        labe.font = [UIFont systemFontOfSize:14];
        labe.textColor = TextColor;
        labe.text = @"收货地址:";
        _showlabel = labe;
    }return _showlabel;
}
-(UILabel *)addressLabel
{
    if (!_addressLabel) {
        UILabel * labe = [[UILabel alloc] init];
        labe.font = [UIFont systemFontOfSize:14];
        labe.textColor = TextColor;
        labe.numberOfLines = 2;
        _addressLabel = labe;
    }return _addressLabel;
}
-(UIImageView *)rightImage
{
    if (!_rightImage) {
        UIImageView * imagev = [[UIImageView alloc] init];
        imagev.image = [UIImage imageNamed:@"right_black_arrow"];
        _rightImage = imagev;
    }return _rightImage;
}
-(UILabel *)topLine
{
    if (!_topLine) {
        UILabel * lable = [[UILabel alloc] init];
        lable.backgroundColor = DetailColor;
        _topLine = lable;
    }return _topLine;
}
-(UILabel *)bottomLine
{
    if (!_bottomLine) {
        UILabel * lable = [[UILabel alloc] init];
        lable.backgroundColor = DetailColor;
        _bottomLine = lable;
    }return _bottomLine;
}
@end
