//
//  OMOUserAddressModel.h
//  OMO_iphone
//
//  Created by wy on 2018/10/9.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OMOUserAddressModel : NSObject

//地址前半段
@property (nonatomic,copy) NSString *city;
//地址后半段
@property (nonatomic,copy) NSString *detail;
//是否是默认地址
@property (nonatomic,assign) NSInteger isDefaultAddress;
//收货人姓名
@property (nonatomic,copy) NSString *receiverName;
//收货人电话
@property (nonatomic,copy) NSString *receiverPhone;
//地址id
@property (nonatomic,copy) NSString *ID;

@end
