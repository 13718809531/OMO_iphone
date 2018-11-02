//
//  UIButton+Category.h
//  JXYH
//
//  Created by 刘卫兵 on 2017/11/29.
//  Copyright © 2017年 友惠家(北京)信息科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MKButtonEdgeInsetsStyle) {
    MKButtonEdgeInsetsStyleTop, // image在上，label在下
    MKButtonEdgeInsetsStyleLeft, // image在左，label在右
    MKButtonEdgeInsetsStyleBottom, // image在下，label在上
    MKButtonEdgeInsetsStyleRight // image在右，label在左
};

@interface UIButton (Category)

/** * 设置button的titleLabel和imageView的布局样式，及间距 * * @param style titleLabel和imageView的布局样式 * @param space titleLabel和imageView的间距 */
- (void)layoutButtonWithEdgeInsetsStyle:(MKButtonEdgeInsetsStyle)style imageTitleSpace:(CGFloat)space;

@end
