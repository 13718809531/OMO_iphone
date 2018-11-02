//
//  NSString_Utils.h
//  JXYH
//
//  Created by 刘卫兵 on 2017/11/29.
//  Copyright © 2017年 友惠家(北京)信息科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString_Utils : NSString

/**
 *  校验邮箱格式
 *
 *  @param email 需要校验的邮箱
 *
 *  @return 返回结果
 */
+(BOOL) isValidateEmail:(NSString *)email;
/**
 *  校验手机号格式
 *
 *  @param mobile 手机号
 *
 *  @return 结果
 */
+(BOOL) isValidateMobile:(NSString *)mobile;
/**
 *  校验车牌号
 *
 *  @param carNo 车牌号
 *
 *  @return 结果
 */
+(BOOL) isValidateCarNo:(NSString*)carNo;
/**
 判断是否是有效的中文名
 
 @param realName 名字
 @return 如果是在如下规则下符合的中文名则返回`YES`，否则返回`NO`
 限制规则：
 1. 首先是名字要大于2个汉字，小于8个汉字
 2. 如果是中间带`{•|·}`的名字，则限制长度15位（新疆人的名字有15位左右的，之前公司实名认证就遇到过），如果有更长的，请自行修改长度限制
 3. 如果是不带小点的正常名字，限制长度为8位，若果觉得不适，请自行修改位数限制
 *PS: `•`或`·`具体是那个点具体处理需要注意*
 */
+ (BOOL)isVaildRealName:(NSString *)realName;
/**
 *  校验身份证号
 *
 *  @param idCardNo 身份证号
 *
 *  @return 结果
 */
+(BOOL) isValidateIDCardNo:(NSString *)idCardNo;
/**
 *  获取设备版本号
 *
 *  @return 结果
 */
+(CGFloat)yh_getIphoneVersion;
/**
 *  获取手机型号
 *
 *  @return 结果
 */
+(NSString *)yh_iphoneType;

/**
 *  /判断是否为整形
 *
 *
 *  @return 结果
 */
+ (BOOL)isPureInt:(NSString*)string;
/**
 *  /判断是否为浮点型
 *
 *
 *  @return 结果
 */
+ (BOOL)isPureFloat:(NSString*)string;
/**
 *  /判断是否为两位数浮点型
 *
 *
 *  @return 结果
 */
+(BOOL)isValidateMoney:(NSString *)money;

/**
 *    /判断是否是纯汉字
 *
 *
 * @return 结果
 */
+ (BOOL)isChinese:(NSString *)text;

/**
 *    /判断是否含有汉字
 *
 *
 * @return 结果
 */
+ (BOOL)includeChinese:(NSString *)text;

#pragma mark -------- 返回当前时间字符串 --------
+ (NSString *)md_currentDateString;

@end
