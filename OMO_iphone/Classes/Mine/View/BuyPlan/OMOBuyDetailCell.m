//
//  OMOBuyDetailCell.m
//  OMO_iphone
//
//  Created by wy on 2018/10/20.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOBuyDetailCell.h"

@interface OMOBuyDetailCell()

/**  */
@property (nonatomic, strong)UILabel *titleLab;

@end

@implementation OMOBuyDetailCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        self.backgroundColor = WHITECOLORA(1);
        [self addSubview:self.titleLab];
    }
    return self;
}
- (void)setDict:(NSDictionary *)dict{
    
    _dict = dict;
    
    NSString *str = [NSString stringWithFormat:@"%@:%@",dict[@"title"],dict[@"detail"]];
    _titleLab.text = str;
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(lwb_margin * 2);
        make.right.equalTo(self.mas_right).offset(-lwb_margin * 2);
        make.height.equalTo(self.mas_height);
        make.centerY.equalTo(self.mas_centerY);
    }];
}

- (UILabel *)titleLab{
    
    if(_titleLab == nil){
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.textColor = RGB(180, 180, 180);
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.font = bigFont;
    }
    return _titleLab;
}

@end
