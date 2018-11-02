//
//  OMOStoreBookingModel.h
//  OMO_iphone
//
//  Created by wy on 2018/10/25.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OMOStoreBookingModel : NSObject

/** 预约ID */
@property (nonatomic,copy)NSString *booking_id;
/** 状态为已接收时显示接收人姓名 */
@property (nonatomic,copy)NSString *admin;
/** 部位id */
@property (nonatomic,copy)NSString *cate_id;
/** 部位名称 */
@property (nonatomic,copy)NSString *cate_name;
/** 预约人姓名 */
@property (nonatomic,copy)NSString *realname;
/** 标题   例：颈部疼痛 */
@property (nonatomic,copy)NSString *title;
/** 门店名称 */
@property (nonatomic,copy)NSString *store_name;
/** 门店电话 */
@property (nonatomic,copy)NSString *store_mobile;
/** 服务方式 */
@property (nonatomic,copy)NSString *service_mode;
/** 预约类型 */
@property (nonatomic,copy)NSString *appointmentType;
/** 预约时间 */
@property (nonatomic,copy)NSString *date;
/** 病情描述 */
@property (nonatomic,copy)NSString *desc;
/** 提交时间 */
@property (nonatomic,copy)NSString *created;
/** 1未接收，2已接收，3已完成，4已取消 */
@property (nonatomic,copy)NSString *state;

@end
