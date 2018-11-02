//
//  WTShareManager.m
//  OMO_iphone
//
//  Created by wy on 2018/10/10.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "WTShareManager.h"
#import "WTShareContentItem.h"


@interface WTShareManager ()

@property (nonatomic, copy)WTShareResultlBlock shareResultlBlock;

@end

@implementation WTShareManager

static WTShareManager * _instence;

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instence = [super allocWithZone:zone];
        [_instence setRegisterApps];
    });
    return _instence;
}
+ (instancetype)shareWTShareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instence = [[self alloc]init];
        [_instence setRegisterApps];
    });
    return _instence;
}
- (id)copyWithZone:(NSZone *)zone
{
    return _instence;
}


// 注册appid
- (void)setRegisterApps{
    
    // 微信注册
    [WXApi registerApp:WX_APPID];
}



#pragma mark - 分享方法------
+ (void)wt_shareWithContent:(WTShareContentItem *)contentObj shareType:(WTShareType)shareType shareResult:(WTShareResultlBlock)shareResult
{
    WTShareManager * shareManager = [WTShareManager shareWTShareManager];
    shareManager.shareResultlBlock = shareResult;
    
    [self wt_shareWithContent:contentObj shareType:shareType];
}
+ (void)wt_shareWithContent:(WTShareContentItem *)contentObj shareType:(WTShareType)shareType
{
    [WTShareManager shareWTShareManager];
    
    switch (shareType) {
            
        case WTShareTypeWeiXinTimeline: // 微信朋友圈
        {
            //            WXMediaMessage * message = [WXMediaMessage message];
            //            message.title = contentObj.weixinPyqtitle.length >0 ? contentObj.weixinPyqtitle : contentObj.title;
            //            [message setThumbImage:contentObj.thumbImage];
            //            message.description = contentObj.summary;
            //            WXWebpageObject * ext = [WXWebpageObject object];
            //            ext.webpageUrl = contentObj.urlString;
            //            message.mediaObject = ext;
            //            SendMessageToWXReq * req = [[SendMessageToWXReq alloc]init];
            //            req.bText = NO;
            //            req.message = message;
            WXMediaMessage * message = [WXMediaMessage message];
            message.title = contentObj.title;
            [message setThumbImage:contentObj.thumbImage];
            message.description = contentObj.summary;
            if(contentObj.wxUrlString.length <= 1){
                
                WXImageObject *imageObj = [WXImageObject object];
                imageObj.imageData = UIImagePNGRepresentation(contentObj.bigImage);
                message.mediaObject = imageObj;
            }else{
                
                WXWebpageObject * ext = [WXWebpageObject object];
                ext.webpageUrl = contentObj.wxUrlString;
                message.mediaObject = ext;
            }
            SendMessageToWXReq *req = [[SendMessageToWXReq alloc]init];
            req.bText = NO;
            req.text = contentObj.title;
            req.message = message;
            req.scene = WXSceneTimeline;
            [WXApi sendReq:req];
            
            break;
        }
        case WTShareTypeWeiXinSession:
        {
            WXMediaMessage * message = [WXMediaMessage message];
            message.title = contentObj.title;
            
            [message setThumbImage:contentObj.thumbImage];
            message.description = contentObj.summary;
            if(contentObj.wxUrlString.length <= 1){
                
                WXImageObject *imageObj = [WXImageObject object];
                imageObj.imageData = UIImagePNGRepresentation(contentObj.bigImage);
                message.mediaObject = imageObj;
            }else{
                
                WXWebpageObject * ext = [WXWebpageObject object];
                ext.webpageUrl = contentObj.wxUrlString;
                message.mediaObject = ext;
            }
            SendMessageToWXReq *req = [[SendMessageToWXReq alloc]init];
            req.bText = NO;
            //            req.text = contentObj.title;
            req.message = message;
            req.scene = WXSceneSession;
            [WXApi sendReq:req];
            
            break;
        }
        default:
            break;
    }
}

#pragma mark - WXApiDelegate 从微信那边分享过来传回一些数据调用的方法

/*! @brief 发送一个sendReq后，收到微信的回应
 *
 * 收到一个来自微信的处理结果。调用一次sendReq后会收到onResp。
 * 可能收到的处理结果有SendMessageToWXResp、SendAuthResp等。
 * @param resp具体的回应内容，是自动释放的
 */
-(void) onResp:(BaseResp*)resp
{
    // 成功回来
    // errCode  0
    // type     0
    
    // 取消分享回来
    // errCode -2
    // type 0
    
    if (resp.errCode == WTShareWeiXinErrCodeSuccess) {
        
        if(self.shareResultlBlock){
            
            self.shareResultlBlock(@"1");
        }
    }else{
        
        if(self.shareResultlBlock){
            
            self.shareResultlBlock(@"0");
        }
    }
}

@end
