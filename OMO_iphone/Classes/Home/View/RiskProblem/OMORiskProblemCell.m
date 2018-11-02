//
//  OMORiskProblemCell.m
//  OMO_iphone
//
//  Created by wy on 2018/9/21.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMORiskProblemCell.h"

@interface OMORiskProblemCell()

@property (nonatomic, strong)UIImageView *selectImg;
@property (nonatomic, strong)UILabel *titleLab;

@end

@implementation OMORiskProblemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.selectImg];
        [self addSubview:self.titleLab];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
//        self.layer.masksToBounds = YES;
//        self.layer.cornerRadius = lwb_margin;
    }
    return self;
}

- (void)setRiskModel:(OMORiskProblemModel *)riskModel{
    
    _riskModel = riskModel;
    
//    if(riskModel.isSlect){
//
//        self.backgroundColor = backColor;
//        _titleLab.textColor = WHITECOLORA(1);
//        _selectImg.image = [UIImage imageNamed:@"Risk_Select"];
//    }else{
//
//        self.backgroundColor = RGB(254, 244, 242);
//        _titleLab.textColor = textColour;
//        _selectImg.image = [UIImage imageNamed:@"Risk_Normal"];
//    }
    
    NSString *text = riskModel.title;
    _titleLab.attributedText = [text setLabelSpaceOfLineSpacing:6.f Kern:1.f Font:defoultFont];
    
    [self setSubViewsFrame];
}

- (UILabel *)titleLab{
    
    if(_titleLab == nil){
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.textColor = TextColor;
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.font = bigFont;
        _titleLab.numberOfLines = -1;
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
    
//    [_selectImg sizeToFit];
//    [_selectImg mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.right.equalTo(self.mas_right).offset(-lwb_margin);
//        make.centerY.equalTo(self);
//    }];
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.mas_right).offset(-60);
        make.left.equalTo(self.mas_left).offset(lwb_margin * 2);
        make.centerY.equalTo(self.mas_centerY);
        make.height.equalTo(self.mas_height);
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
