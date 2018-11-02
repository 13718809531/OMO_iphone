//
//  OMOKangFuBaoVideoModel.h
//  OMO_iphone
//
//  Created by wy on 2018/10/15.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <Foundation/Foundation.h>
/** 图片详解 */
#import "OMOKangFuBaoContentModel.h"

@interface OMOKangFuBaoVideoModel : NSObject

/** id */
@property (nonatomic,copy)NSString *video_id;
/** 1:视频,2:音频,3:图片 */
@property (nonatomic,copy)NSString *type;
/** 视频名称 */
@property (nonatomic,copy)NSString *question_name;
/** 1次/日，15分钟/次 */
@property (nonatomic,copy)NSString *options_name;
/** 视频占位图 */
@property (nonatomic,copy)NSString *cover_img;
/** 视频路径 */
@property (nonatomic,copy)NSString *url;
/** 视频介绍 */
@property (nonatomic,copy)NSString *attentions;
/**  */
@property (nonatomic, strong)NSArray <OMOKangFuBaoContentModel *> *content;

@end
