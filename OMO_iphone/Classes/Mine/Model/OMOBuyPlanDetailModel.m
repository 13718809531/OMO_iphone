//
//  OMOBuyPlanDetailModel.m
//  OMO_iphone
//
//  Created by wy on 2018/10/19.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOBuyPlanDetailModel.h"

@implementation OMOBuyPlanDetailModel

+ (NSDictionary *)replacedKeyFromPropertyName{
    
    return @{@"order_id" : @"id"};
}

@end
