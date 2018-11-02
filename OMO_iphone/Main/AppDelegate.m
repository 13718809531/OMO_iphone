//
//  AppDelegate.m
//  OMO_iphone
//
//  Created by 刘卫兵 on 2018/9/5.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "AppDelegate.h"
/** 分享 */
#import "WTShareManager.h"
#import "NTESNotificationCenter.h"
#import <IQKeyboardManager.h>// 键盘
#import <Sentry.h>// bug收集
#import "OMOTabBarController.h"
#/**  */
#import "OMOShowWXBindingVC.h"
#import "OMOFirstLaunchVC.h"
#import <Security/Security.h>
/** 永久保存账号 */
#import "KeychainItemWrapper.h"
// 引入 JPush 功能所需头文件
#import "JPUSHService.h"
// iOS10 注册 APNs 所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>

#import "NTESVideoChatViewController.h"
#endif

@interface AppDelegate ()<JPUSHRegisterDelegate>

@end

#define JPushAppKey @"075944c71893e8bbfeab793b"

@implementation AppDelegate

- (UIWindow *)window{
    
    if(_window == nil){
        
        _window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
        _window.backgroundColor = [UIColor whiteColor]; //白色背景
    }
    return _window;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //    NTESNotificationCenter  打开系统通知中心，接收视频请求
    [[NTESNotificationCenter sharedCenter] start];
    //   使用NSUserDefaults来判断程序是否第一次启动
    NSUserDefaults *TimeOfBootCount = [NSUserDefaults standardUserDefaults];
    if (![TimeOfBootCount valueForKey:@"timeOnce"]) {// 第一次启动,引导页
        
        [TimeOfBootCount setValue:@"first" forKey:@"timeOnce"];
        
        self.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:[[OMOFirstLaunchVC alloc]init]];
        
        /** 初始化一个保存用户帐号的KeychainItemWrapper */
        KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"UserAccessToken" accessGroup:nil];
        
        //从keychain里取出值
        NSString *device_id = [wrapper objectForKey:(id)kSecValueData];
        
        if(device_id.length <= 0){
            
            [self omo_getAppCode];// 请求设备识别码
        }
    }else{// 进入程序
//        self.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:[[OMOShowWXBindingVC alloc]init]];
        OMOTabBarController *tabbar = [[OMOTabBarController alloc]init];
        self.window.rootViewController = tabbar;
    }
    [self.window makeKeyAndVisible];
    //NIM注册及初始化方法
    [self registNIM];
    [WXApi registerApp:WX_APPID enableMTA:NO];// 注册微信

    // 激光
    [self setJPush];
    [JPUSHService setupWithOption:launchOptions appKey:JPushAppKey channel:@"App Store" apsForProduction:0 advertisingIdentifier:nil];
    [application setApplicationIconBadgeNumber:0];
    
    //本地推送
    [self requestAuthor];
    
    // 注册sentry收集错误日记
    [self setSentryClient];
    
    //初始化IQKeyboardManager
    [self setIQKeyboardManager];

    
    return YES;
}
-(void)registNIM{
    
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"UserAccessToken" accessGroup:nil];
    
    NSString *appKey        = @"45c6af3c98409b18a84451215d0bdd6e";
    NIMSDKOption *option    = [NIMSDKOption optionWithAppKey:appKey];
    option.apnsCername      = @"";
    option.pkCername        = @"";
    [[NIMSDK sharedSDK] registerWithOption:option];
    if([[NIMSDK sharedSDK] loginManager].isLogined == NO){
        /*手动登录*/
        //        [[[NIMSDK sharedSDK] loginManager] login:@"535030765" token:@"e10adc3949ba59abbe56e057f20f883e" completion:^(NSError * _Nullable error) {
        //
        //            if(error){
        //
        //
        //            }
        //        }];
        /*自动登录*/
        NIMAutoLoginData *loginData = [[NIMAutoLoginData alloc] init];
        loginData.account = @"13718809531";
        loginData.token = @"yuanxinkangfu";
        loginData.forcedMode = YES;
        [[[NIMSDK sharedSDK] loginManager] autoLogin:loginData];
    }
}
/**
 * 设置旋转屏幕
 */
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window

{
    if (_allowRotation == YES) {
        return UIInterfaceOrientationMaskLandscapeLeft;
    }else{
        return (UIInterfaceOrientationMaskPortrait);
    }
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(nonnull NSURL *)url{
    
    return [WXApi handleOpenURL:url delegate:self];
}
//9.0以前使用的回调
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    //支付宝支付回调
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
                
                //代理，让待支付界面进行跳转
                if ([self.thirdDelegate respondsToSelector:@selector(aliPayReturn:)]) {
                    [self.thirdDelegate aliPayReturn:YES];
                }
            }else if ([url.host isEqualToString:@"platformapi"]){
                if ([self.thirdDelegate respondsToSelector:@selector(aliPayReturn:)]) {
                    [self.thirdDelegate aliPayReturn:NO];
                }
            }else{
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgress showInfoMessage: resultDic[@"memo"]];
                });
                if ([self.thirdDelegate respondsToSelector:@selector(aliPayReturn:)]) {
                    [self.thirdDelegate aliPayReturn:NO];
                }
            }
        }];
    }else if ([url.host isEqualToString:@"oauth"]){
        //微信登录回调
        return [WXApi handleOpenURL:url delegate:self];
    }else if ([url.host isEqualToString:@"pay"]){
        //微信支付回调
        return [WXApi handleOpenURL:url delegate:self];
    }
    
    //微信分享回调
    if ([sourceApplication isEqualToString:@"com.tencent.xin"]){
        
        return [WXApi handleOpenURL:url delegate:[WTShareManager shareWTShareManager]];
        
    }
    return YES;
}
// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    //支付宝支付回调
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {

                //代理，让待支付界面进行跳转
                if ([self.thirdDelegate respondsToSelector:@selector(aliPayReturn:)]) {
                    [self.thirdDelegate aliPayReturn:YES];
                }

            }else if ([url.host isEqualToString:@"platformapi"]){
                if ([self.thirdDelegate respondsToSelector:@selector(aliPayReturn:)]) {
                    [self.thirdDelegate aliPayReturn:NO];
                }
            }else{
                if ([self.thirdDelegate respondsToSelector:@selector(aliPayReturn:)]) {
                    [self.thirdDelegate aliPayReturn:NO];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [MBProgress showInfoMessage: resultDic[@"memo"]];
                });
            }
        }];
    }else if ([url.host isEqualToString:@"oauth"]){
        //微信登录回调
        return [WXApi handleOpenURL:url delegate:self];
    }else if ([url.host isEqualToString:@"pay"]){
        //微信支付回调
        return [WXApi handleOpenURL:url delegate:self];
    }

    //分享回调
    NSDictionary * dic = options;
    NSLog(@"--分享回调== %@", dic);
   if ([options[UIApplicationOpenURLOptionsSourceApplicationKey] isEqualToString:@"com.tencent.xin"]){
        
        return [WXApi handleOpenURL:url delegate:[WTShareManager shareWTShareManager]];
    }
    
    return YES;
}
- (void)onReq:(BaseReq*)reqonReq{
    
    
}
- (void)onResp:(BaseResp*)resp{
    
    NSLog(@"resp %d",resp.errCode);
    
    /*
     enum  WXErrCode {
     WXSuccess           = 0,    成功
     WXErrCodeCommon     = -1,  普通错误类型
     WXErrCodeUserCancel = -2,    用户点击取消并返回
     WXErrCodeSentFail   = -3,   发送失败
     WXErrCodeAuthDeny   = -4,    授权失败
     WXErrCodeUnsupport  = -5,   微信不支持
     };
     */
    if ([resp isKindOfClass:[SendAuthResp class]]) {   //授权登录的类。
        if (resp.errCode == 0) {  //成功。
            //这里处理回调的方法 。 通过代理吧对应的登录消息传送过去。
            if ([self.thirdDelegate respondsToSelector:@selector(loginSuccessByCode:)]) {
                SendAuthResp *resp2 = (SendAuthResp *)resp;
                [self.thirdDelegate loginSuccessByCode:resp2.code];
            }
        }else{ //失败
            [MBProgress showErrorMessage:@"登录授权失败"];
        }
    }
    if([resp isKindOfClass:[PayResp class]]){  //微信支付回调的类
        
        //支付返回结果，实际支付结果需要去微信服务器端查询
        NSString *strMsg;
        
        switch (resp.errCode) {
            case WXSuccess:
                strMsg = @"支付结果：成功！";
                [MBProgress showInfoMessage:@"支付成功"];
                if ([self.thirdDelegate respondsToSelector:@selector(aliPayReturn:)]) {
                    [self.thirdDelegate aliPayReturn:YES];
                }
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                break;
                
            default:
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                [MBProgress showInfoMessage:resp.errStr];
                if ([self.thirdDelegate respondsToSelector:@selector(aliPayReturn:)]) {
                    [self.thirdDelegate aliPayReturn:NO];
                }
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                break;
        }
    }
}
#pragma mark - 极光推送
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}
#pragma mark ------- 收到的推送内容 -------------
- (void)networkDidReceiveMessage:(NSNotification *)notification {
    
    NSDictionary * userInfo = [notification userInfo];
    NSString *content = [userInfo valueForKey:@"content"];
    NSDictionary *extras = [userInfo valueForKey:@"extras"];
    NSString *customizeField1 = [extras valueForKey:@"customizeField1"]; //服务端传递的Extras附加字段，key是自己定义的
}
-(void)kJPFNetworkIsConnectingNotification:(NSNotification *)noti{
    NSLog(@" 正在连接中");
}
-(void)kJPFNetworkDidSetupNotification:(NSNotification *)noti{
    NSLog(@"建立连接");
}
-(void)kJPFNetworkDidCloseNotification:(NSNotification *)noti{
    NSLog(@"关闭连接");
}
-(void)kJPFNetworkDidRegisterNotification:(NSNotification *)noti{
    NSLog(@"注册成功");
}
-(void)kJPFNetworkFailedRegisterNotification:(NSNotification *)noti{
    NSLog(@"注册失败");
}
- (void)kJPFNetworkDidLoginNotification:(NSNotification *)noti{
    
    //设置别名
    NSString *alias = [OMOIphoneManager sharedData].mobile;
    
    if (alias.length > 1) {
        
        [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
            [JPUSHService setAlias:alias completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                NSLog(@"appdelegate设置别名");
                NSLog(@"别名：%@",iAlias);
            } seq:0];
        } seq:0];
    }else{
        
        //设置别名
        NSString *alias = [OMOIphoneManager sharedData].device_id;
        
        [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
            [JPUSHService setAlias:alias completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                NSLog(@"appdelegate设置别名");
                NSLog(@"别名：%@",iAlias);
            } seq:0];
        } seq:0];
    }
}

- (void)jPushWithOptions:(NSDictionary *)launchOptions{
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //categories
        
        [JPUSHService
         registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                             UIUserNotificationTypeSound |
                                             UIUserNotificationTypeAlert)
         categories:nil];
    } else {
        //categories nil
        [JPUSHService
         registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |UIRemoteNotificationTypeSound |UIRemoteNotificationTypeAlert)
#else
         //categories nil
         categories:nil];
        [APService
         registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                             UIRemoteNotificationTypeSound |
                                             UIRemoteNotificationTypeAlert)
#endif
         // Required
         categories:nil];
    }
    [JPUSHService setDebugMode];
}
// ios7以后
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    [JPUSHService handleRemoteNotification:userInfo];
    
    NSInteger num=[UIApplication sharedApplication].applicationIconBadgeNumber;
    if (num>=1) {
        num--;
    }
    
    [JPUSHService resetBadge];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    if (application.applicationState == 1) { // 程序接收到远程通知从后台状态启动
        
    }else{//在前台接收到推送
        
        //收到通知，判断当前页面是否为视频聊天页面，如果是则切换横竖屏，插入视频播放器
        UIViewController *currentVC = [OMOIphoneManager getCurrentVC];
        if([currentVC isKindOfClass:[NTESVideoChatViewController class]]){
            [[NSNotificationCenter defaultCenter] postNotificationName:@"InsertVideoNotification" object:nil userInfo:userInfo];
        }
    }
    
    completionHandler(UIBackgroundFetchResultNewData);
}

//程序在运行时收到通知，点击通知栏进入app
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [JPUSHService setBadge:0];
    
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    else {
        // 本地通知
        [[OMOIphoneManager sharedData] sf_setLocalNotificationAlertCentent:@"您有一条新消息" CenterBody:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}

//  iOS 10: 点击通知进入App时触发，在该方法内统计有效用户点击数
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        
        [JPUSHService handleRemoteNotification:userInfo];
    }else {
        // 本地通知
        [[OMOIphoneManager sharedData] sf_setLocalNotificationAlertCentent:@"您有一条新消息" CenterBody:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}

//程序在后台时收到通知，点击通知栏进入app
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [JPUSHService setBadge:0];
    
    NSDictionary *info = response.notification.request.content.userInfo;
    
    [self pushViewControllerWithDictionary:info ViewController:nil];
}
//点击App图标，使App从后台恢复至前台
- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}
//按Home键使App进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application{
    
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    application.applicationIconBadgeNumber = 0;
    [JPUSHService setBadge:0];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}
#pragma mark --------- 获取设备标识码 ----------
- (void)omo_getAppCode{
    
    [[OMONetworkManager sharedData]postWithURLString:@"10003" parameters:nil success:^(id responseObject) {
        
        if(responseObject){
            
            NSDictionary *data = (NSDictionary *)responseObject;
            
            /** 初始化一个保存用户帐号的KeychainItemWrapper */
            KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"UserAccessToken" accessGroup:nil];
            
            NSString *device_id = data[@"device_id"];
            //保存帐号
            //    [wrapper setObject:accessToken forKey:(id)kSecAttrTokenID];
            
            [wrapper setObject:device_id forKey: (__bridge NSString *)kSecValueData];
        }
    } failure:^(NSError *error) {
        
        [MBProgress hideAllHUD];
    }];
}
//
- (void)setSentryClient{
    
    NSError *error = nil;
    SentryClient *client = [[SentryClient alloc] initWithDsn:@"http://98a173dde6de463caa5b1aaa12dac86a@39.105.12.199:9000/3" didFailWithError:&error];
    SentryClient.sharedClient = client;
    [SentryClient.sharedClient startCrashHandlerWithError:&error];
    
    if(nil != error){
        
        NSLog(@"%@", error);
    }
}
- (void)setIQKeyboardManager{
    
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    
    keyboardManager.enable = YES; // 控制整个功能是否启用
    
    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    
    keyboardManager.shouldToolbarUsesTextFieldTintColor = NO; // 控制键盘上的工具条文字颜色是否用户自定义
    
    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    
    keyboardManager.enableAutoToolbar = YES; // 控制是否显示键盘上的工具条
    
    keyboardManager.shouldShowToolbarPlaceholder = YES; // 是否显示占位文字
    
    keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:17]; // 设置占位文字的字体
    
    keyboardManager.keyboardDistanceFromTextField = 10.0f; // 输入框距离键盘的距离
}

- (void)setJPush{
    
    //极光推送
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(kJPFNetworkDidLoginNotification:) name:kJPFNetworkDidLoginNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(kJPFNetworkIsConnectingNotification:) name:kJPFNetworkIsConnectingNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(kJPFNetworkDidSetupNotification:) name:kJPFNetworkDidSetupNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(kJPFNetworkDidCloseNotification:) name:kJPFNetworkDidCloseNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(kJPFNetworkDidRegisterNotification:) name:kJPFNetworkDidRegisterNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(kJPFNetworkFailedRegisterNotification:) name:kJPFNetworkFailedRegisterNotification object:nil];
    
    //1:初始化APNS
    
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    //2.1.9版本新增获取registration id block接口。
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if(resCode == 0){
            NSLog(@"registrationID获取成功：%@",registrationID);
        }else{
            NSLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];
}
#pragma mark ----------- 创建本地通知 ------------
- (void)requestAuthor
{
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // 设置通知的类型可以为弹窗提示,声音提示,应用图标数字提示
        UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
        // 授权通知
        [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
    }
}

#pragma mark ------- 点击jpush内容跳转 ----------
- (void)pushViewControllerWithDictionary:(NSDictionary *)info ViewController:(UIViewController *)viewController{
    
    if(viewController == nil){
        
        viewController = [OMOIphoneManager getCurrentVC];
    }
    NSArray *array = [info allKeys];
    
    if(array.count > 0){
        
        if([array containsObject:@"type"]){
            
            NSString *type = [NSString stringWithFormat:@"%@",info[@"type"]];
            
            if([type isEqualToString:@"good"]){
                
                
            }else if ([type isEqualToString:@"h5"]){
                
                
            }else if ([type isEqualToString:@"single"]){
                
                
            }
        }
    }
}
@end
