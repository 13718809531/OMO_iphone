//
//  OMOStoreDescCell.m
//  OMO_iphone
//
//  Created by wy on 2018/10/11.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOStoreDescCell.h"

@interface OMOStoreDescCell()

/** 描述文字 */
@property (nonatomic, strong)UILabel *descLab;
/** 描述图片 */
@property (nonatomic, strong)UIImageView *descImg;

@end

@implementation OMOStoreDescCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = WHITECOLORA(1);
    
        [self addSubview:self.descImg];
        [self addSubview:self.descLab];
    }
    return self;
}
- (void)setSowing_mapModel:(OMOStoreSowing_mapModel *)sowing_mapModel{
    
    _sowing_mapModel = sowing_mapModel;
    
    _descLab.attributedText = [sowing_mapModel.desc setLabelSpaceOfLineSpacing:6.f Kern:1.f Font:defoultFont];
    
    [_descImg sd_setImageWithURL:[NSURL URLWithString:sowing_mapModel.url] placeholderImage:[UIImage imageNamed:@""]];
    
    [self setSubViewsFrame];
}
- (void)setSubViewsFrame{
    
    [_descLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(lwb_margin);
        make.right.equalTo(self.mas_right).offset(-lwb_margin * 2);
        make.left.mas_equalTo(self.mas_left).offset(lwb_margin * 2);
        make.height.mas_equalTo(self.sowing_mapModel.titleHeight);
    }];
    
    [_descImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.descLab.mas_bottom).offset(lwb_margin);
        make.left.equalTo(self.mas_left).offset(lwb_margin * 2);
        make.right.equalTo(self.mas_right).offset(-lwb_margin * 2);
        make.bottom.equalTo(self.mas_bottom).offset(-lwb_margin);
    }];
}

- (UIImageView *)descImg{
    
    if(_descImg == nil){
        
        _descImg = [[UIImageView alloc]init];
        _descImg.clipsToBounds = YES;
        _descImg.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _descImg;
}
- (UILabel *)descLab{
    
    if(_descLab == nil){
        
        _descLab = [[UILabel alloc]init];
        _descLab.font = defoultFont;
        _descLab.textColor = textColour;
        _descLab.textAlignment = NSTextAlignmentLeft;
    }
    return _descLab;
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
