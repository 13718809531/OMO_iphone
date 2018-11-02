//
//  UIView+Category.h
//  YXKF_ipad
//
//  Created by wy on 2018/7/18.
//  Copyright © 2018年 元新康复. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Category)

@property (nonatomic, assign) CGSize lwb_size;
@property (nonatomic, assign) CGFloat lwb_width;
@property (nonatomic, assign) CGFloat lwb_height;
@property (nonatomic, assign) CGFloat lwb_x;
@property (nonatomic, assign) CGFloat lwb_y;
@property (nonatomic, assign) CGFloat lwb_centerX;
@property (nonatomic, assign) CGFloat lwb_centerY;

@property (nonatomic, assign) CGFloat lwb_right;
@property (nonatomic, assign) CGFloat lwb_bottom;

@property CGPoint origin;
@property CGSize size;

@property (readonly) CGPoint bottomLeft;
@property (readonly) CGPoint bottomRight;
@property (readonly) CGPoint topRight;

@property CGFloat height;
@property CGFloat width;

@property CGFloat top;
@property CGFloat left;

@property CGFloat bottom;
@property CGFloat right;

- (void) moveBy: (CGPoint) delta;
- (void) scaleBy: (CGFloat) scaleFactor;
- (void) fitInSize: (CGSize) aSize;

- (void)cornerRadius:(CGFloat)radius;

@end
