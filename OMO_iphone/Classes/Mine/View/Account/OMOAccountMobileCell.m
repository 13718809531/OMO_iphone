//
//  OMOAccountMobileCell.m
//  OMO_iphone
//
//  Created by wy on 2018/10/13.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOAccountMobileCell.h"

@interface OMOAccountMobileCell()

/**  */
@property (nonatomic, strong)UILabel *titleLab;
/**  */
@property (nonatomic, strong)UILabel *detailLab;

@end

@implementation OMOAccountMobileCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = WHITECOLORA(1);
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self addSubview:self.titleLab];
        [self addSubview:self.detailLab];
    }
    return self;
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [_titleLab sizeToFit];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(lwb_margin * 2);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [_detailLab sizeToFit];
    [_detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-40);
    }];
}
- (UILabel *)titleLab{
    
    if(_titleLab == nil){
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.text = @"手机号";
        _titleLab.textColor = textColour;
        _titleLab.font = bigFont;
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}
- (UILabel *)detailLab{
    
    if(_detailLab == nil){
        
        _detailLab = [[UILabel alloc]init];
        _detailLab.text = [OMOIphoneManager sharedData].mobile;
        _detailLab.textColor = textColour;
        _detailLab.font = bigFont;
        _detailLab.textAlignment = NSTextAlignmentCenter;
    }
    return _detailLab;
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
