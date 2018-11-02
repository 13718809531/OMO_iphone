//
//  OMOAssessmentCell.m
//  OMO_iphone
//
//  Created by wy on 2018/10/15.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOAssessmentCell.h"

@interface OMOAssessmentCell()

/**  */
@property (nonatomic, strong)UILabel *pointLab;
/**  */
@property (nonatomic, strong)UILabel *titleLab;

@end

@implementation OMOAssessmentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = WHITECOLORA(1);
        
        [self addSubview:self.pointLab];
        [self addSubview:self.titleLab];
    }
    return self;
}
- (void)setModel:(OMOPe_ResultModel *)model{
    
    _model = model;
    
    _titleLab.text = model.title;
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [_pointLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(lwb_margin);
        make.width.equalTo(@(lwb_smallMargin));
        make.top.equalTo(@(18));
        make.height.equalTo(@(lwb_smallMargin));
    }];
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(lwb_margin * 2);
        make.right.equalTo(self.mas_right).offset(-lwb_margin);
        make.height.equalTo(self.mas_height);
        make.centerY.equalTo(self.mas_centerY);
    }];
}
- (UILabel *)pointLab{
    
    if(_pointLab == nil){
        
        _pointLab = [[UILabel alloc]init];
        _pointLab.textColor = textColour;
        _pointLab.textAlignment = NSTextAlignmentCenter;
        _pointLab.font = bigFont;
        _pointLab.backgroundColor = backColor;
        _pointLab.layer.masksToBounds = YES;
        _pointLab.layer.cornerRadius = 2.5f;
    }
    return _pointLab;
}
- (UILabel *)titleLab{
    
    if(_titleLab == nil){
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.textColor = textColour;
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.font = bigFont;
        _titleLab.numberOfLines = 0;
    }
    return _titleLab;
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
