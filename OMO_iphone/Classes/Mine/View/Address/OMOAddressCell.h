//
//  OMOAddressCell.h
//  OMO_iphone
//
//  Created by wy on 2018/10/11.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OMOUserAddressModel.h"

@interface OMOAddressCell : UITableViewCell

/** 收货地址 */
@property (nonatomic, strong)OMOUserAddressModel *addressModel;

@end
