//
//  OMORemoteBookingWeekModel.h
//  OMO_iphone
//
//  Created by wy on 2018/10/9.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OMORemoteBookingWeekModel : NSObject

@property (nonatomic,copy)NSString *dateStr;//** 时间 */
@property (nonatomic,copy)NSString *weekStr;//** 周几 */
/**
 * parmars
 *
 */
@property(nonatomic ,assign)NSInteger weekIndex;
/**
 * parmars
 * 选中状态
 */
@property(nonatomic ,assign)BOOL isSelect;

@end
