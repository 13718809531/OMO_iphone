//
//  OMOBuyDeviceDetailModel.m
//  OMO_iphone
//
//  Created by wy on 2018/10/19.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOBuyDeviceDetailModel.h"

@implementation OMOBuyDeviceDetailModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"mt_order_project":[OMOKangFuBaoMtItemModel class]};
}

@end
