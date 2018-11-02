//
//  PublicNavgationBar.h
//  JXYH
//
//  Created by 惠发 on 2017/11/23.
//  Copyright © 2017年 友惠家(北京)信息科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PublicNavgationBar : UIView
//底部线
@property (nonatomic,strong) UIView *line;
//标题
@property (nonatomic, strong) UILabel *titleLabel;
//左侧按钮
@property (nonatomic, strong) UIButton *leftButton;
//右侧按钮
@property (nonatomic,strong) UIButton *rightButton;
//添加标题
-(void)addTitltLabelWithText:(NSString *)text Font:(UIFont *)font;
//添加自定义颜色标题
-(void)addTitltLabelWithText:(NSString *)text Font:(UIFont *)font Color:(UIColor *)color;
//添加左侧按钮
-(void)addLeftButtonWithImage:(UIImage *)image;
//添加右侧图片按钮
-(void)addRightButtonWithImage:(UIImage *)image;
//添加右侧cunstom按钮
-(void)addRightButtonWithButton:(UIButton *)button;

@end
