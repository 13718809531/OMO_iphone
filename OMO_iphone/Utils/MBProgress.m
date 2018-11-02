//
//  MBProgress.m
//  FunTown
//
//  Created by 王帅 on 16/8/31.
//  Copyright © 2016年 Tony. All rights reserved.
//

#import "MBProgress.h"

static MBProgress * _instance = nil;
@implementation MBProgress

+(instancetype) shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init] ;
    }) ;
    
    return _instance ;
}

+(id) allocWithZone:(struct _NSZone *)zone
{
    return [MBProgress shareInstance] ;
}

-(id) copyWithZone:(NSZone *)zone
{
    return [MBProgress shareInstance] ;//return _instance;
}

-(id) mutablecopyWithZone:(NSZone *)zone
{
    return [MBProgress shareInstance] ;
}
+ (void)showSuccessWithParentView:(UIView *)parentView text:(NSString *)text afterDelay:(NSTimeInterval)time
{
    [self showErrorWithParentView:parentView text:text afterDelay:time type:MBProgressCustomModeSuccess];
}

+ (void)showErrorWithParentView:(UIView *)parentView text:(NSString *)text  afterDelay:(NSTimeInterval)time
{
    [self showErrorWithParentView:parentView text:text afterDelay:time type:MBProgressCustomModeError];
}

+ (void)showErrorWithParentView:(UIView *)parentView text:(NSString *)text  afterDelay:(NSTimeInterval)time type:(MBProgressCustomMode)mode
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:parentView animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    NSString *imageName = @"";
    if (mode == MBProgressCustomModeSuccess) {
        imageName = @"mbsuccess";
    }else if (mode == MBProgressCustomModeError) {
        imageName = @"mberror";
    }
    UIImage *image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    hud.customView = [[UIImageView alloc] initWithImage:image];
    hud.square = YES;
    hud.label.text = text;
    [hud hideAnimated:YES afterDelay:time];
}

+ (void)showInfomationWithParentView:(UIView *)parentView message:(NSString *)message duration:(CGFloat)second {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:parentView animated:YES];
    hud.label.text = message;
    hud.mode = MBProgressHUDModeText;
    [hud hideAnimated:YES afterDelay:second];
}

+ (void)showErrorMessage:(NSString *)message {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].delegate.window animated:YES];
        hud.label.text = message;
        hud.mode = MBProgressHUDModeText;
        [hud hideAnimated:YES afterDelay:lwb_duration];
    }];
}

+ (void)showInfoMessage:(NSString *)message {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].delegate.window animated:YES];
        hud.label.text = message;
        hud.mode = MBProgressHUDModeText;
        [hud hideAnimated:YES afterDelay:lwb_duration];
    }];
}


+ (void)showInfomationWithMessage:(NSString *)message duration:(CGFloat)second {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].delegate.window animated:YES];
        hud.label.text = message;
        hud.mode = MBProgressHUDModeText;
        hud.userInteractionEnabled = YES;
        [hud hideAnimated:YES afterDelay:second];
    }];
}

+ (void)showStatus:(NSString *)message {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].delegate.window animated:YES];
        hud.label.text = message;
    }];
}

+ (void)hideAllHUD {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].delegate.window animated:NO];
    }];
}

+ (void)hideAllHUDWithAnimated {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].delegate.window animated:YES];
    }];
}

@end
