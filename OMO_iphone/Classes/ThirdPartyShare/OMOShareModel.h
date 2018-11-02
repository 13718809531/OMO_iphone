//
//  OMOShareModel.h
//  OMO_iphone
//
//  Created by wy on 2018/10/10.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OMOShareModel : NSObject

@property (nonatomic,copy)NSString *imgUrl;// 图片
@property (nonatomic,copy)NSString *title;// 标题
@property (nonatomic,copy)NSString *content;// 说明
@property (nonatomic,copy)NSString *url;// 链接
@property (nonatomic,copy)NSString *image;// 缩略图
@property (nonatomic,copy)NSString *word;// 文本
@property (nonatomic,copy)NSString *poster;// 海报
@property (nonatomic,assign)double preMoney;// 赚

@end
