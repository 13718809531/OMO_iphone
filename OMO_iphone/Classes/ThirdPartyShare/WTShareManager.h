//
//  WTShareManager.h
//  OMO_iphone
//
//  Created by wy on 2018/10/10.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"

@class WTShareContentItem;

typedef NS_ENUM(NSInteger, WTShareType) {
   
    WTShareTypeWeiXinTimeline,// 朋友圈
    WTShareTypeWeiXinSession,// 微信朋友
};

typedef NS_ENUM(NSInteger, WTShareWeiXinErrCode) {
    WTShareWeiXinErrCodeSuccess = 0,   // 新浪微博
    WTShareWeiXinErrCodeCancel = -2,          // QQ好友
    
};

typedef void(^WTShareResultlBlock)(NSString * shareResult);

@interface WTShareManager : NSObject <WXApiDelegate>

+ (instancetype)shareWTShareManager;
// 判断QQ分享是否成功
+ (void)didReceiveTencentUrl:(NSURL *)url;
+ (void)wt_shareWithContent:(WTShareContentItem *)contentObj shareType:(WTShareType)shareType shareResult:(WTShareResultlBlock)shareResult;

@end
