//
//  OMOSelectPartsVC.h
//  OMO_iphone
//
//  Created by wy on 2018/9/12.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    OMOPushSelctPartsTypeDefault = 0,// 正常跳转
    OMOPushSelctPartsTypeFount = 1,// 预约
} OMOPushSelctPartsType;

@interface OMOSelectPartsVC : BaseViewController

/**  */
@property (nonatomic,assign)OMOPushSelctPartsType pushType;

@end
