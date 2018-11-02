//
//  OMOPayShareSuccessTopView.m
//  OMO_iphone
//
//  Created by wy on 2018/10/18.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOPayShareSuccessTopView.h"

@interface OMOPayShareSuccessTopView()

@property (nonatomic, strong)UIImageView *img;
/**  */
@property (nonatomic, strong)UILabel *titleLab1;
/**  */
@property (nonatomic, strong)UILabel *titleLab2;
/**  */
@property (nonatomic, strong)UILabel *titleLab3;

@end

@implementation OMOPayShareSuccessTopView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        self.backgroundColor = WHITECOLORA(1);
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.lwb_width, lwb_smallMargin)];
        lineView.backgroundColor = mainBackColor;
        [self addSubview:lineView];
        
        [self addSubview:self.img];
        [self addSubview:self.titleLab1];
        [self addSubview:self.titleLab2];
        [self addSubview:self.titleLab3];
    }
    return self;
}
- (void)setPayType:(OMOPaySuccessType)payType{
    
    _payType = payType;
    
    if(_payType == 1){
        
        _titleLab1.text = @"支付成功";
    }else{
        
        _titleLab1.text = @"分享成功";
    }
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREENW * 0.2, SCREENW * 0.2));
        make.centerY.equalTo(self.mas_centerY).offset(-IFFitFloat6(lwb_margin * 4));
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [_titleLab1 sizeToFit];
    [_titleLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.img.mas_bottom).offset(lwb_margin);
    }];
    
    [_titleLab2 sizeToFit];
    [_titleLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.titleLab1.mas_bottom).offset(lwb_margin);
    }];
    
    [_titleLab3 sizeToFit];
    [_titleLab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.titleLab2.mas_bottom).offset(lwb_smallMargin);
    }];
}
- (UIImageView *)img{
    
    if(_img == nil){
        
        _img = [[UIImageView alloc]init];
        _img.contentMode = UIViewContentModeScaleAspectFill;
        _img.image = [UIImage imageNamed:@"Pay_Sccess"];
    }
    return _img;
}
- (UILabel *)titleLab1{
    
    if(_titleLab1 == nil){
        
        _titleLab1 = [[UILabel alloc]init];
        _titleLab1.textColor = textColour;
        _titleLab1.textAlignment = NSTextAlignmentCenter;
        _titleLab1.font = navTitleFont;
    }
    return _titleLab1;
}

- (UILabel *)titleLab2{
    
    if(_titleLab2 == nil){
        
        _titleLab2 = [[UILabel alloc]init];
        _titleLab2.textColor = DetailColor;
        _titleLab2.textAlignment = NSTextAlignmentCenter;
        _titleLab2.font = bigFont;
        _titleLab2.text = @"您成功定制了属于自己的康复方案";
    }
    return _titleLab2;
}
- (UILabel *)titleLab3{
    
    if(_titleLab3 == nil){
        
        _titleLab3 = [[UILabel alloc]init];
        _titleLab3.textColor = DetailColor;
        _titleLab3.textAlignment = NSTextAlignmentCenter;
        _titleLab3.font = bigFont;
        _titleLab3.text = @"马上行动起来吧~~";
    }
    return _titleLab3;
}
@end
