//
//  OMOKangFuBaoLevelValueModel.h
//  OMO_iphone
//
//  Created by wy on 2018/10/13.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <Foundation/Foundation.h>
/**  */
#import "OMOKangFuBaoQuestionsModel.h"

@interface OMOKangFuBaoLevelValueModel : NSObject

@property (nonatomic,copy)NSString *name;/**  */
@property (nonatomic, strong)NSArray <OMOKangFuBaoQuestionsModel *> *questions;
//@property (nonatomic, strong)NSArray <MDKangFuBaoQuestionsModel *> *nowQuestions;// 经过处理的数据

@end
