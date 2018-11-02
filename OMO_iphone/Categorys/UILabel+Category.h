//
//  UILabel+Category.h
//  JXYH
//
//  Created by 刘卫兵 on 2017/12/12.
//  Copyright © 2017年 友惠家(北京)信息科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Category)

- (CGFloat)autoLblWidth;// 返回lable的宽
- (CGFloat)autoLblHeight;// 返回lable的高

//计算UILabel的高度(带有行间距的情况)
- (CGFloat)getLabelHightOfLineSpacing:(CGFloat)lineSpacing Kern:(CGFloat)kern;
//计算UILabel的宽度(带有行间距的情况)
- (CGFloat)getLabelWidthOfLineSpacing:(CGFloat)lineSpacing Kern:(CGFloat)kern;
//给UILabel设置行间距和字间距
- (void)setLabelSpaceOfLineSpacing:(CGFloat)lineSpacing Kern:(CGFloat)kern;

@end
