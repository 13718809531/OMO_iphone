//
//  WTShareContentItem.h
//  OMO_iphone
//
//  Created by wy on 2018/10/10.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WTShareContentItem : NSObject

@property (strong, nonatomic) UIImage *thumbImage;//缩略图 1
@property (strong, nonatomic) UIImage *bigImage;//大图 1
@property (nonatomic ,copy) NSString *content;// 详情
@property (strong, nonatomic) NSString *imageType;
@property (strong, nonatomic) NSString *title;//标题 1
@property (nonatomic,copy)NSString *wxUrlString;

@property (strong, nonatomic) NSString *weixinPyqtitle;
@property (strong, nonatomic) NSString *qqTitle;

@property (strong, nonatomic) NSString *urlString;//链接地址 1
@property (strong, nonatomic) NSString *urlImageString;// QQ,QQ空间分享加载图片用的
@property (strong, nonatomic) NSURL *url;
@property (strong, nonatomic) NSString *summary;//子标题 1
@property (strong, nonatomic) NSString *type;

@property (nonatomic, assign)BOOL isImageShareQQ; // yes 代表用图片 NO代表用URL
@property (nonatomic, strong)NSString * sinaSummary;//微博标题 2


+ (WTShareContentItem *)shareWTShareContentItem;

@end
