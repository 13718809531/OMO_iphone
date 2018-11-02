//
//  UIImage+ColorImage.h
//  CheXiaoPang
//
//  Created by hiko on 14-8-23.
//  Copyright (c) 2014年 wym. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ColorImage)

+ (UIImage *)createImageWithColor:(UIColor *)color;

+ (UIImage *)createImageWithColor:(UIColor *)color size:(CGSize)size;

//+ (UIImage *)catImageWithUrl:(NSString *)strUrl;

- (UIImage *)scaleCarPhotoImage;

- (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;
@end
