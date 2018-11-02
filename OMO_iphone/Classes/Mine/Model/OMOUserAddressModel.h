//
//  OMOUserAddressModel.h
//  OMO_iphone
//
//  Created by wy on 2018/10/11.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OMOUserAddressModel : NSObject

/** 收货地址ID */
@property (nonatomic,copy)NSString *ID;
/** 收货地址 */
@property (nonatomic,copy)NSString *address;
/** 收货地址省 */
@property (nonatomic,copy)NSString *province;
/** 收货地址市 */
@property (nonatomic,copy)NSString *city;
/** 收货地址区 */
@property (nonatomic,copy)NSString *country;
/** 收货人手机号 */
@property (nonatomic,copy)NSString *mobile;
/** 收货人姓名 */
@property (nonatomic,copy)NSString *name;
/** 是否设为默认 */
@property (nonatomic,copy)NSString *is_default;

@end
