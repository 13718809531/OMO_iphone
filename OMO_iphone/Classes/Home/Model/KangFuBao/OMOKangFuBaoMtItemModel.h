//
//  OMOKangFuBaoMtItemModel.h
//  OMO_iphone
//
//  Created by wy on 2018/10/13.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OMOKangFuBaoMtItemModel : NSObject

/** id */
@property (nonatomic,copy)NSString *item_id;
/** 名称 */
@property (nonatomic,copy)NSString *name;
/** 是否优惠  1优惠,0不优惠 */
@property (nonatomic,copy)NSString *is_discount;
/** 优惠价格 */
@property (nonatomic,copy)NSString *discount_price;
/** 单价 */
@property (nonatomic,copy)NSString *unit_price;
/** 购买数量 */
@property (nonatomic,copy)NSString *num;
/** 图片地址 */
@property (nonatomic,copy)NSString *url;
/** 库存 */
@property (nonatomic,copy)NSString *store_num;
/**  */
@property (nonatomic,assign)BOOL isSelect;

@end
