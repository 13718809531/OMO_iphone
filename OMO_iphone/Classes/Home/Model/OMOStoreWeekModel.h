//
//  OMOStoreWeekModel.h
//  OMO_iphone
//
//  Created by wy on 2018/10/22.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OMOStoreTimeModel;
@interface OMOStoreWeekModel : NSObject

/** 星期 */
@property (nonatomic,copy)NSString *week;
/** 时间 */
@property (nonatomic,copy)NSString *time;
/**  */
@property (nonatomic, strong)NSArray <OMOStoreTimeModel *> *list;
/** 是否选中 */
@property (nonatomic,assign)BOOL isSelect;

@end

@interface OMOStoreTimeModel : NSObject

/** 时间 */
@property (nonatomic,copy)NSString *time;
/** 信息 */
@property (nonatomic,copy)NSString *msg;
/** 是否选中 */
@property (nonatomic,assign)BOOL isSelect;
/** 是否可约 */
@property (nonatomic,assign)BOOL status;

@end
