//
//  OMOKangFuBaoTypeModel.m
//  OMO_iphone
//
//  Created by wy on 2018/10/13.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOKangFuBaoTypeModel.h"

@implementation OMOKangFuBaoTypeModel

// 类中的属性匹配特定字符串
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"type_id":@"id"};
}

@end
