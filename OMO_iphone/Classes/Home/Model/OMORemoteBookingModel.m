//
//  OMORemoteBookingModel.m
//  OMO_iphone
//
//  Created by wy on 2018/10/22.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMORemoteBookingModel.h"

@implementation OMORemoteBookingModel

+ (NSDictionary *)replacedKeyFromPropertyName{
    
    return @{@"booking_id" : @"id"};
}

@end
