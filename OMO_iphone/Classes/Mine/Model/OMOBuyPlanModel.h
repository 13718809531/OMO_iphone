//
//  OMOTrainingModel.h
//  OMO_iphone
//
//  Created by wy on 2018/10/19.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OMOBuyPlanModel : NSObject

/** 购买方案ID */
@property (nonatomic,copy)NSString *pe_order_id;
/** 标题 */
@property (nonatomic,copy)NSString *title;
/** 创建时间 */
@property (nonatomic,copy)NSString *created;
/**  */
@property (nonatomic,copy)NSString *content;
/** 是否购买过 */
@property (nonatomic,copy)NSString *is_buy;

@end
