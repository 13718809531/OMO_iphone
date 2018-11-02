//
//  UITextField_Custom.m
//  JXYH
//
//  Created by 刘卫兵 on 2017/11/29.
//  Copyright © 2017年. All rights reserved.
//

#import "UITextField_Custom.h"

@interface UITextField_Custom()

@property (nonatomic, assign)NSInteger vd_length;

@end

@implementation UITextField_Custom

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    
    if(action==@selector(paste:))//禁止粘贴
        return NO;
    if(action==@selector(select:))// 禁止选择
        return NO;
    if(action==@selector(selectAll:))// 禁止全选
        return NO;
    return[super canPerformAction:action withSender:sender];
}

- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

#pragma mark - 属性的GET和SET方法

- (LWBTextInputMode)inputMode{
    
    NSString *lang = [self.textInputMode primaryLanguage];
    
    if ([lang isEqualToString:@"zh-Hans"])
        return LWBTextInputModeZh_Hans;
    
    else if ([lang isEqualToString:@"en-US"])
        return LWBTextInputModeEn_US;
    
    return LWBTextFieldModeOther;
}
- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    
    _placeholderColor = placeholderColor;
    
    [self setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
}
- (void)setPlaceholderFont:(UIFont *)placeholderFont{
    
    _placeholderFont = placeholderFont;
    
    [self setValue:placeholderFont forKeyPath:@"_placeholderLabel.font"];
}
- (NSInteger)trueLength{
    
    UITextRange *selectedRange = [self markedTextRange];
    UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
    
    if (!position)
        
        self.vd_length = self.text.length;
    
    return self.vd_length;
    
}
- (void)setMaxLength:(NSInteger)maxLength{
    
    if (maxLength>0&&_maxLength==0) {
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(vdtextFiledEditChanged:)
                                                    name:@"UITextFieldTextDidChangeNotification" object:self];
    }else if (maxLength<=0){
        
        [[NSNotificationCenter defaultCenter]removeObserver:self];
    }
    _maxLength = maxLength;
}

#pragma mark - 方法

-(void)vdtextFiledEditChanged:(NSNotification *)obj{
    
    UITextField_Custom *textField = (UITextField_Custom *)obj.object;
    
    if (textField.trueLength>textField.maxLength) {
        
        textField.text = [textField.text substringToIndex:textField.maxLength];
    }
}

@end
