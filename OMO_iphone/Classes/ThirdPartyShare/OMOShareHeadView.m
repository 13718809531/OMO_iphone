//
//  OMOShareHeadCollectionReusableView.m
//  OMO_iphone
//
//  Created by wy on 2018/10/10.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOShareHeadView.h"

@interface OMOShareHeadView()

@property(strong,nonatomic)UILabel *titleLable1;
@property(strong,nonatomic)UILabel *titleLable2;
@property(strong,nonatomic)UILabel *titleLable3;

@end

@implementation OMOShareHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.titleLable1];
        [self addSubview:self.titleLable2];
        [self addSubview:self.titleLable3];
    }
    return self;
}
- (UILabel *)titleLable1{
    
    if(_titleLable1 == nil){
        
        _titleLable1 = [[UILabel alloc]init];
        _titleLable1.textColor = textLightColour;
        _titleLable1.textAlignment = NSTextAlignmentCenter;
        _titleLable1.font = [UIFont systemFontOfSize:20];
    }
    return _titleLable1;
}
- (UILabel *)titleLable2{
    
    if(_titleLable2 == nil){
        
        _titleLable2 = [[UILabel alloc]init];
        _titleLable2.textColor = textColour;
        _titleLable2.textAlignment = NSTextAlignmentCenter;
        _titleLable2.text = @"你的好友通过你的链接购买此商品";
        _titleLable2.font = [UIFont systemFontOfSize:14];
    }
    return _titleLable2;
}
- (UILabel *)titleLable3{
    
    if(_titleLable3 == nil){
        
        _titleLable3 = [[UILabel alloc]init];
        _titleLable3.textColor = textColour;
        _titleLable3.textAlignment = NSTextAlignmentCenter;
        _titleLable3.font = [UIFont systemFontOfSize:14];
    }
    return _titleLable3;
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self.titleLable1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(25);
        make.left.equalTo(self.mas_left);
        make.height.equalTo(@(20));
        make.right.equalTo(self.mas_right);
    }];
    
    [self.titleLable2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLable1.mas_bottom).offset(15);
        make.left.equalTo(self.mas_left);
        make.height.equalTo(@(14));
        make.right.equalTo(self.mas_right);
    }];
    
    [self.titleLable3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLable2.mas_bottom).offset(8);
        make.left.equalTo(self.mas_left);
        make.height.equalTo(@(14));
        make.right.equalTo(self.mas_right);
    }];
}
- (void)setMakePrice:(NSString *)makePrice{
    
    _makePrice = makePrice;
    _titleLable1.text = [NSString stringWithFormat:@"赚%@元",makePrice];
    _titleLable3.text = [NSString stringWithFormat:@"你就能赚到%@元",makePrice];
}
@end
