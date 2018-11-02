//
//  OMOBuyPoint_RulesModel.h
//  OMO_iphone
//
//  Created by wy on 2018/10/17.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OMOBuyPoint_RulesModel : NSObject

/** 积分 */
@property (nonatomic,copy)NSString *point;
/** desc */
@property (nonatomic,copy)NSString *point_desc;
/** 抵扣款 */
@property (nonatomic,copy)NSString *discount_price;

@end
