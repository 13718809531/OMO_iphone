//
//  MBProgress.h
//  FunTown
//
//  Created by 王帅 on 16/8/31.
//  Copyright © 2016年 Tony. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MBProgressCustomMode) {
    MBProgressCustomModeSuccess,
    MBProgressCustomModeError
};


/**
 *  MBProgressHUD二次封装
 *  暂时提供成功、失败的展示方法
 */
@interface MBProgress : UIView

+ (void)showSuccessWithParentView:(UIView *)parentView text:(NSString *)text afterDelay:(NSTimeInterval)time;

+ (void)showErrorWithParentView:(UIView *)parentView text:(NSString *)text  afterDelay:(NSTimeInterval)time;

+ (void)showInfomationWithParentView:(UIView *)parentView message:(NSString *)message duration:(CGFloat)second;

+ (void)showInfomationWithMessage:(NSString *)message duration:(CGFloat)second;

+ (void)showStatus:(NSString *)message;

+ (void)hideAllHUD;

+ (void)hideAllHUDWithAnimated;

/**
 *
 *  显示提示信息
 *
 *  @param message 提示信息内容
 */
+ (void)showInfoMessage:(NSString *)message;

/**
 *
 *  显示错误信息
 *
 *  @param message 错误描述
 */
+ (void)showErrorMessage:(NSString *)message;

@end
