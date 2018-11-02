//
//  OMOKangFuBaoQuestionsModel.h
//  OMO_iphone
//
//  Created by wy on 2018/10/13.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <Foundation/Foundation.h>
#/**  */
#import "OMOKangFuBaoOptionsModel.h"
/**  */
#import "OMOKangFuBaoStylesModel.h"
/**  */
#import "OMOKangFuBaoResourceModel.h"
/**  */
#import "OMOKangFuBaoGaugeModel.h"
/**  */
#import "OMOKangFuBaoTypeModel.h"
/**  */
#import "OMOKangFuBaoCurrSelectValueModel.h"

@interface OMOKangFuBaoQuestionsModel : NSObject

@property (nonatomic,copy)NSString *question_id;/**  */
@property (nonatomic,copy)NSString *gauge_id;/**  */
@property (nonatomic,copy)NSString *type_id;/**  */
@property (nonatomic,copy)NSString *question_name;/** 名称 */
@property (nonatomic,copy)NSString *state;/**  */
@property (nonatomic,copy)NSString *required;/**  */
@property (nonatomic,copy)NSString *sort;/**  */
@property (nonatomic, strong)NSArray <OMOKangFuBaoOptionsModel *> *options;
@property (nonatomic, strong)NSArray <OMOKangFuBaoStylesModel *> *styles;
@property (nonatomic,copy)NSString *score_logic;/**  */
@property (nonatomic,copy)NSString *prompt;/**  */
@property (nonatomic,copy)NSString *created;/**  */
@property (nonatomic,copy)NSString *resource_id;/**  */
@property (nonatomic, strong)OMOKangFuBaoResourceModel *resource;
@property (nonatomic, strong)OMOKangFuBaoGaugeModel *gauge;
@property (nonatomic, strong)OMOKangFuBaoTypeModel *type;
@property (nonatomic, strong)NSArray <OMOKangFuBaoCurrSelectValueModel *> *currSelectValues;
@property (nonatomic,assign)BOOL optionShow; /**  */

@end
