//
//  OMORemoteBookingModel.h
//  OMO_iphone
//
//  Created by wy on 2018/10/22.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OMORemoteBookingModel : NSObject

/** 预约ID */
@property (nonatomic,copy)NSString *booking_id;
/** 标题   例 ： 颈部疼痛 */
@property (nonatomic,copy)NSString *title;
/** 预约人姓名 */
@property (nonatomic,copy)NSString *realname;
/**  */
@property (nonatomic,copy)NSString *cate_name;
/**  */
@property (nonatomic,copy)NSString *price;
/** 格式：2018-09-10 08：00-09：00 */
@property (nonatomic,copy)NSString *time;
/** 病情描述 */
@property (nonatomic,copy)NSString *consult_question;
/** 状态   1进行中，2已完成，3已拒绝，4已取消 */
@property (nonatomic,copy)NSString *state;
/** 提交时间   格式：2018-10-10 08：23 */
@property (nonatomic,copy)NSString *created;

@end
