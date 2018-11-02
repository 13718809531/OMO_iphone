//
//  OMOPingGuTiRedioCell.m
//  OMO_iphone
//
//  Created by wy on 2018/11/2.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOPingGuTiRedioCell.h"

@interface OMOPingGuTiRedioCell()

@property (nonatomic, strong)UIImageView *selectImg;
@property (nonatomic, strong)UILabel *titleLab;

@end

@implementation OMOPingGuTiRedioCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        [self addSubview:self.selectImg];
        [self addSubview:self.titleLab];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = lwb_margin;
    }
    return self;
}
- (void)setOptionModel:(OMOPingGuTiOptionModel *)optionModel{
    
    _optionModel = optionModel;
    
    if(optionModel.isSelect){
        
        self.backgroundColor = backColor;
        _titleLab.textColor = WHITECOLORA(1);
        _selectImg.image = [UIImage imageNamed:@"Risk_Select"];
    }else{
        
        self.backgroundColor = RGB(254, 244, 242);
        _titleLab.textColor = textColour;
        _selectImg.image = [UIImage imageNamed:@"Risk_Normal"];
    }
    
    NSString *text = optionModel.name;
    
    _titleLab.attributedText = [text setLabelSpaceOfLineSpacing:6.f Kern:1.f Font:defoultFont];
    
    [self setSubViewsFrame];
}
- (UILabel *)titleLab{
    
    if(_titleLab == nil){
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.textColor = TextColor;
        _titleLab.font = defoultFont;
        _titleLab.numberOfLines = 0;
        _titleLab.textAlignment = NSTextAlignmentLeft;
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
- (void)setSubViewsFrame{
    
    [_selectImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.right.equalTo(self.mas_right).offset(-lwb_margin);
        make.centerY.equalTo(self);
    }];
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mas_top);
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-60);
        make.left.equalTo(self.mas_left).offset(lwb_margin);
    }];
}

@end
