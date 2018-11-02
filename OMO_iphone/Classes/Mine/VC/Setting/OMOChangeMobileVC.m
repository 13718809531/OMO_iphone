//
//  OMOChangeMobileVC.m
//  OMO_iphone
//
//  Created by wy on 2018/10/21.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOChangeMobileVC.h"

@interface OMOChangeMobileVC ()<UITextFieldDelegate>

/**  */
@property (nonatomic, strong)UIView *oldMobileView;
/**  */
@property (nonatomic, strong)UIView *nowMobileView;
/**  */
@property (nonatomic, strong)UITextField *mobileTfd;
/**  */
@property (nonatomic, strong)UIView *codeView;
/**  */
@property (nonatomic, strong)UITextField *codeTfd;
/**  */
@property (nonatomic, strong)UIButton *getCodeBtn;
/**  */
@property (nonatomic, strong)UIButton *submitBtn;

@end

@implementation OMOChangeMobileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatBar];
    [self.bar addTitltLabelWithText:@"修改手机号" Font:navTitleFont];
    [self.bar addLeftButtonWithImage:[UIImage imageNamed:@"App_Back"]];
    
    self.view.backgroundColor = mainBackColor;
    [self.view addSubview:self.oldMobileView];
    [self.view addSubview:self.nowMobileView];
    [self.view addSubview:self.codeView];
    [self.view addSubview:self.submitBtn];
}
- (UIView *)oldMobileView{
    
    if(_oldMobileView == nil){
        
        _oldMobileView = [[UIView alloc]initWithFrame:CGRectMake(0, IphoneY, SCREENW, 80)];
        _oldMobileView.backgroundColor = WHITECOLORA(1);
        UILabel *titleLab = [[UILabel alloc]init];
        titleLab.text = @"原手机号:";
        titleLab.textColor = textColour;
        titleLab.font = navTitleFont;
        titleLab.textAlignment = NSTextAlignmentLeft;
        [titleLab sizeToFit];
        titleLab.lwb_x = lwb_margin * 2;
        titleLab.lwb_centerY = 40;
        [_oldMobileView addSubview:titleLab];
        
        UILabel *oldMobileLab = [[UILabel alloc]init];
        oldMobileLab.text = [OMOIphoneManager sharedData].mobile;
        oldMobileLab.textColor = DetailColor;
        oldMobileLab.font = navTitleFont;
        oldMobileLab.textAlignment = NSTextAlignmentRight;
        [oldMobileLab sizeToFit];
        oldMobileLab.lwb_right = _oldMobileView.lwb_right - lwb_margin * 2;
        oldMobileLab.lwb_centerY = 40;
        [_oldMobileView addSubview:oldMobileLab];
    }
    return _oldMobileView;
}
- (UIView *)nowMobileView{
    
    if(_nowMobileView == nil){
        
        _nowMobileView = [[UIView alloc]initWithFrame:CGRectMake(0, self.oldMobileView.lwb_bottom + lwb_margin, SCREENW, 80)];
        _nowMobileView.backgroundColor = WHITECOLORA(1);
        
        UILabel *titleLab = [[UILabel alloc]init];
        titleLab.text = @"新手机号:";
        titleLab.textColor = textColour;
        titleLab.font = navTitleFont;
        titleLab.textAlignment = NSTextAlignmentLeft;
        [titleLab sizeToFit];
        titleLab.lwb_x = lwb_margin * 2;
        titleLab.lwb_centerY = 40;
        [_nowMobileView addSubview:titleLab];
        
        _mobileTfd = [[UITextField alloc]init];
        _mobileTfd.textColor = textColour;
        _mobileTfd.font = Font(IFFitFloat6(16));
        _mobileTfd.placeholder = @"请输入手机号";
        CGFloat x = titleLab.lwb_right + lwb_smallMargin;
        _mobileTfd.lwb_x = x;
        _mobileTfd.lwb_width = _nowMobileView.lwb_width - lwb_margin * 2 - x;
        _mobileTfd.lwb_height = _nowMobileView.lwb_height;
        _mobileTfd.lwb_centerY = 40;
        _mobileTfd.clearButtonMode = UITextFieldViewModeAlways;
        _mobileTfd.keyboardType = UIKeyboardTypeNumberPad;
        [_mobileTfd addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [_nowMobileView addSubview:_mobileTfd];
    }
    return _nowMobileView;
}
- (UIView *)codeView{
    
    if(_codeView == nil){
        
        _codeView = [[UIView alloc]initWithFrame:CGRectMake(0, self.nowMobileView.lwb_bottom + 2, SCREENW, 80)];
        _codeView.backgroundColor = WHITECOLORA(1);
        
        UILabel *titleLab = [[UILabel alloc]init];
        titleLab.text = @"验证码:";
        titleLab.textColor = textColour;
        titleLab.font = navTitleFont;
        titleLab.textAlignment = NSTextAlignmentLeft;
        [titleLab sizeToFit];
        titleLab.lwb_x = lwb_margin * 2;
        titleLab.lwb_centerY = 40;
        [_codeView addSubview:titleLab];
        
        _getCodeBtn = [[UIButton alloc]init];
        [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        _getCodeBtn.titleLabel.font = navTitleFont;
        [_getCodeBtn sizeToFit];
        _getCodeBtn.lwb_right = _codeView.lwb_right - lwb_margin * 2;
        _getCodeBtn.lwb_centerY = 40;
        [_getCodeBtn setTitleColor:backColor forState:UIControlStateNormal];
        _getCodeBtn.enabled = NO;
        [_getCodeBtn addTarget:self action:@selector(omo_getCode:) forControlEvents:UIControlEventTouchUpInside];
        [_codeView addSubview:_getCodeBtn];
        
        _codeTfd = [[UITextField alloc]init];
        _codeTfd.textColor = textColour;
        _codeTfd.font = Font(IFFitFloat6(16));
        _codeTfd.placeholder = @"输入验证码";
        CGFloat x = titleLab.lwb_right + lwb_margin * 2 + lwb_smallMargin;
        _codeTfd.lwb_x = x;
        _codeTfd.lwb_width = SCREENW - x - 120;;
        _codeTfd.lwb_height = _codeView.lwb_height;
        _codeTfd.lwb_centerY = 40;
        _codeTfd.clearButtonMode = UITextFieldViewModeAlways;
        _codeTfd.keyboardType = UIKeyboardTypeNumberPad;
        [_codeTfd addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [_codeView addSubview:_codeTfd];
    }
    return _codeView;
}
- (UIButton *)submitBtn{
    
    if(_submitBtn == nil){
        
        _submitBtn = [[UIButton alloc]init];
        _submitBtn.lwb_width = SCREENW - IFFitFloat6(lwb_pblicX) * 2;
        _submitBtn.lwb_height = 40.f;
        _submitBtn.lwb_bottom = SCREENH - 40;
        _submitBtn.lwb_centerX = self.view .lwb_centerX;
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.layer.cornerRadius = 20.f;
        _submitBtn.backgroundColor = backColor;
        [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_submitBtn setTitleColor:WHITECOLORA(1) forState:UIControlStateNormal];
        _submitBtn.enabled = NO;
        [_submitBtn addTarget:self action:@selector(omo_bingingMobile) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}
#pragma mark ------- 判断手机号位数 -------
- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == self.mobileTfd) {
        
        if (textField.text.length == 11) {
            
            _getCodeBtn.enabled = YES;
        }else{
            
            _getCodeBtn.enabled = NO;
        }
        
        if (textField.text.length > 11) {
            
            textField.text = [textField.text substringToIndex:11];
        }
    }else{
        
        if (textField.text.length == 4) {
            
            _submitBtn.enabled = YES;
        }else{
            
            _submitBtn.enabled = NO;
        }
        
        if (textField.text.length > 4) {
            
            textField.text = [textField.text substringToIndex:4];
        }
    }
}

#pragma mark -------- 获取验证码 ----------
- (void)omo_getCode:(UIButton *)sender{
    
    if ([NSString_Utils isValidateMobile:_mobileTfd.text]) {
        
        NSDictionary *params = @{@"mobile":_mobileTfd.text};
        
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
#pragma mark -------- 验证码绑定手机号 -------------
- (void)omo_bingingMobile{
    
    [self.view resignFirstResponder];
    NSString *oldMobile = [OMOIphoneManager sharedData].mobile;
    
    if (![NSString_Utils isValidateMobile:_mobileTfd.text]){
        
        [MBProgress showInfoMessage:@"手机号格式错误"];
        return;
    }
    
    if (_codeTfd.text.length != 4){
        
        [MBProgress showInfoMessage:@"验证码错误"];
        return;
    }
    
    if([oldMobile isEqualToString:_mobileTfd.text]){
        
        [MBProgress showInfoMessage:@"修改的手机号不能为原手机号"];
        return;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"old_mobile"] = [OMOIphoneManager sharedData].mobile;
    params[@"new_mobile"] = _mobileTfd.text;
    params[@"code"] = _codeTfd.text;
    
    [[OMONetworkManager sharedData]postWithURLString:@"10002" parameters:params success:^(id responseObject) {
        
        if(responseObject){
            
            NSDictionary *user = (NSDictionary *)responseObject;
            
            [OMOIphoneManager initWithDictionary:user];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {
        
        [MBProgress showInfoMessage:@"网络错误,重新获取验证码"];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
