//
//  OMOFoundSectionHeadView.m
//  OMO_iphone
//
//  Created by 刘卫兵 on 2018/9/10.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOFoundSectionHeadView.h"

@interface OMOFoundSectionHeadView()

@property(strong,nonatomic)UIView *topLineView;
@property(strong,nonatomic)UILabel *titleLab;
@property(strong,nonatomic)UIView *bottomLineView;

@end

@implementation OMOFoundSectionHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        self.backgroundColor = WHITECOLORA(1);
        [self addSubview:self.topLineView];
        [self addSubview:self.titleLab];
        [self addSubview:self.bottomLineView];
    }
    return self;
}
- (UIView *)topLineView{
    
    if(_topLineView == nil){
        
        _topLineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.lwb_width, lwb_smallMargin)];
        _topLineView.backgroundColor = mainBackColor;
    }
    return _topLineView;
}
- (UILabel *)titleLab{
    
    if(_titleLab == nil){
        
        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(lwb_margin, lwb_smallMargin, self.lwb_width, self.lwb_height - lwb_smallMargin - 1)];
        _titleLab.backgroundColor = [UIColor clearColor];
        _titleLab.text = @"合作门店";
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.textColor = textColour;
        _titleLab.font = Font(16);
    }
    return _titleLab;
}
- (UIView *)bottomLineView{
    
    if(_bottomLineView == nil){
        
        _bottomLineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.lwb_height - 1, self.lwb_width, 1)];
        _bottomLineView.backgroundColor = mainBackColor;
    }
    return _bottomLineView;
}
@end
