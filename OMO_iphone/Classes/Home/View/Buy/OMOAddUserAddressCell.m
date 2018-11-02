//
//  OMOAddUserAddressCell.m
//  OMO_iphone
//
//  Created by wy on 2018/10/9.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOAddUserAddressCell.h"

@interface OMOAddUserAddressCell()

@property (nonatomic,strong)UIImageView *leftIamge;
@property (nonatomic,strong)UILabel *infoLabel;

@end

@implementation OMOAddUserAddressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUI];
    }return self;
}
-(void)setUI
{
    [self.contentView addSubview:self.leftIamge];
    [self.leftIamge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(12);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    [self.contentView addSubview:self.infoLabel];
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftIamge.mas_right).offset(20);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    UILabel * line = [[UILabel alloc] init];
    line.backgroundColor = DetailColor;
    [self.contentView addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-1);
        make.height.mas_equalTo(1);
    }];
}
-(UIImageView *)leftIamge
{
    if (!_leftIamge) {
        UIImageView * image = [[UIImageView alloc] init];
        image.image = [UIImage imageNamed:@"icon_tianjia_1"];
        image.layer.masksToBounds = YES;
        [image sizeToFit];
        _leftIamge = image;
    }return _leftIamge;
}
-(UILabel *)infoLabel
{
    if (!_infoLabel) {
        UILabel * label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = TextColor;
        label.text = @"添加收货地址";
        [label sizeToFit];
        _infoLabel = label;
    }return _infoLabel;
}

@end
