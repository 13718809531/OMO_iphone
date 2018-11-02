//
//  OMOSelectPartsModel.h
//  OMO_iphone
//
//  Created by wy on 2018/9/14.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OMOSelectPartsModel : NSObject

@property (nonatomic,copy)NSString *imgName;/** 图片名称  */
@property (nonatomic,assign)BOOL select; /** 是否选中 */
@property (nonatomic,copy)NSString *cate_name;/** 选择部位 */
@property (nonatomic,copy)NSString *cate_id;/** 部位Id */

@end
