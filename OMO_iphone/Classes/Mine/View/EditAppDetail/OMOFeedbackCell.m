//
//  OMOFeedbackCell.m
//  OMO_iphone
//
//  Created by wy on 2018/9/18.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOFeedbackCell.h"

@interface OMOFeedbackCell()

@property (nonatomic,strong)UILabel *userNameLab;

@end

@implementation OMOFeedbackCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = self.lwb_height * 0.5;
        self.layer.borderColor = backColor.CGColor;
        self.layer.borderWidth = 1.f;
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.userNameLab];
    }
    return self;
}
- (void)setFeedBackModel:(OMOFeedBackModel *)feedBackModel{
    
    _feedBackModel = feedBackModel;
    
    _userNameLab.text = feedBackModel.value;
    
    if(feedBackModel.isSelect){
        
        self.backgroundColor = backColor;
    }else{
        
        self.backgroundColor = WHITECOLORA(1);
    }
}
- (UILabel *)userNameLab
{
    if (!_userNameLab) {
        UILabel * label= [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.lwb_width, self.lwb_height)];
        label.font = FontMas(IFFitFloat6(13));
        label.textColor = TextColor;
        label.textAlignment = NSTextAlignmentCenter;
        _userNameLab = label;
    }return _userNameLab;
}

@end
