//
//  OMOKangFuBaoResourceModel.m
//  OMO_iphone
//
//  Created by wy on 2018/10/13.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOKangFuBaoResourceModel.h"

@implementation OMOKangFuBaoResourceModel

// 类中的属性匹配特定字符串
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"resource_id":@"id",@"resource_description":@"description"};
}
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"content":[OMOKangFuBaoContentModel class]};
}

@end
