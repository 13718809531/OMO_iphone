//
//  OMOClearCacheCell.m
//  OMO_iphone
//
//  Created by wy on 2018/10/30.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOClearCacheCell.h"

@interface OMOClearCacheCell()

@property (nonatomic,strong)UILabel *titleLab;
/**  */
@property (nonatomic, strong)UILabel *sizeLab;

@end

@implementation OMOClearCacheCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        self.backgroundColor = WHITECOLORA(1);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self addSubview:self.titleLab];
        [self addSubview:self.sizeLab];
    }
    return self;
}
- (void)setDict:(NSDictionary *)dict{
    
    _dict = dict;
    
    _titleLab.text = dict[@"fileName"];
    _sizeLab.text = dict[@"fileSize"];
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [_titleLab sizeToFit];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(lwb_margin * 2);
        make.centerY.equalTo(self.mas_centerY);
        make.width.mas_equalTo(self.lwb_width * 0.5 - lwb_margin * 3);
    }];
    
    [_sizeLab sizeToFit];
    [_sizeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.mas_right).offset(-lwb_margin * 5);
        make.centerY.equalTo(self.mas_centerY);
        make.width.mas_equalTo(self.lwb_width * 0.5 - lwb_margin * 8);
    }];
}
- (UILabel *)titleLab
{
    if (!_titleLab) {
        UILabel * label= [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.lwb_width, self.lwb_height)];
        label.font = bigFont;
        label.textColor = TextColor;
        label.textAlignment = NSTextAlignmentLeft;
        _titleLab = label;
    }return _titleLab;
}

- (UILabel *)sizeLab
{
    if (!_sizeLab) {
        UILabel * label= [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.lwb_width, self.lwb_height)];
        label.font = defoultFont;
        label.textColor = DetailColor;
        label.textAlignment = NSTextAlignmentRight;
        _sizeLab = label;
    }return _sizeLab;
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
