//
//  OMOKangFuBaoModel.h
//  OMO_iphone
//
//  Created by wy on 2018/10/13.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <Foundation/Foundation.h>
/**  */
#import "OMOKangFuBaoPe_ScoreModel.h"
/** 视频,音频,图片 */
#import "OMOKangFuBaoResourceModel.h"
/** 处方包 */
#import "OMOKangFuBaoContentAnswerModel.h"
/** 辅具 */
#import "OMOKangFuBaoMtItemModel.h"
/** 视频 */
#import "OMOKangFuBaoVideoModel.h"

@class OMOKangFuBaoPe_PlanModel;
@class OMOKangFuBaoPe_ResultModel;

@interface OMOKangFuBaoModel : NSObject

@property (nonatomic,copy)NSString *kangFuBao_id;/**  */
/** 得分 */
@property (nonatomic, strong)OMOKangFuBaoPe_ScoreModel *pe_score;
/** 支付订单号 */
@property (nonatomic,copy)NSString *pe_order_id;
/** 康复包价格 */
@property (nonatomic,copy)NSString *treat_price;
/** 优惠后的价格 */
@property (nonatomic,copy)NSString *discount_price;
/** 训练天数 */
@property (nonatomic,copy)NSString *total_level_num;
/** 训练计划 天数 */
@property (nonatomic, strong)OMOKangFuBaoPe_PlanModel *pe_plan;

@property (nonatomic,copy)NSString *cate_id;/**  */
@property (nonatomic,copy)NSString *state;/**  */
/** 康复包名称 */
@property (nonatomic,copy)NSString *treat_name;
@property (nonatomic,copy)NSString *descriptionName;/**  */
@property (nonatomic,copy)NSString *resource_id;/**  */
@property (nonatomic,copy)NSString *updated;/**  */
@property (nonatomic,copy)NSString *created;/**  */
@property (nonatomic,copy)NSString *next_pe_question_id;/**  */
@property (nonatomic, strong)OMOKangFuBaoResourceModel *resource;
@property (nonatomic, strong)NSArray <OMOKangFuBaoContentAnswerModel *> *contentAnswer;
@property (nonatomic, strong)NSArray <OMOKangFuBaoMtItemModel *> *mt_item;
/** 评估结果 */
@property (nonatomic, strong)OMOKangFuBaoPe_ResultModel *pe_result;
/** 评估建议 */
@property (nonatomic, strong)OMOKangFuBaoPe_ResultModel *pe_advise;
/** 视频集合 */
@property (nonatomic, strong)NSArray <OMOKangFuBaoVideoModel *> *videos;

@property (nonatomic,copy)NSString *result_type;/**  */
@property (nonatomic,copy)NSString *image_url;/**  */

@end

@interface OMOKangFuBaoPe_PlanModel : NSObject

/** 标题 */
@property (nonatomic,copy)NSString *title;
/** 天数 */
@property (nonatomic,copy)NSString *total_level_day;
/** 方案 */
@property (nonatomic,copy)NSString *level_day_text_prefix;

@end

@interface OMOKangFuBaoPe_ResultModel : NSObject

/**  */
@property (nonatomic,copy)NSString *title;
/** 根据文字提前计算出高度 */
@property (nonatomic,assign)CGFloat height;
/**  */
@property (nonatomic, strong)NSArray *content;
/** 根据内容整理成自己想要的数据 */
@property (nonatomic, strong)NSArray *newContent;

@end

@interface OMOPe_ResultModel : NSObject

/**  */
@property (nonatomic,copy)NSString *title;
/**  */
@property (nonatomic,assign)CGFloat height;

@end
