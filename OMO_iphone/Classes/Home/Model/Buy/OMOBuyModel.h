//
//  OMOBuyModel.h
//  OMO_iphone
//
//  Created by wy on 2018/10/17.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <Foundation/Foundation.h>
/**  */
#import "OMOUserAddressModel.h"
/**  */
#import "OMOBuyPoint_RulesModel.h"

@interface OMOBuyModel : NSObject

/** 满free_ship_price免运费 */
@property (nonatomic,copy)NSString *free_ship_price;
/** 运费 */
@property (nonatomic,copy)NSString *ship_price;
/**  */
@property (nonatomic, strong)OMOUserAddressModel *address;
/**  */
@property (nonatomic, strong)OMOBuyPoint_RulesModel *point_rules;

@end
