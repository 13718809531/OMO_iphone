//
//  OMOFeedbackFootView.m
//  OMO_iphone
//
//  Created by wy on 2018/9/18.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOFeedbackFootView.h"

@interface OMOFeedbackFootView()

@end

@implementation OMOFeedbackFootView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = lwb_margin;
        self.layer.borderWidth = 1.f;
        self.layer.borderColor = mainBackColor.CGColor;
        [self addSubview:self.textView];
    }
    return self;
}
- (OMOCustomTextView *)textView{
    
    if(_textView == nil){
        
        _textView = [[OMOCustomTextView alloc]initWithFrame:CGRectMake(0, lwb_smallMargin, self.lwb_width, self.lwb_height - lwb_margin)];
        _textView.placehText = @"请输入你的建议和意见";
        _textView.textLength = 100;
    }
    return _textView;
}
@end
