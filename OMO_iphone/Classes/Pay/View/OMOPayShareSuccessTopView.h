//
//  OMOPayShareSuccessTopView.h
//  OMO_iphone
//
//  Created by wy on 2018/10/18.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    OMOPaySuccessTypeDefault = 0,
    OMOPaySuccessTypePay = 1,
    OMOPaySuccessTypeShare = 2,
} OMOPaySuccessType;

@interface OMOPayShareSuccessTopView : UIView

/**  */
@property (nonatomic,assign)OMOPaySuccessType payType;

@end
