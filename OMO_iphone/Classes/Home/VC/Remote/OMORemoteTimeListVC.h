//
//  OMORemoteTimeListVC.h
//  OMO_iphone
//
//  Created by wy on 2018/10/24.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^SelectTimeBlock)(NSString *selectTime,NSString *last_price);

@interface OMORemoteTimeListVC : BaseViewController

/**  */
@property (nonatomic,copy)SelectTimeBlock selectTimeBlock;
@end
