//
//  OMOKangFuBaoOptionsModel.h
//  OMO_iphone
//
//  Created by wy on 2018/10/13.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <Foundation/Foundation.h>
/**  */
#import "OMOKangFuBaoOptionConditionAnswerModel.h"

@interface OMOKangFuBaoOptionsModel : NSObject

@property (nonatomic,copy)NSString *name;/**  */
@property (nonatomic,copy)NSString *value;/**  */
@property (nonatomic,copy)NSString *score;/**  */
@property (nonatomic,assign)BOOL isSelected;/**  */
@property (nonatomic,assign)BOOL isShowInCondition;/**  */
@property (nonatomic, strong)NSArray <OMOKangFuBaoOptionConditionAnswerModel *> *conditionAnswer;

@end
