//
//  OMOPingGuTiModel.h
//  OMO_iphone
//
//  Created by wy on 2018/9/28.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OMOPingGuTiOptionModel;

@interface OMOPingGuTiModel : NSObject

@property (nonatomic,copy)NSString *pingGuTi_id;/** 评估题Id */
/** 评估分 */
@property (nonatomic,copy)NSString *score;
/** 诊疗建议 */
@property (nonatomic,copy)NSString *advise;
@property (nonatomic,copy)NSString *type;/** 题目类型,0单选;1多选;2vas题;3图片题 */
@property (nonatomic,copy)NSString *code;/** 题目编号 */
@property (nonatomic,copy)NSString *question_name;/** 题目标题 */
@property (nonatomic,copy)NSString *prompt_text;/**  */
@property (nonatomic,copy)NSString *prompt_resource;/**  */
@property (nonatomic,copy)NSString *image_url;/** 图片 */
@property(strong,nonatomic)NSArray <OMOPingGuTiOptionModel *> *options;
@property (nonatomic,copy)NSString *result_type;/** 1评估题目;2康复包;3转诊;4远程;5弹出提示 */
@property (nonatomic, strong)NSArray *allValues;
/** 矛盾项,多选时会有,后台未设置时为空数组 */
@property (nonatomic, strong)NSArray *contradictOptRules;

@end

@interface OMOPingGuTiOptionModel : NSObject

@property (nonatomic,copy)NSString *name;/** 题目 */
@property (nonatomic,copy)NSString *score;/**  */
@property (nonatomic,copy)NSString *value;/** id */
@property (nonatomic,copy)NSString *url;/** 图片地址 */
@property (nonatomic,assign)BOOL isSelect; /** 是否选中 */
/** 文字题高度 */
@property (nonatomic,assign)CGFloat height;
/** 图片题高度 */
@property (nonatomic,assign)CGFloat imageHeight;

@end
