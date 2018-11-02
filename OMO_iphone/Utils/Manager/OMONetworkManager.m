//
//  YXOMOIphoneNetworkManager.m
//  OMO_iphone
//
//  Created by 刘卫兵 on 2018/9/5.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMONetworkManager.h"
#import <AFNetworking.h>
#import "CXPUtility.h"
#import <QiniuSDK.h>
#import <sys/utsname.h>
/**  */
#import <JPUSHService.h>
/**  */
#import "OMOLoginMobileVC.h"
/** 永久保存账号 */
#import "KeychainItemWrapper.h"
static OMONetworkManager *_networkManager = nil;
static AFHTTPSessionManager *_manager;
static AFNetworkReachabilityManager *_reachabilityManager;
static QNUploadManager *_upManager;
@implementation OMONetworkManager

+ (instancetype)sharedData{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        if (_networkManager == nil) {
            
            _networkManager = [[OMONetworkManager alloc] init];
            
            _upManager = [[QNUploadManager alloc]init];
            
            _reachabilityManager = [AFNetworkReachabilityManager sharedManager];
            _manager = [AFHTTPSessionManager manager];
            
            //申明返回的结果是json类型
            _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            //如果报接受类型不一致请替换一致text/html或别的
            _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
//            [_manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//            [_manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            // 设置超时时间
//            [_manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
            _manager.requestSerializer.timeoutInterval = 10.f;
//            [_manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
            _manager.requestSerializer = [AFJSONRequestSerializer serializer];
            _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        }
    });
    return _networkManager;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    
    if (_networkManager == nil) {
        
        _networkManager = [super allocWithZone:zone];
    }
    return _networkManager;
}
- (id)copyWithZone:(NSZone *)zone{
    
    return [self copyWithZone:zone];
}
- (id)mutableCopy{
    
    return self;
}
- (void)md_NetworkReachabilityStatus{
    
    [_reachabilityManager startMonitoring];
    
    [_reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            {
                // 位置网络
                NSLog(@"位置网络");
            }
                break;
            case AFNetworkReachabilityStatusNotReachable:
            {
                // 无法联网
                NSLog(@"无法联网");
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                // 手机自带网络
                NSLog(@"当前在WIFI网络下");
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                // WIFI
                NSLog(@"当前使用的是2G/3G/4G网络");
            }
        }
    }];
}
/**
 *  组合成一个通用的des字符串
 *
 *  @param body body参数
 *
 *  @return 返回des_str
 */
- (NSDictionary *)getDesRequestWithBody:(NSDictionary *)body action:(NSString *)action
{
    NSString *date = [NSString_Utils md_currentDateString];
    //    NSString *des = [CXPUtility encryptStr:date];
    NSMutableDictionary *head = [[NSMutableDictionary alloc]init];
    [head setObject:@"iOS" forKey:@"client_id"];
    NSString *user_id = [OMOIphoneManager sharedData].user_id;
    [head setObject:checkNull(user_id) forKey:@"user_id"];
    [head setObject:@"1.0.0" forKey:@"softname"];// 版本号
    [head setObject:@"AppStore" forKey:@"channel_id"];// 下载渠道
    [head setObject:[NSString stringWithFormat:@"%.f*%.f",SCREENH,SCREENW] forKey:@"screen"];// 手机系统版本
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    [head setObject:phoneVersion forKey:@"os"];// 手机系统版本
    [head setObject:@"1" forKey:@"softver"];//
    NSString *deviceModelName = [self deviceModelName]; //获取设备的型号 例如：iPhone
    [head setObject:deviceModelName forKey:@"ua"];
    /** 初始化一个保存用户帐号的KeychainItemWrapper */
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"UserAccessToken" accessGroup:nil];
    //从keychain里取出值
    NSString *device_id = [wrapper objectForKey:(id)kSecValueData];
    
    [head setObject:checkNull(device_id) forKey:@"device_id"];
    NSString *session_id = [OMOIphoneManager sharedData].session_id;
    [head setObject:checkNull(session_id) forKey:@"session_id"];
    [head setObject:date forKey:@"timestamp"];
    [head setObject:action forKey:@"action"];
    
    NSDictionary *root;
    
    if(body == nil){
        
        root = [NSDictionary dictionaryWithObjectsAndKeys:head,@"head",[NSDictionary dictionary],@"body", nil];
    }else{
        
        root = [NSDictionary dictionaryWithObjectsAndKeys:head,@"head",body,@"body", nil];
    }
    NSDictionary *postData = [NSDictionary dictionaryWithObject:root forKey:@"root"];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:postData options:NSJSONWritingPrettyPrinted error:nil];

#ifdef DEBUG
    NSString *jsonStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
//    return jsonStr;
#else
    NSString *jsonStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    jsonStr = [CXPUtility encryptStr:jsonStr];
//    return jsonStr;
#endif
    return postData;
}
#pragma mark ---------- 将data数据转换为json
- (NSDictionary *)md_respesonWithData:(id)responseObject{
    
    NSString *strDesJson = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
    
    NSString *strJson = [CXPUtility decryptStr:strDesJson];
    //    NSLog([NSString stringWithFormat:@"%d-%@",__LINE__,strJson]);
    //    NSData *dataJson = [strDesJson dataUsingEncoding:NSUTF8StringEncoding];
    NSData *dataJson = [strJson dataUsingEncoding:NSUTF8StringEncoding];
    if (dataJson == nil) {
        return nil;
    }
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:dataJson options:NSJSONReadingAllowFragments error:nil];
    
    return dic;
}
#pragma mark ---------- 取消所有正在进行的请求 --------------
+ (void)yh_cancelingTasks{
    
    if(_manager.tasks.count > 0){
        
        [_manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    }
}

#pragma mark -- GET请求 --
- (void)getWithURLString:(NSString *)URLString
              parameters:(id)parameters
                 success:(void (^)(id))success
                 failure:(void (^)(NSError *))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    /**
     *  可以接受的类型
     */
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    /**
     *  请求队列的最大并发数
     */
    //    manager.operationQueue.maxConcurrentOperationCount = 5;
    /**
     *  请求超时的时间
     */
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [manager GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            if ([responseObject isKindOfClass:[NSData class]]) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                [MBProgress hideAllHUD];
                if ([dic[@"code"] isEqualToString:@"10000"]) {
                    if (success) {
                        success(dic);
                    }
                }else if ([dic[@"code"]isEqualToString:@"10001"]){
                    [MBProgress showInfoMessage:@"登录过期,请重新登录"];
                }else if ([dic[@"code"]isEqualToString:@"10002"]){
                    [MBProgress showInfoMessage:@"参数不正确"];
                }else if ([dic[@"code"]isEqualToString:@"10003"]){
                    [MBProgress showInfoMessage:@"网络超时，请稍后重试！"];
                }else{
                    [MBProgress showInfoMessage:dic[@"msg"]];
                }
                
            }else if ([responseObject isKindOfClass:[NSDictionary class]]){
                if (success) {
                    [MBProgress hideAllHUD];
                    success(responseObject);
                }
            }
        }else{
            NSLog(@"空数据");
            [MBProgress hideAllHUD];
            [MBProgress showInfoMessage:@"服务器异常"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
            NSLog(@"请求错误:%@",error);
            [MBProgress hideAllHUD];
            [MBProgress showInfoMessage:@"请求错误"];
        }
    }];
}

#pragma mark -- POST请求 --
- (void)postWithURLString:(NSString *)URLString
               parameters:(id)parameters
                  success:(void (^)(id))success
                  failure:(void (^)(NSError *))failure {
    
    [MBProgress showStatus:@""];
    
    NSDictionary *paramStr = [self getDesRequestWithBody:parameters action:URLString];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:paramStr options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",jsonStr);
    NSString *device_id = [OMOIphoneManager sharedData].device_id;
    NSLog(@"device_token =========== %@",device_id);
    
    [_manager POST:KBaseUrl parameters:paramStr progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [MBProgress hideAllHUD];
        
        if (responseObject) {

            if ([responseObject isKindOfClass:[NSData class]]) {
                
                NSError * error = [[NSError alloc] init];
                
                NSString *strDesJson = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
            
#ifdef DEBUG
            
                NSData *dataJson = [strDesJson dataUsingEncoding:NSUTF8StringEncoding];
#else
            
                NSString *strJson = [CXPUtility decryptStr:strDesJson];
                NSData *dataJson = [strJson dataUsingEncoding:NSUTF8StringEncoding];
#endif
            
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:dataJson options:NSJSONReadingMutableContainers error:&error];
            
                NSDictionary *root = [dic valueForKey:@"root"];
            
                NSDictionary *head = [root valueForKey:@"head"];
            
                if([head[@"code"] integerValue] == 200){
                    
                    NSDictionary *body = [root valueForKey:@"body"];
                    
                    NSDictionary *dataSouce = [body valueForKey:@"data"];
                    
                    if(success){
                        
                        success(dataSouce);
                    }
                }else if([head[@"code"] integerValue] == 400){
                    
                    [MBProgress showInfoMessage:head[@"text"]];
                    if(success){
                        
                        success(nil);
                    }
                }else if ([head[@"code"] integerValue] == 1000){
                    
                    [self omo_deleteThirdParty];
                    
                    OMOLoginMobileVC *loginMobileVC = [[OMOLoginMobileVC alloc]init];
                    [[OMOIphoneManager getCurrentVC].navigationController pushViewController:loginMobileVC animated:YES];
                }
            }else if ([responseObject isKindOfClass:[NSDictionary class]]){
                if (success) {
                    [MBProgress hideAllHUD];
                    success(responseObject);
                }
            }
        }else{
            
            [MBProgress showInfoMessage:@"网络超时，请稍后重试！"];
            if(success){
                
                success(nil);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [MBProgress hideAllHUD];
        if (failure) {
            failure(error);
            NSLog(@"请求错误:%@",error);
            [MBProgress showErrorMessage:@"网络超时，请稍后重试！"];
        }
    }];
}

#pragma mark -- POST/GET网络请求 --
- (void)requestWithURLString:(NSString *)URLString
                  parameters:(id)parameters
                        type:(HttpRequestType)type
                     success:(void (^)(id))success
                     failure:(void (^)(NSError *))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    switch (type) {
        case HttpRequestTypeGet:
        {
            [manager GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
        }
            break;
        case HttpRequestTypePost:
        {
            [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
        }
            break;
    }
}

- (void)uploadWithURLString:(NSString *)URLString parameters:(id)parameters uploadParams:(NSArray<YXUploadParam *> *)uploadParams success:(void (^)())success failure:(void (^)(NSError *))failure {
    
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [_manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (YXUploadParam *uploadParam in uploadParams) {
            [formData appendPartWithFileData:uploadParam.data name:uploadParam.name fileName:uploadParam.filename mimeType:uploadParam.mimeType];
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - 下载数据
- (void)downLoadWithURLString:(NSString *)URLString parameters:(id)parameters progerss:(void (^)())progress success:(void (^)())success failure:(void (^)(NSError *))failure {
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    NSURLSessionDownloadTask *downLoadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progress) {
            progress();
        }
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return targetPath;
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (failure) {
            failure(error);
        }
    }];
    [downLoadTask resume];
}

-(void)uploadAvavarData:(NSArray *)images success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *, NSString *))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //    NSString *url = @"http://file.jhjvip.cn:8888/image-server/uploadImage/oss";
    NSString *url = @"https://www.uhuijia.com.cn/image-server/uploadImage/oss";
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (UIImage *image in images) {
            NSData *data = UIImageJPEGRepresentation(image,0.5);
            [formData appendPartWithFileData:data name:@"file" fileName:@"image.jpeg" mimeType:@"image/jpeg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task, error,error.localizedDescription);
        }
    }];
}
-(void)uploadPersonalInformation:(NSString *)stitchingStr parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *, NSString *))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/json"];
    NSString *url = [NSString stringWithFormat:KBaseUrl@"/users/%@",stitchingStr];
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task,error,error.localizedDescription);
        }
    }];
}

#pragma MARK --------------- 音视频请求 --------------
+(void)getUrl:(NSString *)url
         body:(id)body
       result:(FMResult)result
   headerFile:(NSDictionary *)headerFile
      success:(void (^)(id result))success
      failure:(void (^)(NSError *error))failure{
    //1.获取网络请求管理类
    // 使用这个方法会产生内存泄露，改用单利创建，可以避免
    
    ///给网址添加头///可能会用到
    //3.对网络请求加请求头
    if (headerFile) {
        for (NSString *key in headerFile.allKeys) {
            [_manager.requestSerializer setValue:headerFile[key] forHTTPHeaderField:key];
        }
    }
    //4.网络请求返回值的类型
    switch (result) {
        case FMData:
            ///返回NSData
            _manager.responseSerializer=[AFHTTPResponseSerializer serializer];
            break;
        case FMJSON:
            ///返回JSON类型
            _manager.responseSerializer=[AFJSONResponseSerializer serializer];
            break;
        case FMXML:
            ///返回XML数据
            _manager.responseSerializer=[AFXMLParserResponseSerializer serializer];
            break;
        default:
            break;
    }
    //2.设置网络请求返回值支持类型
    [_manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/plain", nil]];
    
    //    if (manager.reachabilityManager.networkReachabilityStatus!=AFNetworkReachabilityStatusNotReachable) {
    //5.发送网络请求
    [_manager GET:url parameters:body progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            failure(error);
        }
    }];
}

+(void)postUrl:(NSString *)url
          body:(id)body
        result:(FMResult)result
  requsetStyle:(FMRequestStyle)requestStyle
    headerFile:(NSDictionary *)headerFile
       success:(void (^)(id result))success
       failure:(void (^)(NSError *error))failure{
    //1.获取网络请求管理类
    
    //3.发送数据类型
    switch (requestStyle) {
        case FMRequestJSON:
            ///返回NSData
            _manager.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        case FMRequestString:
            [_manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, id parameters, NSError *__autoreleasing *error) {
                return parameters;
            }];
        default:
            break;
    }
    //4.给网络请求添加请求头///可能会用到
    if (headerFile) {
        for (NSString *key in headerFile.allKeys) {
            [_manager.requestSerializer setValue:headerFile[key] forHTTPHeaderField:key];
        }
    }
    //5.网络请求返回值的类型
    switch (result) {
        case FMData:
            ///返回NSData
            _manager.responseSerializer=[AFHTTPResponseSerializer serializer];
            break;
        case FMJSON:
            ///返回JSON类型
            _manager.responseSerializer=[AFJSONResponseSerializer serializer];
            break;
        case FMXML:
            ///返回XML数据
            _manager.responseSerializer=[AFXMLParserResponseSerializer serializer];
            break;
        default:
            break;
    }
    //2.设置网络请求返回值支持的参数类型
    [_manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/plain", nil]];
    //6.发送网络请求
    [_manager POST:url parameters:body progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            //成功回调
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            //失败回调
            failure(error);
        }
    }];
}
#pragma mark -------- 上传图片到七牛 -----------
- (void)omo_putImage:(UIImage *)image
                 key:(NSString *)key
             success:(void (^)(id result))success
             failure:(void (^)(NSError *error))failure{
    
    [self postWithURLString:@"30000" parameters:nil success:^(id responseObject) {
        
        if(responseObject){
            
            NSDictionary *dict = (NSDictionary *)responseObject;
            
            NSString *qn_token = dict[@"qn_token"];
            NSString *resource_url = dict[@"resource_url"];
            
            if(qn_token.length > 0 && resource_url.length > 0){
                
                UIImage *newImage = image;
                
                if(image.size.height > IFFitFloat6(80) || image.size.width > IFFitFloat6(80)){
                    
                    newImage = [image scaleImageToSize:CGSizeMake(IFFitFloat6(80), IFFitFloat6(80))];
                }
                NSData *data = UIImagePNGRepresentation(newImage);
                
                //    QNUploadOption *uploadOption = [[QNUploadOption alloc] initWithMime:nil progressHandler:^(NSString *key, float percent) {
                ////        NSLog(@"上传进度 %.2f", percent);
                //    }params:nil
                //                                                               checkCrc:NO
                //                                                     cancellationSignal:nil];
                if(!data)return;
                
                [_upManager putData:data key:key token:qn_token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                    
                    if(resp[@"hash"]){
                        
                        NSString *headImguRL = [NSString stringWithFormat:@"%@/%@",resource_url,key];
                        NSLog(@"headImguRL = %@",headImguRL);
                        
                        NSDictionary *dict = @{@"avatar_url":headImguRL};
                        
                        [self postWithURLString:@"20001" parameters:dict success:^(id responseObject) {
                            
                            if(responseObject){
                                
                                NSDictionary *dataSouce = (NSDictionary *)responseObject;
                                
                                if(success){
                                    
                                    success(dataSouce);
                                }
                            }
                        } failure:^(NSError *error) {
                            
                            [MBProgress showErrorMessage:@"图片上传失败,请稍后再试"];
                        }];
                    }
                } option:nil];
            }else{
                
                [MBProgress showErrorMessage:@"图片上传失败,请稍后再试"];
            }
        }
    } failure:^(NSError *error) {
        
        [MBProgress showErrorMessage:@"图片上传失败,请稍后再试"];
    }];
}
//#pragma mark --------- 网络请求 ----------
//- (NSDictionary *)md_requestDataSouceWithParameters:(id)parameters Action:(int)action{
//
//    [MBProgress showStatus:@""];
//
//    NSURL *url = [NSURL URLWithString:KBaseUrl];
//
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//
//    NSString *paramStr = [self getDesRequestWithBody:parameters action:action];
//
//    NSMutableData *data = [NSMutableData dataWithData:[paramStr dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]];
//
//    [request setHTTPBody:data];
//    request.timeoutInterval = 10.0;
//    if (@available(iOS 11.0, *)) {
//        request.accessibilityContainerType = 1;
//    } else {
//
//    }
//    [request setHTTPMethod:@"POST"];
//    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    NSURLResponse *response ;
//    NSError *error;
//
//    NSData *dataSouce = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//
//    [MBProgress hideAllHUD];
//
//    if (error.code == NSURLErrorTimedOut) {
//
//        return nil;
//    }
//    if (dataSouce == nil) {
//
//        return nil;
//    }
//    NSString *strDesJson = [[NSString alloc]initWithData:dataSouce encoding:NSUTF8StringEncoding];
//
//#ifdef DEBUG
//
//    NSData *dataJson = [strDesJson dataUsingEncoding:NSUTF8StringEncoding];
//#else
//
//    NSString *strJson = [CXPUtility decryptStr:strDesJson];
//    NSData *dataJson = [strJson dataUsingEncoding:NSUTF8StringEncoding];
//#endif
//    if (dataJson == nil) {
//
//        return nil;
//    }
//
//    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:dataJson options:NSJSONReadingMutableContainers error:&error];
//
//    NSDictionary *root = [dic valueForKey:@"root"];
//
//    NSDictionary *head = [root valueForKey:@"head"];
//
//    if([head[@"code"] integerValue] == 200){
//
//        NSDictionary *body = [root valueForKey:@"body"];
//
//        NSDictionary *dataSouce = [body valueForKey:@"data"];
//
//        if(dataSouce){
//
//            return dataSouce;
//        }else{
//
//            return nil;
//        }
//    }else{
//
//        [MBProgress showInfomationWithMessage:[head valueForKey:@"text"] duration:lwb_duration];
//        return nil;
//    }
//}
#pragma mark --------- 异地登录 -----------
- (void)omo_deleteThirdParty{
    
    [OMOIphoneManager sharedData].user_id = @"";
    [OMOIphoneManager sharedData].mobile = @"";
    [OMOIphoneManager sharedData].avatar_url = @"";
    
    // 退出激光
    NSString *mobile = [OMOIphoneManager sharedData].mobile;
    [JPUSHService deleteTags:[NSSet setWithObject:mobile] completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
        
    } seq:0];
    
    // 退出网易
    [[NIMSDK sharedSDK].loginManager logout:^(NSError * _Nullable error) {
        
        if(error){
            
            [MBProgress showErrorMessage:@"退出网易失败"];
        }
    }];
    
    OMOLoginMobileVC *loginMobileVC = [[OMOLoginMobileVC alloc]init];
    [[OMOIphoneManager getCurrentVC].navigationController pushViewController:loginMobileVC animated:YES];
}
#pragma mark -------- 判断设备型号 -----------
- (NSString *)deviceModelName {
    
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([deviceModel isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if ([deviceModel isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([deviceModel isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (GSM)";
    if ([deviceModel isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (GSM)";
    if ([deviceModel isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    if ([deviceModel isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    if ([deviceModel isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    if ([deviceModel isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    if ([deviceModel isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    // 日行两款手机型号均为日本独占，可能使用索尼FeliCa支付方案而不是苹果支付
    if ([deviceModel isEqualToString:@"iPhone9,1"]) return @"国行、日版、港行iPhone 7";
    if ([deviceModel isEqualToString:@"iPhone9,2"]) return @"港行、国行iPhone 7 Plus";
    if ([deviceModel isEqualToString:@"iPhone9,3"]) return @"美版、台版iPhone 7";
    if ([deviceModel isEqualToString:@"iPhone9,4"]) return @"美版、台版iPhone 7 Plus";
    if ([deviceModel isEqualToString:@"iPhone10,1"]) return @"iPhone_8";
    if ([deviceModel isEqualToString:@"iPhone10,4"]) return @"iPhone_8";
    if ([deviceModel isEqualToString:@"iPhone10,2"]) return @"iPhone_8_Plus";
    if ([deviceModel isEqualToString:@"iPhone10,5"]) return @"iPhone_8_Plus";
    if ([deviceModel isEqualToString:@"iPhone10,3"]) return @"iPhone_X";
    if ([deviceModel isEqualToString:@"iPhone10,6"]) return @"iPhone_X";
    if ([deviceModel isEqualToString:@"iPod1,1"]) return @"iPod Touch 1G";
    if ([deviceModel isEqualToString:@"iPod2,1"]) return @"iPod Touch 2G";
    if ([deviceModel isEqualToString:@"iPod3,1"]) return @"iPod Touch 3G";
    if ([deviceModel isEqualToString:@"iPod4,1"]) return @"iPod Touch 4G";
    if ([deviceModel isEqualToString:@"iPod5,1"]) return @"iPod Touch (5 Gen)";
    if ([deviceModel isEqualToString:@"iPad1,1"]) return @"iPad";
    if ([deviceModel isEqualToString:@"iPad1,2"]) return @"iPad 3G";
    if ([deviceModel isEqualToString:@"iPad2,1"]) return @"iPad 2 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,2"]) return @"iPad 2";
    if ([deviceModel isEqualToString:@"iPad2,3"]) return @"iPad 2 (CDMA)";
    if ([deviceModel isEqualToString:@"iPad2,4"]) return @"iPad 2";
    if ([deviceModel isEqualToString:@"iPad2,5"]) return @"iPad Mini (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,6"]) return @"iPad Mini";
    if ([deviceModel isEqualToString:@"iPad2,7"]) return @"iPad Mini (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad3,1"]) return @"iPad 3 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,2"]) return @"iPad 3 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad3,3"]) return @"iPad 3";
    if ([deviceModel isEqualToString:@"iPad3,4"]) return @"iPad 4 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,5"]) return @"iPad 4";
    if ([deviceModel isEqualToString:@"iPad3,6"]) return @"iPad 4 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad4,1"]) return @"iPad Air (WiFi)";
    if ([deviceModel isEqualToString:@"iPad4,2"]) return @"iPad Air (Cellular)";
    if ([deviceModel isEqualToString:@"iPad4,4"]) return @"iPad Mini 2 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad4,5"]) return @"iPad Mini 2 (Cellular)";
    if ([deviceModel isEqualToString:@"iPad4,6"]) return @"iPad Mini 2";
    if ([deviceModel isEqualToString:@"iPad4,7"]) return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad4,8"]) return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad4,9"]) return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad5,1"]) return @"iPad Mini 4 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad5,2"]) return @"iPad Mini 4 (LTE)";
    if ([deviceModel isEqualToString:@"iPad5,3"]) return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"iPad5,4"]) return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"iPad6,3"]) return @"iPad Pro 9.7";
    if ([deviceModel isEqualToString:@"iPad6,4"]) return @"iPad Pro 9.7";
    if ([deviceModel isEqualToString:@"iPad6,7"]) return @"iPad Pro 12.9";
    if ([deviceModel isEqualToString:@"iPad6,8"]) return @"iPad Pro 12.9";
    if ([deviceModel isEqualToString:@"AppleTV2,1"]) return @"Apple TV 2";
    if ([deviceModel isEqualToString:@"AppleTV3,1"]) return @"Apple TV 3";
    if ([deviceModel isEqualToString:@"AppleTV3,2"]) return @"Apple TV 3"; if ([deviceModel isEqualToString:@"AppleTV5,3"]) return @"Apple TV 4";
    if ([deviceModel isEqualToString:@"i386"]) return @"Simulator";
    if ([deviceModel isEqualToString:@"x86_64"]) return @"Simulator"; return deviceModel;
}
@end
