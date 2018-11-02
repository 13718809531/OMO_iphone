//
//  OMOUserAddressListVC.h
//  OMO_iphone
//
//  Created by wy on 2018/10/9.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "BaseViewController.h"
#import "OMOUserAddressModel.h"

typedef void(^SelectAddress)(OMOUserAddressModel *addressModel);

@interface OMOUserAddressListVC : BaseViewController

/** 选中收货地址 */
@property (nonatomic,copy)SelectAddress selectAddress;

@end
