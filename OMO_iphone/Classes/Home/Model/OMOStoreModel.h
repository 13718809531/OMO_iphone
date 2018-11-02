//
//  OMOStoreModel.h
//  OMO_iphone
//
//  Created by wy on 2018/10/10.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <Foundation/Foundation.h>
/**  */
#import "OMOStoreWeekModel.h"

@class OMOStoreSowing_mapModel;

@interface OMOStoreModel : NSObject

/** 门店ID */
@property (nonatomic,copy)NSString *store_id;
/** 门店名称 */
@property (nonatomic,copy)NSString *store_name;
/** 门店所在省 */
@property (nonatomic,copy)NSString *province;
/** 门店所在市 */
@property (nonatomic,copy)NSString *city;
/** 门店所在区 */
@property (nonatomic,copy)NSString *country;
/** 门店具体地址 */
@property (nonatomic,copy)NSString *address;
/** 门店LOGO图片URL */
@property (nonatomic,copy)NSString *logo_url;
/** 门店人数,单位人 */
@property (nonatomic,copy)NSString *people;
/** 门店距离当前位置,单位km */
@property (nonatomic,copy)NSString *place;
/** 联系人 */
@property (nonatomic,copy)NSString *contacts;
/** 联系人电话 */
@property (nonatomic,copy)NSString *mobile;
/** 描述信息 */
@property (nonatomic, strong)NSArray <OMOStoreSowing_mapModel *> *sowing_map;
/**  */
@property (nonatomic, strong)NSArray <OMOStoreWeekModel *> *time;

@end

@interface OMOStoreSowing_mapModel : NSObject

/** 图片 */
@property (nonatomic,copy)NSString *url;
/** 描述 */
@property (nonatomic,copy)NSString *desc;

/** 文字高度 */
@property (nonatomic,assign)CGFloat titleHeight;
/** 图片高度 */
@property (nonatomic,assign)CGFloat imageHeight;

@end
