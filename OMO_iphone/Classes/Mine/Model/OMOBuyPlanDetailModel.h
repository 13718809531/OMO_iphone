//
//  OMOBuyPlanDetailModel.h
//  OMO_iphone
//
//  Created by wy on 2018/10/19.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OMOBuyPlanDetailModel : NSObject

/**  */
@property (nonatomic,copy)NSString *order_id;
/** 部位 */
@property (nonatomic,copy)NSString *cate;
/** 写死的专业评估。。。 */
@property (nonatomic,copy)NSString *content;
/** 总价 */
@property (nonatomic,copy)NSString *total_price;
/** 实付价 */
@property (nonatomic,copy)NSString *last_price;
/** 优惠价格 */
@property (nonatomic,copy)NSString *discount_price;
/** 订单号 */
@property (nonatomic,copy)NSString *out_trade_no;
/** 支付时间 */
@property (nonatomic,copy)NSString *pay_time;
/** 支付类型 */
@property (nonatomic,copy)NSString *pay_type;
/** 支付状态 1待付款,2已付款 */
@property (nonatomic,copy)NSString *state;

@end
