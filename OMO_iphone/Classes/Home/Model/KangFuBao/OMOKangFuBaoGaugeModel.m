//
//  OMOKangFuBaoGaugeModel.m
//  OMO_iphone
//
//  Created by wy on 2018/10/13.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOKangFuBaoGaugeModel.h"

@implementation OMOKangFuBaoGaugeModel

// 类中的属性匹配特定字符串
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"guaGe_id":@"id"};
}
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"groups":[OMOKangFuBaoGroupsModel class]};
}

@end
