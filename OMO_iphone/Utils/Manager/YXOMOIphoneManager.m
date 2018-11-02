//
//  YXOMOIphoneManager.m
//  OMO_iphone
//
//  Created by 刘卫兵 on 2018/9/5.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "YXOMOIphoneManager.h"
#import "KeychainItemWrapper.h"

static YXOMOIphoneManager *_manager = nil;

@implementation YXOMOIphoneManager

+ (instancetype)sharedData{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        if (_manager == nil) {
            
            _manager = [[YXOMOIphoneManager alloc] init];
        }
    });
    return _manager;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    if (_manager == nil) {
        
        _manager = [super allocWithZone:zone];
    }
    return _manager;
}
- (id)copyWithZone:(NSZone *)zone{
    
    return [self copyWithZone:zone];
}
- (id)mutableCopy{
    return self;
}
#pragma mark [存入]
//存入字符串类型数据
- (void)saveInfoWithKey:(NSString *)key andValue:(NSString *)value{
    if ([value isNullString]) {
        value = @"";
    }
    [[NSUserDefaults standardUserDefaults]setObject:value forKey:key];
    //同步存储到磁盘中
    [[NSUserDefaults standardUserDefaults]synchronize];
}

//存入布朗型数据
- (void)saveBoolWithKey:(NSString *)key andValue:(BOOL)value{
    [self saveInfoWithKey:key andValue:value == YES?@"YES":@"NO"];
}

//存入对象
- (void)saveObjWithKey:(NSString *)key andValue:(NSObject *)value{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:[value copy]];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark [取出]
//取出字符串类型数据
- (NSString *)getInfoWithKey:(NSString *)key{
    return [[NSUserDefaults standardUserDefaults]objectForKey:key];
}

//取出布朗型数据
- (BOOL)getBoolWithKey:(NSString *)key{
    
    return [[self getInfoWithKey:key] isEqualToString:@"YES"];
}

//取出对象
- (id)getObjWithKey:(NSString *)key{
    
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

#pragma mark [相关信息的set与get]
#pragma mark -------  user_id --------
- (void)setUser_id:(NSString *)user_id{
    
    [self saveInfoWithKey:@"user_id" andValue:user_id];
}
- (NSString *)user_id{
    
    return [self getInfoWithKey:@"user_id"];
}

#pragma mark -------  mobile --------
- (void)setMobile:(NSString *)mobile{
    
    [self saveInfoWithKey:@"mobile" andValue:mobile];
}
- (NSString *)mobile{
    
    return [self getInfoWithKey:@"mobile"];
}

#pragma mark -------  session_id --------
- (void)setSession_id:(NSString *)session_id{
    
    [self saveInfoWithKey:@"session_id" andValue:session_id];
}
- (NSString *)session_id{
    
    return [self getInfoWithKey:@"session_id"];
}

#pragma mark -------  gender --------
- (void)setGender:(NSString *)gender{
    
    [self saveInfoWithKey:@"gender" andValue:gender];
}
- (NSString *)gender{
    
    return [self getInfoWithKey:@"gender"];
}

#pragma mark -------  id_card_no --------
- (void)setId_card_no:(NSString *)id_card_no{
    
    [self saveInfoWithKey:@"id_card_no" andValue:id_card_no];
}
- (NSString *)id_card_no{
    
    return [self getInfoWithKey:@"id_card_no"];
}

#pragma mark -------  birthday --------
- (void)setBirthday:(NSString *)birthday{
    
    [self saveInfoWithKey:@"birthday" andValue:birthday];
}
- (NSString *)birthday{
    
    return [self getInfoWithKey:@"birthday"];
}

#pragma mark -------  birthday --------
-(void)setAge:(NSInteger)age{
    
    [self saveInfoWithKey:@"age" andValue:[NSString stringWithFormat:@"%ld",age]];
}
- (NSInteger)age{
    
    NSString *age = [self getInfoWithKey:@"age"];
    return [age integerValue];
}

#pragma mark -------  nickname --------
- (void)setNickname:(NSString *)nickname{
    
    [self saveInfoWithKey:@"nickname" andValue:nickname];
}
- (NSString *)nickname{
    
    return [self getInfoWithKey:@"nickname"];
}

#pragma mark -------  avatar_url --------
- (void)setAvatar_url:(NSString *)avatar_url{
    
    [self saveInfoWithKey:@"avatar_url" andValue:avatar_url];
}
- (NSString *)avatar_url{
    
    return [self getInfoWithKey:@"avatar_url"];
}

#pragma mark -------  is_userinfo --------
- (void)setIs_userinfo:(BOOL)is_userinfo{
    
    [self saveObjWithKey:@"is_userinfo" andValue:[NSString stringWithFormat:@"%d",is_userinfo]];
}
- (BOOL)is_userinfo{
    
    NSString *is_userinfo = [self getInfoWithKey:@"is_userinfo"];
    
    if([is_userinfo isEqualToString:@"1"]){
        
        return YES;
    }
    return NO;
}

#pragma mark -------  device_token --------
- (NSString *)device_token{
    
    /** 初始化一个保存用户帐号的KeychainItemWrapper */
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"UserAccessToken" accessGroup:nil];
    
    //从keychain里取出值
    NSString *device_token = [wrapper objectForKey:(id)kSecValueData];
    
    return device_token;
}
// 获取当前控制器
+ (UIViewController *)getCurrentVC {
    
    NSArray *widows = [UIApplication sharedApplication].windows;
    UIWindow *window = [widows firstObject];
    if (!window) {
        return nil;
    }
    UIView *tempView;
    NSArray *subViews = window.subviews;
    for (UIView *subview in subViews) {
        if ([[subview.classForCoder description] isEqualToString:@"UILayoutContainerView"]) {
            tempView = subview;
            break;
        }
    }
    if (!tempView) {
        tempView = [window.subviews lastObject];
    }
    
    id nextResponder = [tempView nextResponder];
    while (![nextResponder isKindOfClass:[UIViewController class]] || [nextResponder isKindOfClass:[UINavigationController class]] || [nextResponder isKindOfClass:[UITabBarController class]]) {
        tempView =  [tempView.subviews firstObject];
        
        if (!tempView) {
            return nil;
        }
        nextResponder = [tempView nextResponder];
    }
    
    UIViewController *vc = (UIViewController *)nextResponder;
    
    if(vc == nil){
        
        return [self getCurrentNewsVC];
    }else if(![vc isKindOfClass:[UIViewController class]]){
        
        return [self getCurrentNewsVC];
    }
    return  vc;
}
+  (UIViewController *)getCurrentNewsVC {
    
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    //获得当前活动窗口的根视图
    UIViewController* vc = window.rootViewController;
    
    while (1)
    {
        //根据不同的页面切换方式，逐步取得最上层的viewController
        if ([vc isKindOfClass:[UITabBarController class]]) {
            
            vc = [(UITabBarController *)vc selectedViewController];
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            
            vc = ((UINavigationController *) vc).visibleViewController;
        }
        if (vc.presentedViewController) {
            
            vc = vc.presentedViewController;
        }else{
            break;
        }
    }
    return vc;
}
@end
