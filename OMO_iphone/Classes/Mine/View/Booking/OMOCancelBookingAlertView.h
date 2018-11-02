//
//  OMOCancelBookingAlertView.h
//  OMO_iphone
//
//  Created by wy on 2018/10/25.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CancelBookingBlock)(void);

@interface OMOCancelBookingAlertView : UIView

/**  */
@property (nonatomic,copy)CancelBookingBlock cancelBookingBlock;
- (void)show;
- (void)dissMiss;

@end
