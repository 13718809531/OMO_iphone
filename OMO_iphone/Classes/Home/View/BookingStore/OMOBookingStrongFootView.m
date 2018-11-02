//
//  OMOBookingStrongFootView.m
//  OMO_iphone
//
//  Created by wy on 2018/9/28.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOBookingStrongFootView.h"
#import "OMOCustomTextView.h"

@interface OMOBookingStrongFootView()<UITextViewDelegate>

/**  */
@property (nonatomic, strong)UILabel *titleLab;
@property (nonatomic, strong)OMOCustomTextView *textView;

@end

@implementation OMOBookingStrongFootView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        [self addSubview:self.titleLab];
        [self addSubview:self.textView];
    }
    return self;
}
- (void)setDesc:(NSString *)desc{
    
    _desc = desc;
    
    _textView.text = desc;
}
- (UILabel *)titleLab{
    
    if(_titleLab == nil){
        
        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(lwb_margin * 2, 0, SCREENW - lwb_margin * 4, 40)];
        _titleLab.text = @"病情描述";
        _titleLab.font = [UIFont systemFontOfSize:13];
        _titleLab.textColor = textColour;
        _titleLab.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLab;
}
- (OMOCustomTextView *)textView{
    
    if(_textView == nil){
        
        _textView = [[OMOCustomTextView alloc]initWithFrame:CGRectMake(lwb_margin * 2, 40 + lwb_margin, SCREENW - lwb_margin * 4, self.lwb_height - 40 - lwb_margin * 2)];
        _textView.placehText = @"病情描述";
        _textView.textLength = 100;
        _textView.layer.masksToBounds = YES;
        _textView.layer.cornerRadius = lwb_margin;
        _textView.layer.borderWidth = 1.f;
        _textView.layer.borderColor = DetailColor.CGColor;
        _textView.delegate = self;
    }
    return _textView;
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    
    if(self.endEditing){
        
        self.endEditing(textView.text);
    }
}
@end
