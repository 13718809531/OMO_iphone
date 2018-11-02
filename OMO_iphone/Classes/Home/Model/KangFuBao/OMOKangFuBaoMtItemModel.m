//
//  OMOKangFuBaoMtItemModel.m
//  OMO_iphone
//
//  Created by wy on 2018/10/13.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOKangFuBaoMtItemModel.h"

@implementation OMOKangFuBaoMtItemModel

// 类中的属性匹配特定字符串
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"item_id":@"id"};
}

@end
