//
//  YXNetworkManager.h
//  OMO_iphone
//
//  Created by 刘卫兵 on 2018/9/5.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YXUploadParam.h"

// 返回值的数据类型枚举
typedef enum : NSUInteger {
    FMData,
    FMJSON,
    FMXML,
} FMResult;

// 网络请求Body的类型枚举
typedef enum : NSUInteger {
    FMRequestJSON,
    FMRequestString,
} FMRequestStyle;

/**
 *  网络请求类型
 */
typedef NS_ENUM(NSUInteger,HttpRequestType) {
    /**
     *  get请求
     */
    HttpRequestTypeGet = 0,
    /**
     *  post请求
     */
    HttpRequestTypePost = 1
};

@interface OMONetworkManager : NSObject

+ (instancetype)sharedData;

/**
 *  发送get请求
 *
 *  @param URLString  请求的网址字符串
 *  @param parameters 请求的参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
- (void)getWithURLString:(NSString *)URLString
              parameters:(id)parameters
                 success:(void (^)(id responseObject))success
                 failure:(void (^)(NSError *error))failure;

/**
 *  发送post请求
 *
 *  @param URLString  请求的网址字符串
 *  @param parameters 请求的参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
- (void)postWithURLString:(NSString *)URLString
               parameters:(id)parameters
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(NSError *error))failure;

/**
 *  发送网络请求
 *
 *  @param URLString   请求的网址字符串
 *  @param parameters  请求的参数
 *  @param type        请求的类型
 *  @param resultBlock 请求的结果
 */
- (void)requestWithURLString:(NSString *)URLString
                  parameters:(id)parameters
                        type:(HttpRequestType)type
                     success:(void (^)(id responseObject))success
                     failure:(void (^)(NSError *error))failure;

/**
 *  上传图片
 *
 *  @param URLString   上传图片的网址字符串
 *  @param parameters  上传图片的参数
 *  @param uploadParam 上传图片的信息
 *  @param success     上传成功的回调
 *  @param failure     上传失败的回调
 */
- (void)uploadWithURLString:(NSString *)URLString
                 parameters:(id)parameters
                uploadParams:(NSArray <YXUploadParam *> *)uploadParams
                    success:(void (^)())success
                    failure:(void (^)(NSError *error))failure;

/**
 *  二进制流上传图片
 *
 *  @param parameters  上传图片二进制
 *  @param success     上传成功的回调
 *  @param failure     上传失败的回调
 */
- (void)uploadAvavarData:(NSArray *)images success:(void(^)(NSURLSessionDataTask *task, id responObject))success
                 failure:(void(^)(NSURLSessionDataTask *task, NSError *error, NSString *errMsg))failure;
/**
 *  下载数据
 *
 *  @param URLString   下载数据的网址
 *  @param parameters  下载数据的参数
 *  @param success     下载成功的回调
 *  @param failure     下载失败的回调
 */
- (void)downLoadWithURLString:(NSString *)URLString
                   parameters:(id)parameters
                     progerss:(void (^)())progress
                      success:(void (^)())success
                      failure:(void (^)(NSError *error))failure;

/**
 *  上传个人信息
 *
 *  @param stitchingStr  接口末尾拼接
 *  @param parameters  下载数据的参数
 *  @param success     下载成功的回调
 *  @param failure     下载失败的回调
 */
- (void)uploadPersonalInformation:(NSString *)stitchingStr
                       parameters:(id)parameters
                          success:(void(^)(NSURLSessionDataTask *task, id responObject))success
                          failure:(void(^)(NSURLSessionDataTask *task, NSError *error, NSString *errMsg))failure;
/**
 *  Get请求
 *
 *  @param url        网络请求地址
 *  @param body       请求体
 *  @param result     返回值的数据类型
 *  @param headerFile 请求头
 *  @param success    网络请求成功回调覅
 *  @param failure    网络请求失败回调
 */
+ (void)getUrl:(NSString *)url
          body:(id)body
        result:(FMResult)result
    headerFile:(NSDictionary *)headerFile
       success:(void (^)(id result))success
       failure:(void (^)(NSError *error))failure;

/**
 *  post请求
 *
 *  @param url          网络请求地址
 *  @param body         请求体
 *  @param result       返回值数据类型
 *  @param requestStyle 网络请求Body的类型
 *  @param headerFile   网络请求头
 *  @param success      成功回调
 *  @param failure      失败回调
 */
+(void)postUrl:(NSString *)url
          body:(id)body
        result:(FMResult)result
  requsetStyle:(FMRequestStyle)requestStyle
    headerFile:(NSDictionary *)headerFile
       success:(void (^)(id result))success
       failure:(void (^)(NSError *error))failure;

/**
 *  上传图片到七牛
 *  @param image        需要上传的图片
 *  @param key          图片标识符
 *  @param success      成功回调
 *  @param failure      失败回调
 */
- (void)omo_putImage:(UIImage *)image
          key:(NSString *)key
       success:(void (^)(id result))success
       failure:(void (^)(NSError *error))failure;

/**
 ** 取消所有正在进行的数据请求
 ***/
+ (void)yh_cancelingTasks;

@end
