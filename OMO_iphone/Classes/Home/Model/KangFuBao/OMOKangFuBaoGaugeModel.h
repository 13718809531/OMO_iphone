//
//  OMOKangFuBaoGaugeModel.h
//  OMO_iphone
//
//  Created by wy on 2018/10/13.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <Foundation/Foundation.h>
/**  */
#import "OMOKangFuBaoGroupsModel.h"

@interface OMOKangFuBaoGaugeModel : NSObject

@property (nonatomic,copy)NSString *guaGe_id;/**  */
@property (nonatomic,copy)NSString *type_id;/**  */
@property (nonatomic,copy)NSString *gauge_name;/**  */
@property (nonatomic,copy)NSString *state;/**  */
@property (nonatomic,copy)NSString *sort;/**  */
@property (nonatomic, strong)NSDictionary *score_rule;
@property (nonatomic, strong)NSArray <OMOKangFuBaoGroupsModel *> *groups;
@property (nonatomic,copy)NSString *created;/**  */
@property (nonatomic,copy)NSString *code;/**  */

@end
