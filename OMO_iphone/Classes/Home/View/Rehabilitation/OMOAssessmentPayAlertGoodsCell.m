//
//  OMOAssessmentPayAlertGoodsCell.m
//  OMO_iphone
//
//  Created by wy on 2018/10/16.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOAssessmentPayAlertGoodsCell.h"

@interface OMOAssessmentPayAlertGoodsCell()

@property (strong, nonatomic)UIImageView *urlImg;// 图片
@property (strong, nonatomic)UILabel *titleName;// 标题
@property(strong,nonatomic)UILabel *currentPrice;// 现价

@end

@implementation OMOAssessmentPayAlertGoodsCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        [self addSubview:self.urlImg];
        [self addSubview:self.titleName];
        [self addSubview:self.currentPrice];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)setMtItemModel:(OMOKangFuBaoMtItemModel *)mtItemModel{
    
    _mtItemModel = mtItemModel;
    
    [self.urlImg sd_setImageWithURL:[NSURL URLWithString:mtItemModel.url] placeholderImage:[UIImage imageNamed:@""]];

    _titleName.text = mtItemModel.name;
    
    _currentPrice.text = [NSString stringWithFormat:@"¥%@",mtItemModel.unit_price];
    
    [self setSubViewsFrame];
}
#pragma mark -------设置subViewsFrame --------
- (void)setSubViewsFrame{
    
    [_urlImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(self.lwb_height - 40);
    }];
    
    [_titleName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.urlImg.mas_bottom).offset(7);
        make.left.equalTo(self.mas_left);
        make.width.mas_equalTo(self.lwb_width * 0.5);
        make.height.mas_equalTo(40);
    }];
    
    [_currentPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.urlImg.mas_bottom).offset(7);
        make.right.equalTo(self.mas_right);
        make.width.mas_equalTo(self.lwb_width * 0.5);
        make.height.mas_equalTo(40);
    }];
}
- (UIImageView *)urlImg{
    
    if(_urlImg == nil){
        
        _urlImg = [[UIImageView alloc]init];
        _urlImg.clipsToBounds = YES;
        _urlImg.contentMode = UIViewContentModeScaleAspectFit;
        _urlImg.image = [UIImage imageNamed:@""];
        _urlImg.backgroundColor = backColor;
    }
    return _urlImg;
}
- (UILabel *)titleName{
    
    if(_titleName == nil){
        
        _titleName = [[UILabel alloc]init];
        _titleName.textColor = textColour;
        _titleName.textAlignment = NSTextAlignmentLeft;
        _titleName.font = defoultFont;
    }
    return _titleName;
}

- (UILabel *)currentPrice{
    
    if(_currentPrice == nil){
        
        _currentPrice = [[UILabel alloc]init];
        _currentPrice.textColor = textLightColour;
        _currentPrice.textAlignment = NSTextAlignmentRight;
        _currentPrice.font = defoultFont;
    }
    return _currentPrice;
}

@end
