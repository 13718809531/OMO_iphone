//
//  YXCodeView.h
//  OMO_iphone
//
//  Created by 刘卫兵 on 2018/9/6.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^OMOCodeViewBlock)(NSString *text);

@interface OMOCodeView : UIView

@property(nonatomic,copy)OMOCodeViewBlock CodeBlock;
@property(nonatomic,assign)NSInteger inputNum;//验证码输入个数（4或6个）
- (instancetype)initWithFrame:(CGRect)frame inputType:(NSInteger)inputNum selectCodeBlock:(OMOCodeViewBlock)CodeBlock;

@end
