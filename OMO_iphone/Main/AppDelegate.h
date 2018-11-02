//
//  AppDelegate.h
//  OMO_iphone
//
//  Created by 刘卫兵 on 2018/9/5.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WXApi.h>
#import <AlipaySDK/AlipaySDK.h>

//协议定义
@protocol thridDelegate <NSObject>

- (void)loginSuccessByCode:(NSString *)code;//微信登录
- (void)aliPayReturn:(BOOL)isSuccess;//微信、 支付宝支付回调

@end

@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,weak)id <thridDelegate> thirdDelegate;
/**
 *  允许横竖屏切换
 */
@property (nonatomic,assign) BOOL allowRotation;
@end

