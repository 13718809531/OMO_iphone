//
//  UIView+Code.h
//  OMO_iphone
//
//  Created by wy on 2018/9/30.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Code)

@property (nonatomic) IBInspectable CGFloat cornerRadius;

/** 头像圆角 */
@property (nonatomic) IBInspectable BOOL avatarCorner;

/** 边框 */
@property (nonatomic) IBInspectable CGFloat borderWidth;

/** 边框颜色*/
@property (nonatomic, strong) IBInspectable UIColor *borderColor;

+ (__kindof UIView *)MQLoadNibView;
- (void)MQSetViewCircleWithBorderWidth:(CGFloat) width andColor:(UIColor *)borColor;
- (void)MQViewSetCornerRadius:(CGFloat)radius;

@end
