//
//  OMOHomeExclusiveCell.m
//  OMO_iphone
//
//  Created by wy on 2018/10/25.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOHomeExclusiveCell.h"

@interface OMOHomeExclusiveCell()

/**  */
@property (nonatomic, strong)UIImageView *coverImg;
/**  */
@property (nonatomic, strong)UILabel *titleLab;
/**  */
@property (nonatomic, strong)UILabel *clickLab;

@end

@implementation OMOHomeExclusiveCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        self.backgroundColor = [UIColor redColor];
        [self addSubview:self.coverImg];
        [self addSubview:self.titleLab];
        [self addSubview:self.clickLab];
    }
    return self;
}
- (void)setExclusiveModel:(OMOHomeExclusiveModel *)exclusiveModel{
    
    _exclusiveModel = exclusiveModel;
    
    [_coverImg sd_setImageWithURL:[NSURL URLWithString:exclusiveModel.cover_img] placeholderImage:[UIImage imageNamed:@""]];
    
    _titleLab.text = exclusiveModel.item_name;
    
    _clickLab.text = [NSString stringWithFormat:@"%@人点击",exclusiveModel.click_time];
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [_coverImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        make.top.equalTo(self.mas_top);
    }];
    
    [_titleLab sizeToFit];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(lwb_margin);
        make.right.equalTo(self.mas_right).offset(lwb_margin);
        make.top.equalTo(self.mas_top).offset(lwb_margin);
    }];
    
    [_clickLab sizeToFit];
    [_clickLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(lwb_margin);
        make.right.equalTo(self.mas_right).offset(lwb_margin);
        make.top.equalTo(self.titleLab.mas_bottom).offset(lwb_margin);
    }];
}
- (UIImageView *)coverImg{
    
    if(_coverImg == nil){
        
        _coverImg = [[UIImageView alloc]init];
        _coverImg.clipsToBounds = YES;
        _coverImg.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _coverImg;
}
- (UILabel *)titleLab{
    
    if(_titleLab == nil){
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.textColor = textColour;
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.font = Font(18);
    }
    return _titleLab;
}
- (UILabel *)clickLab{
    
    if(_clickLab == nil){
        
        _clickLab = [[UILabel alloc]init];
        _clickLab.textColor = DetailColor;
        _clickLab.textAlignment = NSTextAlignmentLeft;
        _clickLab.font = bigFont;
    }
    return _clickLab;
}

@end
