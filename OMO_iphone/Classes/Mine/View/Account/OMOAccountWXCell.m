//
//  OMOAccountWXCell.m
//  OMO_iphone
//
//  Created by wy on 2018/10/13.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOAccountWXCell.h"
#import <WXApi.h>
/**  */
#import <AFNetworking.h>
/**  */
#import "AppDelegate.h"
/**  */
#import "OMOShowWXBindingVC.h"
#/**  */
#import "OMOShowWXBindingVC.h"

@interface OMOAccountWXCell()<thridDelegate>
{
    
    AppDelegate *_appdelegate;
}

/**  */
@property (nonatomic, strong)UILabel *titleLab;
/**  */
@property (nonatomic, strong)UISwitch *bindingSwitch;

@end

@implementation OMOAccountWXCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = WHITECOLORA(1);
        
        [self addSubview:self.titleLab];
        [self addSubview:self.bindingSwitch];
    }
    return self;
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [_titleLab sizeToFit];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(lwb_margin * 2);
    }];
    
    [_bindingSwitch mas_makeConstraints:^(MASConstraintMaker *make) {

        make.centerY.equalTo(self.mas_centerY);
        make.height.equalTo(@(self.lwb_height * 0.5));
        make.right.equalTo(self.mas_right);
        make.width.equalTo(@(80));
    }];
}
- (UILabel *)titleLab{
    
    if(_titleLab == nil){
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.text = @"微信";
        _titleLab.textColor = textColour;
        _titleLab.font = bigFont;
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}
- (UISwitch *)bindingSwitch{
    
    if(_bindingSwitch == nil){
        
        //2. create switch
        _bindingSwitch = [[UISwitch alloc] init];
//        _bindingSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(SCREENW - 120, 15, 100, 30)];
//        //缩小或者放大switch的size
//        _bindingSwitch.transform = CGAffineTransformMakeScale(0.5, 0.5);
//        _bindingSwitch.layer.anchorPoint = CGPointMake(0, 0.3);
        //    self.mainSwitch.onImage = [UIImage imageNamed:@"on.png"];   //无效
        //    self.mainSwitch.offImage = [UIImage imageNamed:@"off.png"]; //无效
        //
//        _bindingSwitch.backgroundColor = mainBackColor;
        //它是矩形的
        // 设置开关状态(默认是 关)
        [_bindingSwitch setOn:[OMOIphoneManager sharedData].is_userinfo animated:true];
        //animated
            
        //thumbTintColor 滑块的背景颜色
        _bindingSwitch.thumbTintColor = mainBackColor;
        
        //添加事件监听
        [_bindingSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        //定制开关颜色UI
        //tintColor 关状态下的背景颜色
        _bindingSwitch.tintColor = DetailColor;
        //onTintColor 开状态下的背景颜色
        _bindingSwitch.onTintColor = backColor;
    }
    return _bindingSwitch;
}
- (void)switchAction:(id)sender{
    
    UISwitch *switchButton = (UISwitch*)sender;
    
    BOOL isButtonOn = [switchButton isOn];
    
    if (isButtonOn) {
        
        [self loginWechat];
//        switchButton.thumbTintColor = WHITECOLORA(1);
    }else {

        [self omo_removeWX];
//        switchButton.thumbTintColor = YellowColor;
    }
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
    
    [MBProgress showStatus:@"授权绑定中..."];
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
- (void)requestUserInfoByToken:(NSString *)token andOpenid:(NSString *)openID{
    
    __weak typeof(self) weakSelf = self;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",token,openID] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"dic  ==== %@",dic);
        
        if(dic){
            
            NSString *openid = [dic valueForKey:@"openid"];
            NSString *nickname = [dic valueForKey:@"nickname"];
            NSString *headimgurl = [dic valueForKey:@"headimgurl"];
            NSString *sex = [dic valueForKey:@"sex"];
            
            if (openid.length > 0) {
                
                [weakSelf weChatLoginWithOpenid:openid NickName:nickname Headimgurl:headimgurl Sex:sex];
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
- (void)weChatLoginWithOpenid:(NSString *)openid NickName:(NSString *)nickname Headimgurl:(NSString *)headimgurl Sex:(NSString *)sex
{
    [MBProgress hideAllHUD];
    
    NSMutableDictionary * parmareter = [NSMutableDictionary dictionary];
    parmareter[@"openid"] = openid;
    parmareter[@"nickname"] = nickname;
    parmareter[@"headimgurl"] = headimgurl;
    parmareter[@"sex"] = sex;
    parmareter[@"mobile"] = [OMOIphoneManager sharedData].mobile;
    
    __weak typeof(self) weakSelf = self;
    
    [[OMONetworkManager sharedData] postWithURLString:@"10002" parameters:parmareter success:^(id responseObject) {
        
        if(responseObject){
            
            NSDictionary *dataSouce = (NSDictionary *)responseObject;
            
            NSString *type = [NSString stringWithFormat:@"%@",dataSouce[@"type"]];
                              
            if([type isEqualToString:@"1"]){
                
                OMOShowWXBindingVC *showWXBindingVC = [[OMOShowWXBindingVC alloc]init];
                showWXBindingVC.wxUserInfo = parmareter;
                showWXBindingVC.WXBindingBlock = ^(BOOL isCancel) {
                    
                    if(isCancel){
                        
                        [weakSelf.bindingSwitch setOn:NO animated:YES];
                    }else{
                        
                        [weakSelf weChatLoginWithOpenid:openid NickName:nickname Headimgurl:headimgurl Sex:sex Is_confirm:@"1"];
                    }
                };
                [[OMOIphoneManager getCurrentVC].navigationController pushViewController:showWXBindingVC animated:YES];
            }else if([type isEqualToString:@"2"]){
                
                [OMOIphoneManager sharedData].is_userinfo = YES;
                [weakSelf.bindingSwitch setOn:YES animated:YES];
            }else{
                
                [weakSelf.bindingSwitch setOn:NO animated:YES];
            }
        }else{
            
            [weakSelf.bindingSwitch setOn:NO animated:YES];
        }
    } failure:^(NSError *error) {
        
        [weakSelf.bindingSwitch setOn:YES animated:YES];
        [MBProgress showErrorMessage:@"微信绑定失败"];
    }];
}
#pragma mark ---------- 继续绑定 ------------
- (void)weChatLoginWithOpenid:(NSString *)openid NickName:(NSString *)nickname Headimgurl:(NSString *)headimgurl Sex:(NSString *)sex Is_confirm:(NSString *)is_confirm
{
    [MBProgress hideAllHUD];
    
    NSMutableDictionary * parmareter = [NSMutableDictionary dictionary];
    parmareter[@"openid"] = openid;
    parmareter[@"nickname"] = nickname;
    parmareter[@"headimgurl"] = headimgurl;
    parmareter[@"sex"] = sex;
    parmareter[@"is_confirm"] = is_confirm;
    parmareter[@"mobile"] = [OMOIphoneManager sharedData].mobile;
    
    __weak typeof(self) weakSelf = self;
    
    [[OMONetworkManager sharedData] postWithURLString:@"10002" parameters:parmareter success:^(id responseObject) {
        
        if(responseObject){
            
            [MBProgress showInfoMessage:@"绑定成功"];
            [weakSelf.bindingSwitch setOn:YES animated:YES];
        }else{
            [MBProgress showInfoMessage:@"绑定失败"];
            [weakSelf.bindingSwitch setOn:NO animated:YES];
        }
    } failure:^(NSError *error) {
        
        [weakSelf.bindingSwitch setOn:YES animated:YES];
        [MBProgress showErrorMessage:@"微信绑定失败"];
    }];
}
#pragma mark ------ 解除微信绑定 ----------
- (void)omo_removeWX{
    
    __weak typeof(self) weakSelf = self;
    
    [[OMONetworkManager sharedData]postWithURLString:@"10007" parameters:nil success:^(id responseObject) {
        
        if(responseObject){
            
            weakSelf.bindingSwitch.on = NO;
        }
    } failure:^(NSError *error) {
        
        [MBProgress showErrorMessage:@"解除微信绑定失败"];
    }];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
