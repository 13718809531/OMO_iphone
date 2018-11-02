//
//  OMOPingGuTiChooseImageCell.m
//  OMO_iphone
//
//  Created by wy on 2018/9/28.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOPingGuTiChooseImageCell.h"

@interface OMOPingGuTiChooseImageCell()

@property (nonatomic, strong)UIImageView *titleImg;
@property (nonatomic, strong)UILabel *titleLab;
@property(strong,nonatomic)UIView *lineView;
@property (nonatomic, strong)UIImageView *selectImg;

@end

@implementation OMOPingGuTiChooseImageCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        self.layer.masksToBounds = YES;
        self.layer.borderWidth = 1.f;
        self.layer.borderColor = mainBackColor.CGColor;
        [self addSubview:self.titleImg];
        [self addSubview:self.lineView];
        [self addSubview:self.titleLab];
        [self addSubview:self.selectImg];
    }
    return self;
}
- (void)setOptionModel:(OMOPingGuTiOptionModel *)optionModel{
    
    _optionModel = optionModel;
    
    _titleLab.text = optionModel.name;
    
    if(optionModel.isSelect){
        
        self.backgroundColor = backColor;
        _titleLab.textColor = WHITECOLORA(1);
        _selectImg.image = [UIImage imageNamed:@"Agreement_Select"];
    }else{
        
        self.backgroundColor = RGB(238, 232, 231);
        _titleLab.textColor = textColour;
        _selectImg.image = [UIImage imageNamed:@"Agreement_Normal"];
    }
    [_titleImg sd_setImageWithURL:[NSURL URLWithString:optionModel.url] placeholderImage:[UIImage imageNamed:@""]];
}
- (UIImageView *)titleImg{
    
    if(_titleImg == nil){
        
        _titleImg = [[UIImageView alloc]init];
        _titleImg.contentMode = UIViewContentModeScaleToFill;
        _titleImg.clipsToBounds = YES;
    }
    return _titleImg;
}
- (UIView *)lineView{
    
    if(_lineView == nil){
        
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = mainBackColor;
    }
    return _lineView;
}
- (UILabel *)titleLab{
    
    if(_titleLab == nil){
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = bigFont;
        _titleLab.textColor = TextColor;
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.numberOfLines = 0;
        _titleLab.backgroundColor = [UIColor clearColor];
    }
    return _titleLab;
}
- (UIImageView *)selectImg{
    
    if(_selectImg == nil){
        
        _selectImg = [[UIImageView alloc]init];
        _selectImg.image = [UIImage imageNamed:@"Risk_Normal"];
    }
    return _selectImg;
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [_selectImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.right.equalTo(self.mas_right).offset(-lwb_margin);
        make.centerY.equalTo(self.titleLab.mas_centerY);
    }];
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(lwb_margin);
        make.top.equalTo(self.titleImg.mas_bottom);
        make.right.equalTo(self.mas_right).offset(-lwb_margin * 5);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.titleImg.mas_bottom);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(@1);
    }];
    
    [_titleImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.height.equalTo(@(SCREENW * 0.5));
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
    }];
}

@end
