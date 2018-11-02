//
//  OMOTrainingPlanModel.h
//  OMO_iphone
//
//  Created by wy on 2018/10/19.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OMOTrainResourceModel;

@interface OMOTrainingPlanModel : NSObject

/** id */
@property (nonatomic,copy)NSString *plan_id;
/** 康复包名称 */
@property (nonatomic,copy)NSString *treat_name;
/** 部位 */
@property (nonatomic,copy)NSString *cate_name;
/** 进度 */
@property (nonatomic,copy)NSString *progress;
/** 支付状态 */
@property (nonatomic,copy)NSString *state;
/** 支付描述 */
@property (nonatomic,copy)NSString *state_desc;
/** 标题 */
@property (nonatomic,copy)NSString *title;
/** 训练天数 */
@property (nonatomic,copy)NSString *train_days;
/** 训练时长 */
@property (nonatomic,copy)NSString *train_times;
/** 训练类别名称 */
@property (nonatomic,copy)NSString *type_name;
/** 进度描述 */
@property (nonatomic,copy)NSString *progress_desc;

/**  */
@property (nonatomic, strong)NSArray <OMOTrainResourceModel *> *trainResourceList;

@end

@interface OMOTrainResourceModel : NSObject

/**  */
@property (nonatomic,copy)NSString *question_id;
/** 视频id */
@property (nonatomic,copy)NSString *resource_id;
/** 视频名称 */
@property (nonatomic,copy)NSString *resource_name;
/** 视频路径 */
@property (nonatomic,copy)NSString *url;
/** 时长秒 */
@property (nonatomic,copy)NSString *duration;
/** 占位图 */
@property (nonatomic,copy)NSString *cover_img;
/** 视频描述 */
@property (nonatomic,copy)NSString *video_desc;
/** 当前次数 */
@property (nonatomic,copy)NSString *train_times;
/** 总次数 */
@property (nonatomic,copy)NSString *total_train_times;

@end
