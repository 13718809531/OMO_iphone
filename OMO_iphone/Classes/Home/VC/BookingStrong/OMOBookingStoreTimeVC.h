//
//  OMOBookingStrongTimeVC.h
//  OMO_iphone
//
//  Created by wy on 2018/10/9.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "BaseViewController.h"
/**  */
#import "OMOStoreModel.h"

typedef void(^SelctBookingTime)(NSString *bookingTime);

@interface OMOBookingStoreTimeVC : BaseViewController

/**  */
@property (nonatomic, strong)OMOStoreModel *storeModel;

/**  */
@property (nonatomic,copy)SelctBookingTime selctBookingTime;

@end
