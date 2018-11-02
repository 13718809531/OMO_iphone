//
//  UITextField_Custom.h
//  JXYH
//
//  Created by 刘卫兵 on 2017/11/29.
//  Copyright © 2017年. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LWBTextInputMode){
    LWBTextInputModeZh_Hans = 0,
    LWBTextInputModeEn_US,
    LWBTextFieldModeOther
};

/**
 使用须知：此文本框禁止复制，粘贴和选择功能
 */
@interface UITextField_Custom : UITextField

- (instancetype)init;
- (instancetype)initWithFrame:(CGRect)frame;

/**
 输入类型
 */
@property (nonatomic, assign,readonly)LWBTextInputMode inputMode;

/**
 占位符的颜色
 */
@property (nonatomic, strong)UIColor *placeholderColor;

/**
 占位符的字体
 */
@property (nonatomic, strong)UIFont *placeholderFont;

/**
 真实长度（不计算高亮部分）
 */
@property (nonatomic, assign)NSInteger trueLength;
/**
 设置最大长度
 @warning 此值必须大于零
 */
@property (nonatomic, assign)NSInteger maxLength;

@end
