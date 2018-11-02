//
//  OMOHomeExclusiveModel.m
//  OMO_iphone
//
//  Created by wy on 2018/10/25.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOHomeExclusiveModel.h"

@implementation OMOHomeExclusiveModel

// 类中的属性匹配特定字符串
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"exclusive_id":@"id"};
}

@end
