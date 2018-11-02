//
//  OMOBindingMobileVCViewController.m
//  OMO_iphone
//
//  Created by wy on 2018/9/21.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOBindingMobileVC.h"
#import "OMOBindingMobileView.h"
#import "AppDelegate.h"
#import "OMOBindingCodeView.h"
#import "OMOTabBarController.h"
// 引入 JPush 功能所需头文件
#import "JPUSHService.h"

@interface OMOBindingMobileVC ()

@property (nonatomic, strong)UIButton *backBtn;
@property (nonatomic, strong)UILabel *titleLab;
@property(strong,nonatomic)OMOBindingMobileView *mobileView;// 输入视图
@property(strong,nonatomic)OMOBindingCodeView *codeView;// 验证码
@property (nonatomic,strong)UIButton *loginButton;// 去登录

@end

@implementation OMOBindingMobileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = mainBackColor;
    
    [self.view addSubview:self.titleLab];
    [self.view addSubview:self.mobileView];
    [self.view addSubview:self.codeView];
    [self.view addSubview:self.loginButton];
}
- (UIButton *)backBtn{
    
    if(!_backBtn){
        
        _backBtn = [[UIButton alloc]init];
        [_backBtn setImage:[UIImage imageNamed:@"App_Back"] forState:UIControlStateNormal];
        [_backBtn sizeToFit];
        _backBtn.lwb_x = lwb_margin;
        _backBtn.lwb_y = Between + 20;
        _backBtn.center = self.view.center;
        [_backBtn addTarget:self action:@selector(clickBarBtLeft) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}
- (void)clickBarBtLeft{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (UILabel *)titleLab{
    
    if(_titleLab == nil){
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.text = @"微信登录需要绑定您的手机号";
        [_titleLab sizeToFit];
        _titleLab.lwb_y = IphoneY + IFFitFloat6(lwb_margin * 4);
        _titleLab.lwb_centerX = self.view.lwb_centerX;
        _titleLab.textColor = textColour;
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}
- (OMOBindingMobileView *)mobileView{

    if(_mobileView == nil){

        _mobileView = [[OMOBindingMobileView alloc]initWithFrame:CGRectMake(IFFitFloat6(50), self.titleLab.lwb_bottom + lwb_margin * 4, SCREENW - IFFitFloat6(50) * 2, 60)];
    }
    return _mobileView;
}
- (OMOBindingCodeView *)codeView{

    if(_codeView == nil){

        _codeView = [[OMOBindingCodeView alloc]initWithFrame:CGRectMake(IFFitFloat6(50), self.mobileView.lwb_bottom + IFFitFloat6(30), SCREENW - IFFitFloat6(50) * 2, 60)];
        _codeView.delegate = self;
    }
    return _codeView;
}
- (UIButton *)loginButton{
    if(!_loginButton){
        
        _loginButton = [[UIButton alloc]init];
        _loginButton.lwb_width = SCREENW - lwb_pblicX * 2 - lwb_margin * 2;
        _loginButton.lwb_height = 44;
//        _loginButton.lwb_y = _codeView.lwb_bottom + IFFitFloat6(60);
//        _loginButton.lwb_centerX = self.view.lwb_centerX;
        _loginButton.center = self.view.center;
        _loginButton.backgroundColor = backColor;
        [_loginButton setTitle:@"确定绑定" forState:UIControlStateNormal];
        _loginButton.titleLabel.font = [UIFont systemFontOfSize:18];
        [_loginButton setTitleColor:WHITECOLORA(1) forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(md_login) forControlEvents:UIControlEventTouchUpInside];
        _loginButton.layer.masksToBounds = YES;
        _loginButton.layer.cornerRadius = 22.f;
    }
    return _loginButton;
}
- (void)yx_getCode:(UIButton *)sender{

    if ([NSString_Utils isValidateMobile:_mobileView.mobileTfd.text]) {

        //        NSString *deviceUUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];

        NSDictionary *params = @{@"mobile":_mobileView.mobileTfd.text};

        [[OMONetworkManager sharedData]postWithURLString:@"10000" parameters:params success:^(id responseObject) {

            if(responseObject){

                //按钮倒计时
                [self startWithTime:60 title:@"获取验证码" button:sender];
            }
        } failure:^(NSError *error) {

            [MBProgress showInfoMessage:@"网络错误,重新获取验证码"];
            sender.enabled = YES;
        }];
    }else{

        [MBProgress showInfoMessage:@"请输入正确的手机号"];
    }
}
#pragma mark - 验证码倒计时
- (void)startWithTime:(NSInteger)timeLine title:(NSString *)title button:(UIButton *)button{

    // 倒计时时间
    __block NSInteger timeOut = timeLine;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);

    // 每秒执行一次
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{

        // 倒计时结束，关闭
        if (timeOut <= 0) {

            dispatch_source_cancel(_timer);

            dispatch_async(dispatch_get_main_queue(), ^{

                [button setTitle:title forState:UIControlStateNormal];
                button.userInteractionEnabled = YES;
            });

        }else{

            NSString * timeStr = [NSString stringWithFormat:@"%0.2ld",(long)timeOut];

            dispatch_async(dispatch_get_main_queue(), ^{
                [button setTitle:[NSString stringWithFormat:@"%@秒",timeStr] forState:UIControlStateNormal];
                button.userInteractionEnabled = NO;
            });

            timeOut--;
        }
    });
    dispatch_resume(_timer);
}
#pragma mark -------- 验证码登录 -------------
- (void)md_login{

    [self.view resignFirstResponder];

    if (![NSString_Utils isValidateMobile:_mobileView.mobileTfd.text]){

        [MBProgress showInfoMessage:@"手机号格式错误"];
        return;
    }

    if (_codeView.codeTfd.text.length != 4){

        [MBProgress showInfoMessage:@"验证码错误"];
        return;
    }

    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:_wxUserInfo];
    params[@"mobile"] = _mobileView.mobileTfd.text;
    params[@"code"] = _codeView.codeTfd.text;
    params[@"openid"] = _wxUserInfo[@"openid"];
    params[@"nickname"] = _wxUserInfo[@"nickname"];
    params[@"headimgurl"] = _wxUserInfo[@"headimgurl"];
    params[@"sex"] =  [OMOIphoneManager sharedData].gender.length > 0 ? [OMOIphoneManager sharedData].gender : checkNull(_wxUserInfo[@"sex"]);
    params[@"birthday"] = [OMOIphoneManager sharedData].birthday.length > 0 ? [OMOIphoneManager sharedData].birthday : checkNull(_wxUserInfo[@"birthday"]);
    
    [[OMONetworkManager sharedData]postWithURLString:@"10002" parameters:params success:^(id responseObject) {

        if(responseObject){

            NSDictionary *user = (NSDictionary *)responseObject;

            [OMOIphoneManager initWithDictionary:user];

            [self omo_registThirdParty];
            
            AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
            app.window.rootViewController = [[OMOTabBarController alloc]init];
        }
    } failure:^(NSError *error) {

        [MBProgress showInfoMessage:@"网络错误,重新获取验证码"];
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
    
    /* 手动登录网易 */
    [[[NIMSDK sharedSDK] loginManager] login:mobile token:@"yuanxinkangfu" completion:^(NSError * _Nullable error) {
        
        if(error){
            
            
        }
    }];
}
@end
