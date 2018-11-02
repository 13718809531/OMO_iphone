//
//  YXOMOIphoneManager.h
//  OMO_iphone
//
//  Created by 刘卫兵 on 2018/9/5.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OMOIphoneManager : NSObject

+ (instancetype)sharedData;
// 根据服务器数据初始化对象
+ (void)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic,copy)NSString         *user_id;/** 用户id */
@property (nonatomic,copy)NSString         *session_id;/** 服务器上的关联加密码 */
@property (nonatomic,copy)NSString         *mobile;/** 服务器上的员工手机号 */
@property (nonatomic,copy)NSString         *gender;/** 性别 */
@property (nonatomic,copy)NSString         *id_card_no;/** 身份证号 */
@property (nonatomic,copy)NSString         *birthday;/** 生日 */
@property (nonatomic,assign)NSInteger      age; /**  */;/** 年龄 */
@property (nonatomic,copy)NSString         *nickname;/** 登录的用户名 */
@property (nonatomic,copy)NSString         *realname;/** 姓名 */
@property (nonatomic,copy)NSString         *avatar_url;/** 头像url */
@property (nonatomic,assign)BOOL            is_userinfo; /** 是否绑定微信 */
@property (nonatomic,copy)NSString         *device_id;/** 设备信息 */
@property (nonatomic,copy)NSString         *height;/** 身高 */
@property (nonatomic,copy)NSString         *weight;/** 体重 */
@property (nonatomic,copy)NSString         *kangFuBao_name;/** 记录康复包name,视频缓存需要 */
/** 部位id */
@property (nonatomic,copy)NSString *cate_id;
/** 部位name */
@property (nonatomic,copy)NSString *cate_name;
/** 服务项 */
@property (nonatomic,copy)NSString *type_id;
/** 服务id */
@property (nonatomic,copy)NSString *acography_id;
/** 本次评估答过的题 */
@property (nonatomic, strong)NSMutableArray *daTiIds;

/** 最后一次响铃时间 */
@property (nonatomic, strong)NSDate *lastPlaySoundDate;

/**
 *  centent: 通知标题
 *
 *  body   : 详细信息
*/
- (void)sf_setLocalNotificationAlertCentent:(NSString *)centent CenterBody:(NSDictionary *)body;
//获取当前控制器
+ (UIViewController *)getCurrentVC;
/**
 *  加载视图
 */
///压缩图片
+ (UIImage *)imageCompressToData:(UIImage *)image;
//压缩图片到制定大小kb
+(UIImage *)scaleImage:(UIImage *)image toKb:(NSInteger)kb;

+ (void)compressedImageFiles:(UIImage *)image
                     imageKB:(CGFloat)fImageKBytes
                  imageBlock:(void(^)(UIImage *image))block;

/* 根据 dWidth dHeight 返回一个新的image**/
+ (UIImage *)drawWithWithImage:(UIImage *)imageCope width:(CGFloat)dWidth height:(CGFloat)dHeight;
//返回一个新的imageData
+(NSData *)compressWithImage:(UIImage *)image  MaxLength:(NSUInteger)maxLength;

@end
