//
//  UIColor+Extension.h
//  FunTown
//
//  Created by 王帅 on 16/8/29.
//  Copyright © 2016年 Tony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extension)

/**
 *  十六进制字符串转成color
 *
 *  @param color @"#666666"| @"0x666666" | @"666666"
 *
 *  @return UIColor
 */
+ (UIColor *) colorWithHexString: (NSString *)color;

/**
 *  十六进制值转成color
 *
 *  @param hex 0x666666
 *
 *  @return UIColor
 */
+ (UIColor *) colorWithHexValue:(NSUInteger)hex;
+ (UIColor *) colorWithHexValue:(NSUInteger)hex alpha:(CGFloat)alpha;

@end
