//
//  OMOBuyDeviceDetailModel.h
//  OMO_iphone
//
//  Created by wy on 2018/10/19.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <Foundation/Foundation.h>
/**  */
#import "OMOKangFuBaoMtItemModel.h"

@interface OMOBuyDeviceDetailModel : NSObject

/** 辅具订单ID */
@property (nonatomic,copy)NSString *mt_order_id;
/** 标题 */
@property (nonatomic,copy)NSString *title;
/** 收货地址 */
@property (nonatomic,copy)NSString *address;
/** 收货人姓名 */
@property (nonatomic,copy)NSString *name;
/** 收货人手机号 */
@property (nonatomic,copy)NSString *mobile;
/** 订单辅具数组 */
@property (nonatomic, strong)NSArray <OMOKangFuBaoMtItemModel *> *mt_order_project;
/** 订单号 */
@property (nonatomic,copy)NSString *out_trade_no;
/** 支付时间 */
@property (nonatomic,copy)NSString *pay_time;
/** 支付类型 */
@property (nonatomic,copy)NSString *pay_type;
/** 实付价 */
@property (nonatomic,copy)NSString *last_price;
/**
*
* 订单状态,1待付款,2已付款未发货,3待收货,4已完成,5已取消
*
*/
/** 状态 */
@property (nonatomic,copy)NSString *state;

@end

