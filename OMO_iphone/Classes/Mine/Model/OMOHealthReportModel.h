//
//  OMOHealthReportModel.h
//  OMO_iphone
//
//  Created by wy on 2018/10/22.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OMOHealthReportModel : NSObject

/** 健康报告ID */
@property (nonatomic,copy)NSString *report_id;
/** 健康报告标题 */
@property (nonatomic,copy)NSString *title;
/** 评估时间 */
@property (nonatomic,copy)NSString *created;
/** 1:未购买,2:已支付 */
@property (nonatomic,copy)NSString *state;

@end
