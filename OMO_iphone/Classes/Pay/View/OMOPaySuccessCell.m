//
//  OMOPaySuccessCell.m
//  OMO_iphone
//
//  Created by wy on 2018/10/19.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOPaySuccessCell.h"

@interface OMOPaySuccessCell()

/**  */
@property (nonatomic, strong)UILabel *detailLab;
/**  */
@property (nonatomic, strong)UILabel *titleLab;

@end

@implementation OMOPaySuccessCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = WHITECOLORA(1);
        
        [self addSubview:self.detailLab];
        [self addSubview:self.titleLab];
    }
    return self;
}
- (void)setDict:(NSDictionary *)dict{
    
    _dict = dict;
    
    _titleLab.text = dict[@"title"];
    
    _detailLab.text = dict[@"detail"];
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat width = (SCREENW - lwb_margin * 6) / 3;
    [_detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-lwb_margin*2);
        make.width.equalTo(@(width * 2));
        make.height.equalTo(self.mas_height);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(lwb_margin * 2);
        make.width.equalTo(@(width));
        make.height.equalTo(self.mas_height);
        make.centerY.equalTo(self.mas_centerY);
    }];
}
- (UILabel *)detailLab{
    
    if(_detailLab == nil){
        
        _detailLab = [[UILabel alloc]init];
        _detailLab.textColor = textColour;
        _detailLab.textAlignment = NSTextAlignmentRight;
        _detailLab.font = bigFont;
        _detailLab.backgroundColor = WHITECOLORA(1);
    }
    return _detailLab;
}
- (UILabel *)titleLab{
    
    if(_titleLab == nil){
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.textColor = textColour;
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.font = bigFont;
    }
    return _titleLab;
}
@end
