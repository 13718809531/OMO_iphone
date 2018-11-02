//
//  OMOSelectPartsCell.m
//  OMO_iphone
//
//  Created by wy on 2018/9/14.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOSelectPartsCell.h"

@interface OMOSelectPartsCell()

@property (nonatomic, strong)UIImageView *backImg;
/**  */
@property (nonatomic, strong)UILabel *titleLab;
/**  */
@property (nonatomic, strong)UIView *line2;

@end

@implementation OMOSelectPartsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.backImg];
        [self addSubview:self.titleLab];
        
        UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.lwb_width, 2)];
        line1.backgroundColor = mainBackColor;
        [self addSubview:line1];
        
        [self addSubview:self.line2];
    }
    return self;
}
- (void)setPartsModel:(OMOSelectPartsModel *)partsModel{
    
    _partsModel = partsModel;
    
    if(partsModel.select){
        
        self.backImg.image = [UIImage imageNamed: [NSString stringWithFormat:@"Click_%@",partsModel.imgName]];
        self.backgroundColor = RGB(235, 103, 78);
        _titleLab.textColor = WHITECOLORA(1);
    }else{
        
        UIImage *image = [UIImage imageNamed: [NSString stringWithFormat:@"Normal_%@",partsModel.imgName]];
        self.backImg.image = image;
        self.backgroundColor = WHITECOLORA(1);
        _titleLab.textColor = textColour;
    }
    
    _titleLab.text = partsModel.cate_name;
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [_backImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mas_top).offset(lwb_smallMargin);
        make.left.equalTo(self.mas_left).offset(IFFitFloat6(lwb_margin * 2));
        make.bottom.equalTo(self.mas_bottom).offset(-lwb_smallMargin);
        make.width.equalTo(@(self.lwb_height - lwb_margin));
    }];
    
    [_titleLab sizeToFit];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.backImg.mas_right).offset(lwb_margin * 2);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        make.width.equalTo(@(2));
    }];
}
- (UIImageView *)backImg{
    
    if(_backImg == nil){
        
        _backImg = [[UIImageView alloc]init];
        _backImg.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _backImg;
}
- (UILabel *)titleLab{
    
    if(_titleLab == nil){
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.textColor = textColour;
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.font = bigFont;
    }
    return _titleLab;
}
- (UIView *)line2{
    
    if(_line2 == nil){
        
        _line2 = [[UIView alloc]init];
        _line2.backgroundColor = mainBackColor;
    }
    return _line2;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
