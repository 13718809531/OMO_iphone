//
//  OMOOrderModel.h
//  OMO_iphone
//
//  Created by wy on 2018/10/19.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OMOOrderModel : NSObject

/** 传入的康复包订单ID */
@property (nonatomic,copy)NSString *pe_order_id;
/** 支付商户订单号 */
@property (nonatomic,copy)NSString *out_trade_no;
/** 支付时间 格式2018-09-01 10:12 */
@property (nonatomic,copy)NSString *pay_time;
/** 支付类型 */
@property (nonatomic,copy)NSString *pay_type;
/** 实际付款金额 */
@property (nonatomic,copy)NSString *total_fee;

@end
