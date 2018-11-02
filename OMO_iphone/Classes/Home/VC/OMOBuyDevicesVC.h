//
//  OMOBuyDevicesVC.h
//  OMO_iphone
//
//  Created by wy on 2018/10/9.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "BaseViewController.h"
/**  */
#import "OMOKangFuBaoModel.h"

typedef enum : NSUInteger {
    OMOBuyTypeDefault = 0,// 辅具,训练计划
    OMOBuyTypeDefaultTrainingPlan = 1,// 训练计划
    OMOBuyTypeDefaultDevices = 2// 辅具
} OMOBuyType;

//** 购买辅具 */
@interface OMOBuyDevicesVC : BaseViewController

/** 订单号 */
@property (nonatomic,copy)NSString *pe_order_id;
/**  */
@property (nonatomic,assign)OMOBuyType buyType;
/**  */
@property (nonatomic,assign)NSInteger numType;
/**  */
@property (nonatomic, strong)OMOKangFuBaoModel *kangFuBaoModel;
/**  */
@property (nonatomic, strong)NSArray <OMOKangFuBaoMtItemModel *> *items;

@end
