//
//  OMOKangFuBaoResourceModel.h
//  OMO_iphone
//
//  Created by wy on 2018/10/13.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OMOKangFuBaoContentModel.h"

@interface OMOKangFuBaoResourceModel : NSObject

@property (nonatomic,copy)NSString *resource_id;/**  */
@property (nonatomic,copy)NSString *cate_id;/**  */
@property (nonatomic,copy)NSString *type;/**  */
@property (nonatomic,copy)NSString *resource_name;/**  */
@property (nonatomic,copy)NSString *code;/**  */
@property (nonatomic,copy)NSString *url;/**  */
@property (nonatomic,copy)NSString *resource_description;/**  */
@property (nonatomic,copy)NSString *attentions;/**  */
@property (nonatomic, strong)NSArray <OMOKangFuBaoContentModel *> *content;
@property (nonatomic,copy)NSString *state;/**  */
@property (nonatomic,copy)NSString *created;/**  */
@property (nonatomic,copy)NSString *updated;/**  */

@end
