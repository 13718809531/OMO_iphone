//
//  OMOKangFuBaoOptionConditionAnswerModel.h
//  OMO_iphone
//
//  Created by wy on 2018/10/13.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OMOKangFuBaoOptionConditionAnswerModel : NSObject

@property (nonatomic,copy)NSString *questionId;/**  */
@property (nonatomic,copy)NSString *questionCateId;/**  */
@property (nonatomic,copy)NSString *questionName;/**  */
@property (nonatomic,copy)NSString *questionCateName;/**  */
@property (nonatomic,copy)NSString *type;/**  */
@property (nonatomic,copy)NSString *optionName;/**  */
@property (nonatomic, strong)NSArray <NSString *> *answer;
@property (nonatomic,copy)NSString *answerStr;/**  */

@end
