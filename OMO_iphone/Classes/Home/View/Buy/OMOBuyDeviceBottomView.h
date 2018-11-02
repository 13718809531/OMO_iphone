//
//  OMOBuyDeviceBottomView.h
//  OMO_iphone
//
//  Created by wy on 2018/10/17.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *
 *
 */
@protocol OMOSubmitOrderDelegate <NSObject>

- (void)omo_submitOrderDidClik;

@end

@interface OMOBuyDeviceBottomView : UIView

/**  */
@property (nonatomic , weak) id <OMOSubmitOrderDelegate> delegate;
/** 运费 */
@property (nonatomic,copy)NSString *ship_price;
/** 总金额 */
@property (nonatomic,copy)NSString *totalPrice;
/** 是否达成满减条件 */
@property (nonatomic,assign)BOOL isFree;

@end
