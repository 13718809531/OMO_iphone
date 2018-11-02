//
//  OMOKangFuBaoQuestionsModel.m
//  OMO_iphone
//
//  Created by wy on 2018/10/13.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOKangFuBaoQuestionsModel.h"

@implementation OMOKangFuBaoQuestionsModel

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"options":[OMOKangFuBaoOptionsModel class],@"styles":[OMOKangFuBaoStylesModel class],@"currSelectValues":[OMOKangFuBaoCurrSelectValueModel class]};
}
//- (NSArray<MDKangFuBaoOptionsModel *> *)newOptions{
//
//    if(self.options.count > 0){
//
//        NSMutableArray *array = [NSMutableArray arrayWithArray:[_options allValues]];
//
//        NSMutableArray *models = [MDKangFuBaoOptionsModel mj_objectArrayWithKeyValuesArray:array];
//
//        NSMutableArray *directlyModel = [NSMutableArray array];// 可以直接显示的数据
//        NSMutableArray *matchingModel = [NSMutableArray array];// 需要去匹配显示的数据
//
//        for (int i = 0; i < models.count; i ++) {
//
//            MDKangFuBaoOptionsModel *optionsModel = models[i];
//
//            if(optionsModel.isSelected){
//
//                if(optionsModel.isShowInCondition == NO){
//
//                    if(optionsModel.conditionAnswer.count > 0){
//
//                        [directlyModel addObject:optionsModel];
//                    }
//                }else{
//
//                    if(optionsModel.conditionAnswer.count > 0){
//
//                        [matchingModel addObject:optionsModel];
//                    }else{
//
//                        [directlyModel addObject:optionsModel];
//                    }
//                }
//            }
//        }
//
//        for (int i = 0; i < matchingModel.count; i ++) {
//
//            BOOL bol = YES;
//
//            MDKangFuBaoOptionsModel *optionsModel = matchingModel[i];
//
//            for (int j = 0; j < optionsModel.conditionAnswer.count; j ++) {
//
//                NSArray *oneArr = [MDKangFuBaoOptionConditionAnswerModel mj_objectArrayWithKeyValuesArray:optionsModel.conditionAnswer[j]];
//
//                for (int b = 0; b < oneArr.count; b ++) {
//
//                    MDKangFuBaoOptionConditionAnswerModel *conditionAnswerModel = oneArr[b];
//
//                    NSArray *ids = DATIIDS;
//
//                    for (int k = 0; k < ids.count; k ++) {
//
//                        NSDictionary *dict = ids[k];
//
//                        NSString *ID = dict[@"ID"];
//                        NSString *questionId = conditionAnswerModel.questionId;
//                        if([ID isEqualToString:questionId]){
//
//                            if(![dict[@"selectIds"] isEqualToString:conditionAnswerModel.answerStr]){
//
//                                bol = NO;
//                                break;
//                            }
//                        }
//                    }
//                }
//                if(bol){
//
//                    [directlyModel addObject:optionsModel];
//                }
//            }
//        }
//
//        return [NSArray arrayWithArray:directlyModel];
//    }
//    return nil;
//}

@end
