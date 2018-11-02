//
//  OMOStoreWeekModel.m
//  OMO_iphone
//
//  Created by wy on 2018/10/22.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOStoreWeekModel.h"

@implementation OMOStoreWeekModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"list":[OMOStoreTimeModel class]};
}

@end

@implementation OMOStoreTimeModel

- (BOOL)status{
    
    if(_msg.length <= 0){
        
        return YES;
    }
    return NO;
}
@end

