//
//  OMOBuyGoodsTitleCell.m
//  OMO_iphone
//
//  Created by wy on 2018/10/9.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOBuyGoodsTitleCell.h"

@interface OMOBuyGoodsTitleCell()

/**  */
@property (nonatomic, strong)UILabel *titleLab;

@end

@implementation OMOBuyGoodsTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        self.backgroundColor = WHITECOLORA(1);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.titleLab];
    }
    return self;
}
- (UILabel *)titleLab{
    
    if(_titleLab == nil){
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.text = @"康复辅具";
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.textColor = textColour;
        _titleLab.font = BoldFont(22);
        [_titleLab sizeToFit];
        _titleLab.lwb_x = lwb_margin;
        _titleLab.lwb_centerY = self.lwb_centerY;
    }
    return _titleLab;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
