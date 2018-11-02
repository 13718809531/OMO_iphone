//
//  OMOKangFuBaoLevelValueModel.m
//  OMO_iphone
//
//  Created by wy on 2018/10/13.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOKangFuBaoLevelValueModel.h"

@implementation OMOKangFuBaoLevelValueModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"questions":[OMOKangFuBaoQuestionsModel class]};
}
//- (NSArray<MDKangFuBaoQuestionsModel *> *)nowQuestions{
//
//    if(self.questions.count > 0){
//
//        NSMutableArray *newQuestions = [NSMutableArray array];
//
//        for (MDKangFuBaoQuestionsModel *questionModel in self.questions) {
//
//            if(questionModel.newOptions.count > 0){
//
//                [newQuestions addObject:questionModel];
//            }
//        }
//        return [NSArray arrayWithArray:newQuestions];
//    }
//    return nil;
//}

@end
