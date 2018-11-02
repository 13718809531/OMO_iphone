//
//  OMORemoteResultModel.h
//  OMO_iphone
//
//  Created by wy on 2018/11/2.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <Foundation/Foundation.h>
/**  */
#import "OMORemoteUserInfo.h"

@interface OMORemoteResultModel : NSObject

/**  */
@property (nonatomic, strong)OMORemoteUserInfo *info;
/**  */
@property (nonatomic,copy)NSString *result;
/**  */
@property (nonatomic, strong)NSArray *tool;

@end
