//
//  YXOMOIphoneManager.m
//  OMO_iphone
//
//  Created by 刘卫兵 on 2018/9/5.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOIphoneManager.h"
#import "KeychainItemWrapper.h"

static OMOIphoneManager *_manager = nil;

@implementation OMOIphoneManager

+ (void)initWithDictionary:(NSDictionary *)dictionary{
        
    if(_manager){
        
        _manager.user_id = dictionary[@"id"];
        _manager.mobile = dictionary[@"mobile"];
        NSString *session_id = dictionary[@"session_id"];
        if(session_id.length > 0){
            
            _manager.session_id = session_id;
        }
        _manager.gender = dictionary[@"gender"];
        _manager.id_card_no = dictionary[@"id_card_no"];
        _manager.birthday = dictionary[@"birthday"];
        _manager.age = [dictionary[@"age"] integerValue];
        _manager.nickname = dictionary[@"nickname"];
        _manager.realname = dictionary[@"nickname"];
        _manager.weight = dictionary[@"weight"];
        _manager.height = dictionary[@"height"];
        _manager.avatar_url = dictionary[@"avatar_url"];
        _manager.is_userinfo = [dictionary[@"is_userinfo"] boolValue];
    }
}
+ (instancetype)sharedData{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        if (_manager == nil) {
            
            _manager = [[OMOIphoneManager alloc] init];
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
    
    NSString *value = [[NSUserDefaults standardUserDefaults]objectForKey:key];
    return value;
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
    
    NSString *user_id = [self getInfoWithKey:@"user_id"];
    return user_id;
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
    
    NSString *gender = [self getInfoWithKey:@"gender"];
    
    if([gender isEqualToString:@"1"]){
        
        return @"男";
    }else if ([gender isEqualToString:@"0"]){
        
        return @"女";
    }else{
        
        return @"";
    }
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

#pragma mark -------  realname --------
- (void)setRealname:(NSString *)realname{
    
    [self saveInfoWithKey:@"realname" andValue:realname];
}
- (NSString *)realname{
    
    return [self getInfoWithKey:@"realname"];
}

#pragma mark -------  height --------
- (void)setHeight:(NSString *)height{
    
    [self saveInfoWithKey:@"height" andValue:height];
}
- (NSString *)height{
    
    return [self getInfoWithKey:@"height"];
}

#pragma mark -------  weight --------
- (void)setWeight:(NSString *)weight{
    
    [self saveInfoWithKey:@"weight" andValue:weight];
}
- (NSString *)weight{
    
    return [self getInfoWithKey:@"weight"];
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
    
    [self saveBoolWithKey:@"is_userinfo" andValue:is_userinfo];
}
- (BOOL)is_userinfo{
    
    BOOL is_userinfo = [self getBoolWithKey:@"is_userinfo"];
    return is_userinfo;
}

#pragma mark -------  type_id --------
- (void)setType_id:(NSString *)type_id{
    
    [self saveInfoWithKey:@"type_id" andValue:type_id];
}
- (NSString *)type_id{
    
    return [self getInfoWithKey:@"type_id"];
}

#pragma mark -------  cate_id --------
- (void)setCate_id:(NSString *)cate_id{
    
    [self saveInfoWithKey:@"cate_id" andValue:cate_id];
}
- (NSString *)cate_id{
    
    return [self getInfoWithKey:@"cate_id"];
}

#pragma mark -------  cate_name --------
- (void)setCate_name:(NSString *)cate_name{
    
    [self saveInfoWithKey:@"cate_name" andValue:cate_name];
}
- (NSString *)cate_name{
    
    return [self getInfoWithKey:@"cate_name"];
}

#pragma mark -------  acography_id --------
- (void)setAcography_id:(NSString *)acography_id{
    
    [self saveInfoWithKey:@"acography_id" andValue:acography_id];
}
- (NSString *)acography_id{
    
    return [self getInfoWithKey:@"acography_id"];
}

#pragma mark -------  kangFuBao_name --------
- (void)setKangFuBao_name:(NSString *)kangFuBao_name{
    
    [self saveInfoWithKey:@"kangFuBao_name" andValue:kangFuBao_name];
}
- (NSString *)kangFuBao_name{
    
    return [self getInfoWithKey:@"kangFuBao_name"];
}

#pragma mark -------  device_id --------
- (NSString *)device_id{
    
    /** 初始化一个保存用户帐号的KeychainItemWrapper */
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"UserAccessToken" accessGroup:nil];
    
    //从keychain里取出值
    NSString *device_id = [wrapper objectForKey:(id)kSecValueData];
    
    return device_id;
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
#pragma mark - LocalNotification
// 调用本地通知
- (void)sf_setLocalNotificationAlertCentent:(NSString *)centent CenterBody:(NSDictionary *)body{
    
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]) {
        [[UIApplication sharedApplication]
         registerUserNotificationSettings:
         [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|
          UIUserNotificationTypeBadge|
          UIUserNotificationTypeSound categories:nil]];
    }
    //创建一个本地通知
    UILocalNotification *notificztion = [[UILocalNotification alloc]init];
    //设置通知的触发时间
    notificztion.fireDate = [NSDate dateWithTimeIntervalSinceNow:5]  ;
    //设置通知的时区
    notificztion.timeZone = [NSTimeZone defaultTimeZone];
    //设置通知的重复发送的时间间隔
    notificztion.repeatInterval = kCFCalendarUnitHour;
    //通知标题
    notificztion.alertTitle = centent;
    //设置当设备处于锁屏状态时，显示通知的警告框下方的title；
    notificztion.alertAction = @"打开";
    //设置通知是否可以显示Action
    notificztion.hasAction = YES;
    //设置通过通知加载应用时显示的图片
    notificztion.alertLaunchImage = @"defaultUserIcon";
    //设置通知内容
    notificztion.alertBody = centent;
    //设置userInfo 便于携带额外的附加信息
    notificztion.userInfo = @{@"元新康复":centent};
    
    [self sf_setPlaySoundAndVibration];
    //调度通知
    [[UIApplication sharedApplication] scheduleLocalNotification:notificztion];
}
// 取消通知
- (void)sf_setCancelLocalNotification{
    //获取所有处于调度中本地通知数组
    NSArray *localArry = [[UIApplication sharedApplication] scheduledLocalNotifications];
    if (localArry) {
        for (UILocalNotification *noti in localArry) {
            NSDictionary *dict=noti.userInfo;
            if (dict) {
                //如果找到要取消的通知
                NSString *inkey=[dict objectForKey:@"元新康复"];
                if ([inkey isEqualToString:@"您有一条新消息"]) {
                    //取消调度通知
                    [[UIApplication sharedApplication] cancelLocalNotification:noti];
                }
            }
        }
    }
}
// 通知提示
- (void)sf_setPlaySoundAndVibration{
    NSTimeInterval timeInterval = [[NSDate date]
                                   timeIntervalSinceDate:self.lastPlaySoundDate];
    if (timeInterval < 3.0) {
        //如果距离上次响铃和震动时间太短, 则跳过响铃
        NSLog(@"skip ringing & vibration %@, %@", [NSDate date], self.lastPlaySoundDate);
        return;
    }
    
    //保存最后一次响铃时间
    self.lastPlaySoundDate = [NSDate date];
    
//    // 收到消息时，播放音频
//    [[EMCDDeviceManager sharedInstance] playNewMessageSound];
//    // 收到消息时，震动
//    [[EMCDDeviceManager sharedInstance] playVibration];
}
///压缩图片
+ (UIImage *)imageCompressToData:(UIImage *)image{
    NSData *data=UIImageJPEGRepresentation(image, 1.0);
    if (data.length>300*1024) {
        if (data.length>1024*1024) {//1M以及以上
            data=UIImageJPEGRepresentation(image, 0.1);
        }else if (data.length>512*1024) {//0.5M-1M
            data=UIImageJPEGRepresentation(image, 0.5);
        }else if (data.length>300*1024) {//0.25M-0.5M
            data=UIImageJPEGRepresentation(image, 0.9);
        }
    }
    return [UIImage imageWithData:data];
}
//压缩图片到制定大小kb
+(UIImage *)scaleImage:(UIImage *)image toKb:(NSInteger)kb
{
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    //NSLog(@"Before compressing quality, image size = %ld KB",data.length/1024);
    
    if (data.length < kb) return [UIImage imageWithData:data];
    
    CGFloat max = 1;
    CGFloat min = 0;
    
    for (int i = 0; i < 6; ++i) {
        
        compression = (max + min)/2;
        
        data = UIImageJPEGRepresentation(image, compression);
        
        //NSLog(@"Compression = %.1f", compression);
        //NSLog(@"In compressing quality loop, image size = %ld KB", data.length / 1024);
        
        if (data.length < kb * 0.9) {
            
            min = compression;
        } else if (data.length > kb) {
            
            max = compression;
            
        } else {
            break;
            
        }
        
    } //NSLog(@"After compressing quality, image size = %ld KB", data.length / 1024);
    
    if (data.length < kb) return [UIImage imageWithData:data];
    
    UIImage *resultImage = [UIImage imageWithData:data];
    // Compress by size
    NSUInteger lastDataLength = 0;
    
    while (data.length > kb && data.length != lastDataLength) {
        
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)kb / data.length;
        //NSLog(@"Ratio = %.1f", ratio);
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)), (NSUInteger)(resultImage.size.height * sqrtf(ratio)));
        // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        CGFloat width = size.width;
        CGFloat height = size.height;
        
        if(width <= 0){
            
            width = 1;
        }
        if(height <= 0){
            
            height = 1;
        }
        [resultImage drawInRect:CGRectMake(0, 0, width, height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
        //NSLog(@"In compressing size loop, image size = %ld KB", data.length / 1024);
        
    } //NSLog(@"After compressing size loop, image size = %ld KB", data.length / 1024);
    UIImage *newImage = [UIImage imageWithData:data];
    
    return newImage;
}
+ (void)compressedImageFiles:(UIImage *)image
                     imageKB:(CGFloat)fImageKBytes
                  imageBlock:(void(^)(UIImage *image))block {
    
    __block UIImage *imageCope = image;
    CGFloat fImageBytes = fImageKBytes * 1024;//需要压缩的字节Byte
    
    __block NSData *uploadImageData = nil;
    
    uploadImageData = UIImagePNGRepresentation(imageCope);
    NSLog(@"图片压前缩成 %fKB",uploadImageData.length/1024.0);
    CGSize size = imageCope.size;
    CGFloat imageWidth = size.width;
    CGFloat imageHeight = size.height;
    
    if (uploadImageData.length > fImageBytes && fImageBytes >0) {
        
        dispatch_async(dispatch_queue_create("CompressedImage", DISPATCH_QUEUE_SERIAL), ^{
            
            /* 宽高的比例 **/
            CGFloat ratioOfWH = imageWidth/imageHeight;
            /* 压缩率 **/
            CGFloat compressionRatio = fImageBytes/uploadImageData.length;
            /* 宽度或者高度的压缩率 **/
            CGFloat widthOrHeightCompressionRatio = sqrt(compressionRatio);
            
            CGFloat dWidth   = imageWidth *widthOrHeightCompressionRatio;
            CGFloat dHeight  = imageHeight*widthOrHeightCompressionRatio;
            if (ratioOfWH >0) { /* 宽 > 高,说明宽度的压缩相对来说更大些 **/
                dHeight = dWidth/ratioOfWH;
            }else {
                dWidth  = dHeight*ratioOfWH;
            }
            
            imageCope = [self drawWithWithImage:imageCope width:dWidth height:dHeight];
            uploadImageData = UIImagePNGRepresentation(imageCope);
            
            NSLog(@"当前的图片已经压缩成 %fKB",uploadImageData.length/1024.0);
            //微调
            NSInteger compressCount = 0;
            /* 控制在 1M 以内**/
            while (fabs(uploadImageData.length - fImageBytes) > 1024) {
                /* 再次压缩的比例**/
                CGFloat nextCompressionRatio = 0.9;
                
                if (uploadImageData.length > fImageBytes) {
                    dWidth = dWidth*nextCompressionRatio;
                    dHeight= dHeight*nextCompressionRatio;
                }else {
                    dWidth = dWidth/nextCompressionRatio;
                    dHeight= dHeight/nextCompressionRatio;
                }
                
                imageCope = [self drawWithWithImage:imageCope width:dWidth height:dHeight];
                uploadImageData = UIImagePNGRepresentation(imageCope);
                
                /*防止进入死循环**/
                compressCount ++;
                if (compressCount == 10) {
                    break;
                }
                
            }
            
            NSLog(@"图片已经压缩成 %fKB",uploadImageData.length/1024.0);
            imageCope = [[UIImage alloc] initWithData:uploadImageData];
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                block(imageCope);
            });
        });
    }
    else
    {
        block(imageCope);
    }
}
/* 根据 dWidth dHeight 返回一个新的image**/
+ (UIImage *)drawWithWithImage:(UIImage *)imageCope width:(CGFloat)dWidth height:(CGFloat)dHeight{
    
    UIGraphicsBeginImageContext(CGSizeMake(dWidth, dHeight));
    [imageCope drawInRect:CGRectMake(0, 0, dWidth, dHeight)];
    imageCope = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCope;
    
}
//返回一个新的imageData
+(NSData *)compressWithImage:(UIImage *)image  MaxLength:(NSUInteger)maxLength{ // Compress by quality
    
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    //NSLog(@"Before compressing quality, image size = %ld KB",data.length/1024);
    
    if (data.length < maxLength) return data;
    
    CGFloat max = 1;
    CGFloat min = 0;
    
    for (int i = 0; i < 6; ++i) {
        
        compression = (max + min) / 2;
        
        data = UIImageJPEGRepresentation(image, compression);
        
        //NSLog(@"Compression = %.1f", compression);
        //NSLog(@"In compressing quality loop, image size = %ld KB", data.length / 1024);
        
        if (data.length < maxLength * 0.9) {
            
            min = compression;
        } else if (data.length > maxLength) {
            
            max = compression;
            
        } else {
            break;
            
        }
        
    } //NSLog(@"After compressing quality, image size = %ld KB", data.length / 1024);
    
    if (data.length < maxLength) return data; UIImage *resultImage = [UIImage imageWithData:data];
    // Compress by size
    NSUInteger lastDataLength = 0;
    
    while (data.length > maxLength && data.length != lastDataLength) {
        
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        //NSLog(@"Ratio = %.1f", ratio);
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)), (NSUInteger)(resultImage.size.height * sqrtf(ratio)));
        // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
        //NSLog(@"In compressing size loop, image size = %ld KB", data.length / 1024);
        
    } //NSLog(@"After compressing size loop, image size = %ld KB", data.length / 1024);
    return data;
}
@end
