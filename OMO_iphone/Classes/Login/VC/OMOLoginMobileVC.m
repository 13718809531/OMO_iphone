//
//  OMOLoginMobileVC.m
//  OMO_iphone
//
//  Created by wy on 2018/9/30.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOLoginMobileVC.h"
#import "OMOWXLoginView.h"
#import "OMOLoginCodeVC.h"
/** 协议 */
#import "OMOPublicAgreementVC.h"

@interface OMOLoginMobileVC ()<UITextViewDelegate>

/** 手机号码登录 */
@property (nonatomic, strong)UILabel *titleLab;
/** 输入手机号 */
@property (nonatomic, strong)UILabel *promptLab;
/** 手机号输入框 */
@property(strong,nonatomic)UITextField *mobileTfd;
/** 下一步按钮 */
@property (nonatomic,strong)UIButton *nextBtn;
/** 微信登录视图 */
@property (nonatomic,strong)OMOWXLoginView *wxLoginView;
/** 用户协议按钮 */
@property (nonatomic,strong)UITextView *textView;

@end

@implementation OMOLoginMobileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = WHITECOLORA(1);
    [self creatBar];
    [self.bar addLeftButtonWithImage:[UIImage imageNamed:@"App_Back"]];
    self.bar.line.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.titleLab];
    [self.view addSubview:self.promptLab];
    [self.view addSubview:self.mobileTfd];
    [self.view addSubview:self.nextBtn];
    [self.view addSubview:self.textView];
    [self.view addSubview:self.wxLoginView];
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
        
        _promptLab = [[UILabel alloc]initWithFrame:CGRectMake(IFFitFloat6(lwb_pblicX), self.mobileTfd.lwb_y - IFFitFloat6(40) - 30, SCREENW - lwb_pblicX * 2, 30)];
        _promptLab.text = @"输入手机号";
        _promptLab.textColor = textColour;
        _promptLab.font = Font(22);
        _promptLab.textAlignment = NSTextAlignmentLeft;
    }
    return _promptLab;
}
- (UITextField *)mobileTfd{
    
    if(_mobileTfd == nil){
        
        _mobileTfd = [[UITextField alloc]initWithFrame:CGRectMake(IFFitFloat6(lwb_pblicX), self.nextBtn.lwb_y - IFFitFloat6(lwb_pblicX) - 40, SCREENW - IFFitFloat6(lwb_pblicX * 2), 40)];
        _mobileTfd.textColor = textColour;
        _mobileTfd.font = Font(IFFitFloat6(16));
        _mobileTfd.placeholder = @"输入手机号";
        _mobileTfd.text = @"13718809531";
        _mobileTfd.clearButtonMode = UITextFieldViewModeAlways;
        _mobileTfd.keyboardType = UIKeyboardTypeNumberPad;
        [_mobileTfd addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, _mobileTfd.lwb_height - 1, _mobileTfd.lwb_width, 1)];
        CAShapeLayer *line = [CAShapeLayer layer];
        line.path = path.CGPath;
        line.fillColor = DetailColor.CGColor;
        [_mobileTfd.layer addSublayer:line];
    }
    return _mobileTfd;
}
- (UIButton *)nextBtn{
    if(_nextBtn == nil){
        
        _nextBtn = [[UIButton alloc]init];
        _nextBtn.lwb_width = SCREENW - IFFitFloat6(lwb_pblicX) * 2;
        _nextBtn.lwb_height = 40.f;
        _nextBtn.center = self.view.center;
        _nextBtn.layer.masksToBounds = YES;
        _nextBtn.layer.cornerRadius = 20.f;
        _nextBtn.backgroundColor = backColor;
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        _nextBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_nextBtn setTitleColor:WHITECOLORA(1) forState:UIControlStateNormal];
//        _nextBtn.enabled = NO;
        [_nextBtn addTarget:self action:@selector(omo_nextCode) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
}
- (UITextView *)textView{
    
    if(_textView == nil){
        
        _textView = [[UITextView alloc]initWithFrame:CGRectMake(IFFitFloat6(lwb_pblicX), self.nextBtn.lwb_bottom + IFFitFloat6(30), SCREENW - IFFitFloat6(lwb_pblicX) * 2, 30)];
//        _textView.textAlignment = NSTextAlignmentCenter;
        _textView.font = bigFont;
        NSString *str1 = @"已阅读并同意";
        NSString *str2 = @"《服务协议》";
        NSString *str3 = @"《用户协议》";
        NSString *title = [NSString stringWithFormat:@"%@%@ %@",str1,str2,str3];
        NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc]initWithString:title];
        [attriStr addAttribute:NSFontAttributeName value:bigFont range:NSMakeRange(0, attriStr.length)];
        [attriStr addAttribute:NSForegroundColorAttributeName value:DetailColor range:[title rangeOfString:str1]];
        NSDictionary *attriBute = @{NSForegroundColorAttributeName:textColour,NSFontAttributeName:Font(16),NSUnderlineStyleAttributeName:@1,NSUnderlineColorAttributeName:textColour};
        [attriStr addAttributes:attriBute range:[title rangeOfString:str2]];
        [attriStr addAttributes:attriBute range:[title rangeOfString:str3]];
        [attriStr addAttribute:NSLinkAttributeName value:@"fuwu" range:[[attriStr string] rangeOfString:str2]];
        [attriStr addAttribute:NSLinkAttributeName value:@"zhuce" range:[[attriStr string] rangeOfString:str3]];
//        CGFloat margin = _textView.lwb_width/(attriStr.length - 1);
//        NSNumber *number = [NSNumber numberWithFloat:margin];
//        [attriStr addAttribute:NSKernAttributeName value:number range:NSMakeRange(0, attriStr.length)];
        _textView.attributedText = attriStr;
        _textView.delegate = self;
        _textView.editable = NO;        //必须禁止输入，否则点击将弹出输入键盘
        _textView.scrollEnabled = NO;
    }
    return _textView;
}
- (OMOWXLoginView *)wxLoginView{
    
    if(_wxLoginView == nil){
        
        _wxLoginView = [[OMOWXLoginView alloc]init];
    }
    return _wxLoginView;
}
#pragma mark ------- 判断手机号位数 -------
- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == self.mobileTfd) {
        
        if (textField.text.length == 11) {
            
            _nextBtn.enabled = YES;
        }
        
        if (textField.text.length > 11) {
            
            textField.text = [textField.text substringToIndex:11];
        }
    }
}
#pragma mark --------- 查看用户协议 -------------
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    
    if ([[URL absoluteString] isEqualToString:@"fuwu"]) {
        
        OMOPublicAgreementVC *publicAgreementVC = [[OMOPublicAgreementVC alloc]init];
        publicAgreementVC.agreementType = 1;
        [self.navigationController pushViewController:publicAgreementVC animated:YES];
        return NO;
    } else if ([[URL absoluteString] isEqualToString:@"zhuce"]) {
        
        OMOPublicAgreementVC *publicAgreementVC = [[OMOPublicAgreementVC alloc]init];
        publicAgreementVC.agreementType = 2;
        [self.navigationController pushViewController:publicAgreementVC animated:YES];
        return NO;
    }
    return YES;
}
#pragma mark ------- 跳转输入验证码
- (void)omo_nextCode{
    
    if(_mobileTfd.text.length < 11){
        
        [MBProgress showInfoMessage:@"请输入完整的手机号"];
        return;
    }
    OMOLoginCodeVC *codeVC = [[OMOLoginCodeVC alloc]init];
    codeVC.mobile = _mobileTfd.text;
    [self.navigationController pushViewController:codeVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
