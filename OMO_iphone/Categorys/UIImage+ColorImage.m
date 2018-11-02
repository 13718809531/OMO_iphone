//
//  UIImage+ColorImage.m
//  CheXiaoPang
//
//  Created by hiko on 14-8-23.
//  Copyright (c) 2014年 wym. All rights reserved.
//

#import "UIImage+ColorImage.h"
//#import "FileMethodBox.h"
//#import "SingletonInfo.h"
//#import "ASIHTTPRequest.h"
//#import "NSString+componets.h"

@implementation UIImage (ColorImage)

+ (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (UIImage *)createImageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
//
//+ (UIImage *)catImageWithUrl:(NSString *)strUrl
//{
//    __block UIImage *imageDe = [[UIImage alloc]initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:GOOD_BACKGROUD_IMAGE ofType:@"png"]];
//    if (![strUrl isEqual:[NSNull null]] && ![strUrl isEqualToString:@"(null)"]) {
//        __block NSString *str = [NSString stringWithFormat:@"%@",strUrl];
//        NSString *photo = [NSString photoName:str];
//        if ([FileMethodBox existCatImage:photo]) {
//            imageDe = [FileMethodBox readCatImage:photo];
//        }else{
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,0), ^(void){
//                NSURL *url = [NSURL URLWithString:str];
//                NSData *data = [[NSData alloc]initWithContentsOfURL:url];
//                if (data != nil) {
//                    [FileMethodBox writeCatImage:data name:photo];
//                    dispatch_async(dispatch_get_main_queue(), ^(void){
//                        imageDe = [UIImage imageWithData:data];
//                    });
//                }
//            });
//            
//        }
//    }
//    return imageDe;
//}

//改变尺寸
- (UIImage *)scaleCarPhotoImage
{
    CGSize size = self.size;
    float scale = 1;
    if (size.width >=size.height && size.width >= 640) {
        scale = size.width/640;
    }else if (size.height > size.width && size.height >= 640){
        scale = size.height/640;
    }
    if (scale > 1) {
        CGSize newsize = CGSizeMake(size.width/scale, size.height/scale);
        UIGraphicsBeginImageContext(newsize);  //size 为CGSize类型，即你所需要的图片尺寸
        [self drawInRect:CGRectMake(0, 0, newsize.width, newsize.height)];
        UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return scaledImage;   //返回的就是已经改变的图片
    }
    return self;
}

- (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

@end
