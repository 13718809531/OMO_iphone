//
//  OMOAddressListVC.h
//  OMO_iphone
//
//  Created by wy on 2018/10/11.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "BaseViewController.h"
/**  */
#import "OMOUserAddressModel.h"

typedef void(^SelectAddress)(OMOUserAddressModel *addressModel);

@interface OMOAddressListVC : BaseViewController

/**  */
@property (nonatomic,copy)SelectAddress selectAddress;
@end
