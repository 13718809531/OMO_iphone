//
//  OMOShareCollectionViewCell.m
//  OMO_iphone
//
//  Created by wy on 2018/10/10.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOShareCollectionViewCell.h"

@interface OMOShareCollectionViewCell()

@property(strong,nonatomic)UIImageView *customImageView;
@property(strong,nonatomic)UILabel *customTitleLable;

@end

@implementation OMOShareCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.customImageView];
        [self addSubview:self.customTitleLable];
    }
    return self;
}
- (UIImageView *)customImageView{
    
    if(_customImageView == nil){
        
        _customImageView = [[UIImageView alloc]init];
    }
    
    return _customImageView;
}
- (UILabel *)customTitleLable{
    
    if(_customTitleLable == nil){
        
        _customTitleLable = [[UILabel alloc]init];
        _customTitleLable.textAlignment = NSTextAlignmentCenter;
        _customTitleLable.font = [UIFont systemFontOfSize:14];
        _customTitleLable.textColor = RGB(50, 50, 50);
    }
    return _customTitleLable;
}

- (void)setDict:(NSDictionary *)dict{
    
    _dict = dict;
    
    self.customImageView.image = [UIImage imageNamed:dict[@"image"]];
    
    self.customTitleLable.text = dict[@"title"];
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [_customImageView sizeToFit];
    [_customImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(10);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [_customTitleLable sizeToFit];
    [_customTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.customImageView.mas_bottom).offset(10);
        make.centerX.equalTo(self.mas_centerX);
    }];
}
@end
