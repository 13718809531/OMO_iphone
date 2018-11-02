//
//  OMOAssessmentPayAlertHeadView.m
//  OMO_iphone
//
//  Created by wy on 2018/10/16.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOAssessmentPayAlertHeadView.h"

@interface OMOAssessmentPayAlertHeadView()

@property(strong,nonatomic)UILabel *titleLab;

@end

@implementation OMOAssessmentPayAlertHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.titleLab];
    }
    return self;
}
- (UILabel *)titleLab{
    
    if(_titleLab == nil){
        
        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(lwb_margin * 2, 0, self.lwb_width - lwb_margin * 4, self.lwb_height)];
        _titleLab.textColor = textColour;
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.font = BoldFont(18);
        _titleLab.text = @"推荐训练道具";
    }
    return _titleLab;
}

@end
