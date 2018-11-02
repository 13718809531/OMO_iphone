//
//  OMOLoginCodeVC.m
//  OMO_iphone
//
//  Created by wy on 2018/9/30.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOLoginCodeVC.h"
#import "OMOWXLoginView.h"
#import "OMOCodeView.h"
#import "OMOTabBarController.h"
#import "AppDelegate.h"
// 引入 JPush 功能所需头文件
#import "JPUSHService.h"

@interface OMOLoginCodeVC ()

/** 手机号码登录 */
@property (nonatomic, strong)UILabel *titleLab;
/** 短信验证码 */
@property (nonatomic, strong)UILabel *promptLab;
/** 验证码输入框 */
@property(strong,nonatomic)OMOCodeView *codeView;
/** 验证码获取按钮 */
@property (nonatomic,strong)UIButton *getCodeBtn;
/** 微信登录视图 */
//@property (nonatomic,strong)OMOWXLoginView *wxLoginView;
/** 用户协议按钮 */
@property (nonatomic,strong)UIButton *agreementBtn;

@end

@implementation OMOLoginCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = WHITECOLORA(1);
    [self creatBar];
    [self.bar addLeftButtonWithImage:[UIImage imageNamed:@"App_Back"]];
    self.bar.line.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.titleLab];
    [self.view addSubview:self.promptLab];
    [self.view addSubview:self.codeView];
    [self.view addSubview:self.getCodeBtn];
    [self.view addSubview:self.agreementBtn];
//    [self.view addSubview:self.wxLoginView];
    
    [self omo_getCode:self.getCodeBtn];
}
- (UILabel *)titleLab{
    
    if(_titleLab == nil){
        
        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(IFFitFloat6(lwb_pblicX), IphoneY + IFFitFloat6(lwb_pblicX), SCREENW - lwb_pblicX * 2, 40)];
        _titleLab.text = @"手机号码登录";
        _titleLab.textColor = textColour;
        _titleLab.font = BoldFont(28);
        _titleLab.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLab;
}
- (UILabel *)promptLab{
    
    if(_promptLab == nil){
        
        _promptLab = [[UILabel alloc]initWithFrame:CGRectMake(IFFitFloat6(lwb_pblicX), self.codeView.lwb_y - IFFitFloat6(40) - 30, SCREENW - lwb_pblicX * 2, 30)];
        _promptLab.text = @"输入验证码";
        _promptLab.textColor = textColour;
        _promptLab.font = Font(22);
        _promptLab.textAlignment = NSTextAlignmentLeft;
    }
    return _promptLab;
}
- (OMOCodeView *)codeView{
    
    if(_codeView == nil){
        
        __weak typeof(self) weakSelf = self;
        _codeView = [[OMOCodeView alloc]initWithFrame:CGRectMake(IFFitFloat6(lwb_pblicX), self.getCodeBtn.lwb_y - IFFitFloat6(lwb_pblicX) - 40, SCREENW - IFFitFloat6(lwb_pblicX * 2), 40) inputType:4 selectCodeBlock:^(NSString *text) {
            
            if(text.length == 4){
                
                [weakSelf omo_codeLoginWithCode:text];
            }
        }];
    }
    return _codeView;
}
- (UIButton *)getCodeBtn{
    if(_getCodeBtn == nil){
        
        _getCodeBtn = [[UIButton alloc]init];
        _getCodeBtn.lwb_width = SCREENW - IFFitFloat6(lwb_pblicX) * 2;
        _getCodeBtn.lwb_height = 40.f;
        _getCodeBtn.center = self.view.center;
        _getCodeBtn.layer.masksToBounds = YES;
        _getCodeBtn.layer.cornerRadius = 20.f;
        _getCodeBtn.backgroundColor = backColor;
        [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        _getCodeBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_getCodeBtn setTitleColor:WHITECOLORA(1) forState:UIControlStateNormal];
        _getCodeBtn.enabled = NO;
        [_getCodeBtn addTarget:self action:@selector(omo_getCode:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _getCodeBtn;
}
- (UIButton *)agreementBtn{
    
    if(_agreementBtn == nil){
        
        _agreementBtn = [[UIButton alloc]initWithFrame:CGRectMake(IFFitFloat6(lwb_pblicX), self.getCodeBtn.lwb_bottom + IFFitFloat6(30), SCREENW - IFFitFloat6(lwb_pblicX) * 2, 30)];
        _agreementBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        NSString *str1 = @"登录即表示已阅读并同意";
        NSString *str2 = @"《用户协议》";
        NSString *title = [NSString stringWithFormat:@"%@%@",str1,str2];
        NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc]initWithString:title];
        [attriStr addAttribute:NSForegroundColorAttributeName value:DetailColor range:[title rangeOfString:str1]];
        NSDictionary *attriBute = @{NSForegroundColorAttributeName:textColour,NSFontAttributeName:Font(18),NSUnderlineStyleAttributeName:@1,NSUnderlineColorAttributeName:textColour};
        [attriStr addAttributes:attriBute range:[title rangeOfString:str2]];
        [_agreementBtn setAttributedTitle:attriStr forState:UIControlStateNormal];
        [_agreementBtn setTitleColor:DetailColor forState:UIControlStateNormal];
        _agreementBtn.titleLabel.font = Font(16);
        [_agreementBtn addTarget:self action:@selector(omo_seeUserAgreement) forControlEvents:UIControlEventTouchUpInside];
    }
    return _agreementBtn;
}
//- (OMOWXLoginView *)wxLoginView{
//
//    if(_wxLoginView == nil){
//
//        _wxLoginView = [[OMOWXLoginView alloc]init];
//    }
//    return _wxLoginView;
//}

#pragma mark --------- 查看用户协议 -------------
- (void)omo_seeUserAgreement{
    
    
}
#pragma mark ------- 获取验证码
- (void)omo_getCode:(UIButton *)sender{
    
    if ([NSString_Utils isValidateMobile:_mobile]) {
        
        NSDictionary *params = @{@"mobile":_mobile};
        
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
                [button setTitle:[NSString stringWithFormat:@"重新发送%@秒",timeStr] forState:UIControlStateNormal];
                button.userInteractionEnabled = NO;
            });
            
            timeOut--;
        }
    });
    dispatch_resume(_timer);
}
#pragma mark -------- 验证码登录 -------------
- (void)omo_codeLoginWithCode:(NSString *)code{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"mobile"] = _mobile;
    params[@"code"] = code;
    params[@"gender"] = checkNull([OMOIphoneManager sharedData].gender);
    params[@"birthday"] = checkNull([OMOIphoneManager sharedData].birthday);
    
    [[OMONetworkManager sharedData]postWithURLString:@"10001" parameters:params success:^(id responseObject) {
        
        if(responseObject){
            
            NSDictionary *user = (NSDictionary *)responseObject;
            
            [OMOIphoneManager sharedData].session_id = user[@"session_id"];
            [OMOIphoneManager initWithDictionary:user];
            
            [self omo_registThirdParty];
            NSInteger count = self.navigationController.viewControllers.count;
            
            if(count >= 3){
                
                NSInteger count = self.navigationController.viewControllers.count;
                
                UIViewController *controller = self.navigationController.viewControllers[count - 3];
                
                [self.navigationController popToViewController:controller animated:YES];
            }else{
                
                [self.navigationController popViewControllerAnimated:YES];
            }
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
    
    /*手动登录*/
    [[[NIMSDK sharedSDK] loginManager] login:mobile token:@"yuanxinkangfu" completion:^(NSError * _Nullable error) {
    
        if(error){


        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
