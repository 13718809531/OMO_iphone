//
//  OMOKangFuBaoContentAnswerModel.m
//  OMO_iphone
//
//  Created by wy on 2018/10/13.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOKangFuBaoContentAnswerModel.h"

@implementation OMOKangFuBaoContentAnswerModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"levelValue":[OMOKangFuBaoLevelValueModel class]};
}
//- (NSArray<MDKangFuBaoLevelValueModel *> *)nowLevelValue{
//
//    if(self.levelValue.count > 0){
//
//        NSMutableArray *array = [NSMutableArray array];
//
//        for (MDKangFuBaoLevelValueModel *levelValueModel in self.levelValue) {
//
//            NSArray *arr = levelValueModel.nowQuestions;
//            if(arr.count > 0){
//
//                [array addObject:levelValueModel];
//            }
//        }
//        return [NSArray arrayWithArray:array];
//    }
//    return nil;
//}

@end
