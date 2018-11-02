//
//  OMOPayTypeCell.m
//  OMO_iphone
//
//  Created by wy on 2018/10/17.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOPayTypeCell.h"

@interface OMOPayTypeCell()

/**  */
@property (nonatomic, strong)UIImageView *typeImg;
/**  */
@property (nonatomic, strong)UILabel *typeLab;
/**  */
@property (nonatomic, strong)UIImageView *selectImg;

@end

@implementation OMOPayTypeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = mainBackColor;
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENW, 2)];
        lineView.backgroundColor = WHITECOLORA(1);
        [self addSubview:lineView];
        
        [self addSubview:self.typeImg];
        [self addSubview:self.typeLab];
        [self addSubview:self.selectImg];
    }
    return self;
}
- (void)setPayType:(OMOPayType)payType{
    
    _payType = payType;
    
    if(payType == 0){
        
        _typeImg.image = [UIImage imageNamed:@"Pay_WeiXin"];
        _typeLab.text = @"微信";
        _selectImg.image = [UIImage imageNamed:@"Pay_Normal"];
    }else{
        
        _typeImg.image = [UIImage imageNamed:@"Pay_Ali"];
        _typeLab.text = @"支付宝";
        _selectImg.image = [UIImage imageNamed:@"Pay_Normal"];
    }
}
- (void)setIsSelect:(BOOL)isSelect{
    
    _isSelect = isSelect;
    
    if(isSelect){
        
        _selectImg.image = [UIImage imageNamed:@"Pay_Select"];
    }else{
        
        _selectImg.image = [UIImage imageNamed:@"Pay_Normal"];
    }
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [_typeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.left.equalTo(self.mas_left).offset(lwb_margin * 2);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [_typeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 30));
        make.left.equalTo(self.typeImg.mas_right).offset(lwb_smallMargin);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [_selectImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.right.equalTo(self.mas_right).offset(-lwb_margin * 2);
        make.centerY.equalTo(self.mas_centerY);
    }];
}
- (UIImageView *)typeImg{
    
    if(_typeImg == nil){
        
        _typeImg = [[UIImageView alloc]init];
    }
    return _typeImg;
}
- (UILabel *)typeLab{
    
    if(_typeLab == nil){
        
        _typeLab = [[UILabel alloc]init];
        _typeLab.textColor = textColour;
        _typeLab.textAlignment = NSTextAlignmentLeft;
        _typeLab.font = bigFont;
    }
    return _typeLab;
}
- (UIImageView *)selectImg{
    
    if(_selectImg == nil){
        
        _selectImg = [[UIImageView alloc]init];
    }
    return _selectImg;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
