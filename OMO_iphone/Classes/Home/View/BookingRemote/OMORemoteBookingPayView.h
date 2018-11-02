//
//  OMORemoteBookingPayView.h
//  OMO_iphone
//
//  Created by wy on 2018/10/24.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectPayTypeBlock)(NSString *payType);

@interface OMORemoteBookingPayView : UIView

/**  */
@property (nonatomic,copy)SelectPayTypeBlock selectPayTypeBlock;
/**  */
@property (nonatomic,copy)NSString *price;

- (void)show;
- (void)dissMiss;

@end
