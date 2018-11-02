//
//  OMOFoundAroundStoreCell.m
//  OMO_iphone
//
//  Created by 刘卫兵 on 2018/9/10.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOFoundAroundStoreCell.h"

@interface OMOFoundAroundStoreCell()

@property(strong,nonatomic)UIImageView *showImg;// 展示图
@property(strong,nonatomic)UILabel *titleLab;// 标题
@property(strong,nonatomic)UILabel *detaiLab;// 详情
@property(strong,nonatomic)UILabel *typeLab;// 时长
@property(strong,nonatomic)UILabel *numLab;// 次数

@end

@implementation OMOFoundAroundStoreCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.showImg];
        [self addSubview:self.titleLab];
        [self addSubview:self.detaiLab];
        [self addSubview:self.typeLab];
        [self addSubview:self.numLab];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [_showImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(lwb_margin);
        make.bottom.equalTo(self.mas_bottom).offset(-lwb_margin);
        make.top.equalTo(self.mas_top).offset(lwb_margin);
        make.width.equalTo(self.mas_height).offset(-lwb_margin * 2);
    }];
    
    [_titleLab sizeToFit];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.showImg.mas_right).offset(lwb_margin);
        make.bottom.equalTo(self.showImg.mas_centerY).offset(-lwb_smallMargin * 0.5);
        make.right.equalTo(self.typeLab.mas_left).offset(-lwb_margin);
    }];
    
    [_typeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.numLab.mas_left).offset(-lwb_margin);
        make.centerY.equalTo(self.titleLab.mas_centerY);
        make.width.equalTo(@(60));
        make.height.equalTo(@(20));
    }];
    _typeLab.layer.masksToBounds = YES;
    _typeLab.layer.cornerRadius = 10.f;
    
    [_numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.mas_right).offset(-lwb_margin);
        make.centerY.equalTo(self.titleLab.mas_centerY);
        make.width.equalTo(@(60));
        make.height.equalTo(@(20));
    }];
    _numLab.layer.masksToBounds = YES;
    _numLab.layer.cornerRadius = 10.f;
    
    [_detaiLab sizeToFit];
    [_detaiLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.mas_bottom).offset(-lwb_margin);
        make.left.equalTo(self.showImg.mas_right).offset(lwb_margin);
        make.top.equalTo(self.showImg.mas_centerY).offset(lwb_smallMargin * 0.5);
        make.right.equalTo(self.mas_right).offset(-lwb_margin);
    }];
}
- (UIImageView *)showImg{
    
    if(_showImg == nil){
        
        _showImg = [[UIImageView alloc]init];
        _showImg.contentMode = UIViewContentModeScaleToFill;
        _showImg.backgroundColor = backColor;
    }
    return _showImg;
}
- (UILabel *)titleLab{
    
    if(_titleLab == nil){
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.text = @"全身疼痛";
        _titleLab.textColor = textColour;
        _titleLab.font = Font(16);
        _titleLab.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLab;
}
- (UILabel *)typeLab{
    
    if(_typeLab == nil){
        
        _typeLab = [[UILabel alloc]init];
        _typeLab.text = @"疼痛";
        _typeLab.textColor = WHITECOLORA(1);
        _typeLab.backgroundColor = YellowColor;
        _typeLab.font = Font(10);
        _typeLab.textAlignment = NSTextAlignmentCenter;
    }
    return _typeLab;
}
- (UILabel *)numLab{
    
    if(_numLab == nil){
        
        _numLab = [[UILabel alloc]init];
        _numLab.text = @"产后";
        _numLab.font = Font(10);
        _numLab.textColor = WHITECOLORA(1);
        _numLab.backgroundColor = GreenColor;
        _numLab.textAlignment = NSTextAlignmentCenter;
    }
    return _numLab;
}
- (UILabel *)detaiLab{
    
    if(_detaiLab == nil){
        
        _detaiLab = [[UILabel alloc]init];
        _detaiLab.text = @"地址啊地址啊,这是地址啊,这就是地址啊";
        _detaiLab.font = defoultFont;
        _detaiLab.textColor = DetailColor;
        [_detaiLab setLabelSpaceOfLineSpacing:4.f Kern:0.1f];
        _detaiLab.textAlignment = NSTextAlignmentLeft;
    }
    return _detaiLab;
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
