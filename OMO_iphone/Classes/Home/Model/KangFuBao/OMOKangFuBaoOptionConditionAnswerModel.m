//
//  OMOKangFuBaoOptionConditionAnswerModel.m
//  OMO_iphone
//
//  Created by wy on 2018/10/13.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOKangFuBaoOptionConditionAnswerModel.h"

@implementation OMOKangFuBaoOptionConditionAnswerModel

- (NSString *)answerStr{
    
    if(self.answer.count > 0){
        
        NSArray *array = [self.answer sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            
            return obj1 > obj2;
        }];
        
        return [array componentsJoinedByString:@","];
    }
    return @"";
}

@end
