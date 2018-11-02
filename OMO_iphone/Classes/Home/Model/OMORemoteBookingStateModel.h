//
//  OMORemoteBookingStateModel.h
//  OMO_iphone
//
//  Created by wy on 2018/10/9.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OMORemoteBookingStateModel : NSObject

//** 时间点 */
@property (nonatomic,copy)NSString *time;
/**
 * parmars
 * 可约次数
 */
@property(nonatomic ,assign)int total;
//** 名称 */
@property (nonatomic,copy)NSString *used;
/**
 * parmars
 * 状态
 */
@property(nonatomic ,assign)BOOL status;

/**
 * parmars
 * 选中状态
 */
@property(nonatomic ,assign)BOOL isSelect;

@end
