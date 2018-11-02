//
//  OMOKangFuBaoContentAnswerModel.h
//  OMO_iphone
//
//  Created by wy on 2018/10/13.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <Foundation/Foundation.h>
/**  */
#import "OMOKangFuBaoLevelValueModel.h"

@interface OMOKangFuBaoContentAnswerModel : NSObject

@property (nonatomic,copy)NSString *levelName;/** 阶段 */
@property (nonatomic,copy)NSString *levelDay;/** 间隔天数 */
@property (nonatomic,copy)NSString *levelNum;/** 共多少 */
@property (nonatomic,copy)NSString *practiced_num;/** 已完成的ci'shu*/

@property (nonatomic, strong)NSArray <OMOKangFuBaoLevelValueModel *> *levelValue;
//@property (nonatomic, strong)NSArray <MDKangFuBaoLevelValueModel *> *nowLevelValue;

@end
