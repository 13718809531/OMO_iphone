//
//  OMOWXLoginView.m
//  OMO_iphone
//
//  Created by wy on 2018/9/30.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOWXLoginView.h"
#import <WXApi.h>
#import <AFNetworking.h>
#import "OMOBindingMobileVC.h"
#import "AppDelegate.h"
// 引入 JPush 功能所需头文件
#import "JPUSHService.h"

@interface OMOWXLoginView()<thridDelegate>{
    
     AppDelegate*_appdelegate;
}

@property (nonatomic, strong)UIView *leftLineView;
@property (nonatomic, strong)UIView *rightLineView;
@property (nonatomic, strong)UILabel *wxTitleLab;
@property(strong,nonatomic)UIButton *wxLoginbtn;// 微信登录
@property (nonatomic, strong)NSDictionary *wxUserInfo;

@end

@implementation OMOWXLoginView

- (instancetype)init{
    
    if(self = [super init]){
        
        self.frame = CGRectMake(0, SCREENH - IFFitFloat6(200), SCREENW, IFFitFloat6(200));
        self.backgroundColor = WHITECOLORA(1);
        [self addSubview:self.leftLineView];
        [self addSubview:self.wxTitleLab];
        [self addSubview:self.rightLineView];
        [self addSubview:self.wxLoginbtn];
    }
    return self;
}
- (UIView *)leftLineView{
    
    if(_leftLineView == nil){
        
        _leftLineView = [[UIView alloc]init];
        _leftLineView.backgroundColor = DetailColor;
        _leftLineView.lwb_x = lwb_pblicX + lwb_margin;
        CGFloat width = self.wxTitleLab.lwb_x - lwb_margin - lwb_pblicX - lwb_margin;
        _leftLineView.lwb_width = width;
        _leftLineView.lwb_height = 1;
        _leftLineView.lwb_centerY = self.wxTitleLab.lwb_centerY;
    }
    return _leftLineView;
}
- (UILabel *)wxTitleLab{
    
    if(_wxTitleLab == nil){
        
        _wxTitleLab = [[UILabel alloc]init];
        _wxTitleLab.text = @"微信登录";
        [_wxTitleLab sizeToFit];
        _wxTitleLab.lwb_y = lwb_margin * 2;
        _wxTitleLab.lwb_centerX = self.lwb_centerX;
        _wxTitleLab.textColor = textColour;
        _wxTitleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _wxTitleLab;
}
- (UIView *)rightLineView{
    
    if(_rightLineView == nil){
        
        _rightLineView = [[UIView alloc]init];
        _rightLineView.backgroundColor = DetailColor;
        _rightLineView.lwb_x = self.wxTitleLab.lwb_right + lwb_margin;
        CGFloat width = SCREENW - _rightLineView.lwb_x - lwb_margin - lwb_pblicX;
        _rightLineView.lwb_width = width;
        _rightLineView.lwb_height = 1;
        _rightLineView.lwb_centerY = self.wxTitleLab.lwb_centerY;
    }
    return _rightLineView;
}
- (UIButton *)wxLoginbtn{
    
    if(!_wxLoginbtn){
        
        _wxLoginbtn = [[UIButton alloc]init];
        [_wxLoginbtn setImage:[UIImage imageNamed:@"login_icon_weixin"] forState:UIControlStateNormal];
        _wxLoginbtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_wxLoginbtn setTitleColor:WHITECOLORA(1) forState:UIControlStateNormal];
        [_wxLoginbtn addTarget:self action:@selector(loginWechat) forControlEvents:UIControlEventTouchUpInside];
        [_wxLoginbtn sizeToFit];
        _wxLoginbtn.lwb_y = self.wxTitleLab.lwb_bottom + IFFitFloat6(lwb_margin * 2);
        _wxLoginbtn.lwb_centerX = self.lwb_centerX;
    }
    return _wxLoginbtn;
}

#pragma mark -------- 微信登录 -----------
-(void)loginWechat
{
    if ([WXApi isWXAppInstalled]) {
        
        SendAuthReq *req = [[SendAuthReq alloc] init];
        req.scope = @"snsapi_userinfo";
        req.state = @"App";
        [WXApi sendReq:req];
        _appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        _appdelegate.thirdDelegate = self;
    }else {
        
        [MBProgress showInfoMessage:@"请先安装微信"];
    }
}
#pragma mark 微信登录回调。
-(void)loginSuccessByCode:(NSString *)code{
    
    __weak typeof(self) weakSelf = self;
    
    [MBProgress showStatus:@"登录中..."];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];//请求
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//响应
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", @"text/json",@"text/plain", nil, nil];
    //通过 appid  secret 认证code . 来发送获取 access_token的请求
    [manager GET:[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",WX_APPID,WX_SECRET,code] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {  //获得access_token，然后根据access_token获取用户信息请求。
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"dic %@",dic);
        /*
         access_token   接口调用凭证
         expires_in access_token接口调用凭证超时时间，单位（秒）
         refresh_token  用户刷新access_token
         openid 授权用户唯一标识
         scope  用户授权的作用域，使用逗号（,）分隔
         unionid     当且仅当该移动应用已获得该用户的userinfo授权时，才会出现该字段
         */
        NSString* accessToken = [dic valueForKey:@"access_token"];
        NSString* openID = [dic valueForKey:@"openid"];
        [weakSelf requestUserInfoByToken:accessToken andOpenid:openID];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"error %@",error.localizedFailureReason);
        [MBProgress showErrorMessage:@"微信授权失败"];
    }];
    
}
#pragma mark 微信用户信息
-(void)requestUserInfoByToken:(NSString *)token andOpenid:(NSString *)openID{
    
    __weak typeof(self) weakSelf = self;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",token,openID] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"dic  ==== %@",dic);
        
        if(dic){
            
            weakSelf.wxUserInfo = dic;
            
            NSString *openid = [dic valueForKey:@"openid"];
            NSString *nickname = [dic valueForKey:@"nickname"];
            NSString *headimgurl = [dic valueForKey:@"headimgurl"];
            
            if (openid.length > 0) {
                
                [weakSelf weChatLoginWithOpenid:openid NickName:nickname Headimgurl:headimgurl];
            }else{
                
                [MBProgress showErrorMessage:@"请求失败"];
            }
        }else{
            
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error %ld",(long)error.code);
        [MBProgress showErrorMessage:@"微信获取用户信息失败"];
    }];
}
#pragma mark 微信登录请求
-(void)weChatLoginWithOpenid:(NSString *)openid NickName:(NSString *)nickname Headimgurl:(NSString *)headimgurl
{
    NSMutableDictionary * parmareter = [NSMutableDictionary dictionary];
    parmareter[@"openid"] = openid;
    parmareter[@"nickname"] = nickname;
    parmareter[@"headimgurl"] = headimgurl;
    
    __weak typeof(self) weakSelf = self;
    
    [[OMONetworkManager sharedData] postWithURLString:@"10004" parameters:parmareter success:^(id responseObject) {
        
        //        //发出登陆成功通知
        //        [[NSNotificationCenter defaultCenter] postNotificationName:@"loginSuccess" object:nil];
        //        //设置极光别名
        //        NSString * userId = [UserInfoModel sharedManage].userId;
        //        [JPUSHService setAlias:userId completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        //            NSLog(@"短信登录设置别名");
        //        } seq:0];
        
        //        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        
        [MBProgress hideAllHUD];
        if(responseObject){
            
            NSDictionary *dataSouce = (NSDictionary *)responseObject;
            NSString *isNeedMobile = dataSouce[@"isNeedMobile"];
            
            if([isNeedMobile integerValue] == 1){
                
                [MBProgress showInfoMessage:@"微信登录需要绑定您的手机号"];
                OMOBindingMobileVC *bingdingMobileVC = [[OMOBindingMobileVC alloc]init];
                bingdingMobileVC.wxUserInfo = weakSelf.wxUserInfo;
                UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:bingdingMobileVC];
                [[OMOIphoneManager getCurrentVC].navigationController presentViewController:nav animated:YES completion:nil];
            }else{
                
                [self omo_registThirdParty];
                
                UIViewController *currentVC = [OMOIphoneManager getCurrentVC];
                
                NSString *currentVCName = [NSString stringWithFormat:@"%@",[currentVC class]];
                
                if([currentVCName isEqualToString:@"OMOLoginMobileVC"]){
                    
                    [currentVC.navigationController popViewControllerAnimated:YES];
                }else{
                    
                    NSInteger count = currentVC.navigationController.viewControllers.count;
                    
                    if(count >= 3){
                        
                        NSInteger count = currentVC.navigationController.viewControllers.count;
                        
                        UIViewController *controller = currentVC.navigationController.viewControllers[count - 3];
                        
                        [currentVC.navigationController popToViewController:controller animated:YES];
                    }else{
                        
                        [currentVC.navigationController popViewControllerAnimated:YES];
                    }
                }
            }
        }
    } failure:^(NSError *error) {
        
        [MBProgress showErrorMessage:@"微信登录失败"];
    }];
}

#pragma mark ------ 设置第三方 ----------
- (void)omo_registThirdParty{
    
    /** 注册激光 */
    NSString *mobile = [OMOIphoneManager sharedData].mobile;
    [JPUSHService deleteTags:[NSSet setWithObject:mobile] completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
        
        [JPUSHService setTags:[NSSet setWithObject:mobile] completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
            
            
        } seq:0];
    } seq:0];
    
    /*手动登录*/
    [[[NIMSDK sharedSDK] loginManager] login:mobile token:@"yuanxinkangfu" completion:^(NSError * _Nullable error) {
        
        if(error){
            
            
        }
    }];
}

@end
