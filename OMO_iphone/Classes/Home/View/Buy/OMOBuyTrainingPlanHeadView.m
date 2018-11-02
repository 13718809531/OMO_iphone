//
//  OMOBuyTrainingPlanHeadView.m
//  OMO_iphone
//
//  Created by wy on 2018/10/17.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOBuyTrainingPlanHeadView.h"

@interface OMOBuyTrainingPlanHeadView()

/**  */
@property (nonatomic, strong)UILabel *titleLab;

@end

@implementation OMOBuyTrainingPlanHeadView

- (instancetype)init{
    
    if(self = [super init]){
        
        self.backgroundColor = WHITECOLORA(1);
        self.frame = CGRectMake(0, 0, SCREENW, IFFitFloat6(80));
        [self addSubview:self.titleLab];
    }
    return self;
}
- (void)setTitle:(NSString *)title{
    
    _title = title;
    
    _titleLab.text = title;
}
- (UILabel *)titleLab{
    
    if(_titleLab == nil){
        
        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(lwb_margin * 2, self.lwb_height * 0.5, self.lwb_width - lwb_margin * 4, self.lwb_height * 0.5)];
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.textColor = textColour;
        _titleLab.font = BoldFont(18);
    }
    return _titleLab;
}
@end
