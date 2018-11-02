//
//  OMOTrainingPlanModel.m
//  OMO_iphone
//
//  Created by wy on 2018/10/19.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOTrainingPlanModel.h"

@implementation OMOTrainingPlanModel

+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"plan_id" : @"id"};
}

@end

@implementation OMOTrainResourceModel

+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"video_desc" : @"description"};
}
@end
