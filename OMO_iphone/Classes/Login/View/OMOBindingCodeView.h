//
//  YXCodeView.h
//  OMO_iphone
//
//  Created by 刘卫兵 on 2018/9/6.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YXGetCodeDelegate <NSObject>

- (void)yx_getCode:(UIButton *)sender;

@end

@interface OMOBindingCodeView : UIView

@property(strong,nonatomic)UITextField *codeTfd;// code输入框
@property(strong,nonatomic)UIButton *getCodeBtn;// 获取验证码
@property (weak, nonatomic)id <YXGetCodeDelegate> delegate;

@end
