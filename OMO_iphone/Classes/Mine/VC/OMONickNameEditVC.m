//
//  OMONickNameEditVC.m
//  OMO_iphone
//
//  Created by wy on 2018/10/21.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMONickNameEditVC.h"

@interface OMONickNameEditVC ()<UITextFieldDelegate>

/**  */
@property (nonatomic, strong)UIView *nickNameView;
/**  */
@property (nonatomic, strong)UITextField *nickNameTfd;
/**  */
@property (nonatomic, strong)UIButton *submitBtn;

@end

@implementation OMONickNameEditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatBar];
    [self.bar addLeftButtonWithImage:[UIImage imageNamed:@"App_Back"]];
    [self.bar addTitltLabelWithText:@"修改姓名" Font:navTitleFont];
    self.view.backgroundColor = mainBackColor;
    
    [self.view addSubview:self.nickNameView];
    [self.view addSubview:self.submitBtn];
}
- (UIView *)nickNameView{
    
    if(_nickNameView == nil){
        
        _nickNameView = [[UIView alloc]initWithFrame:CGRectMake(0, IphoneY, SCREENW, 80)];
        _nickNameView.backgroundColor = WHITECOLORA(1);
        
        [_nickNameView addSubview:self.nickNameTfd];
    }
    return _nickNameView;
}
- (UITextField *)nickNameTfd{
    
    if(_nickNameTfd == nil){
        
        _nickNameTfd = [[UITextField alloc]init];
        _nickNameTfd.textColor = textColour;
        _nickNameTfd.font = navTitleFont;
        _nickNameTfd.placeholder = [OMOIphoneManager sharedData].nickname;
        _nickNameTfd.lwb_y = 0;
        _nickNameTfd.lwb_x = lwb_margin * 2;
        _nickNameTfd.lwb_width = SCREENW - lwb_margin * 4;
        _nickNameTfd.lwb_height = 60;
        _nickNameTfd.clearButtonMode = UITextFieldViewModeAlways;
        _nickNameTfd.keyboardType = UIKeyboardTypeDefault;
        [_nickNameTfd addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _nickNameTfd;
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
        [_submitBtn addTarget:self action:@selector(omo_edtingNickName) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}
#pragma mark ------- 判断手机号位数 -------
- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == self.nickNameTfd) {
        
        if (textField.text.length > 14) {
            
            textField.text = [textField.text substringToIndex:14];
        }
    }
}

#pragma mark --------- 编辑昵称 --------
- (void)omo_edtingNickName{
    
    if(_nickNameTfd.text.length < 2){
        
        [MBProgress showInfoMessage:@"昵称位数必须大于2位小于15位"];
        return;
    }
    if(![NSString_Utils isChinese:_nickNameTfd.text]){
        
        [MBProgress showInfoMessage:@"昵称必须为全中文"];
        return;
    }
    
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@"realname"] = _nickNameTfd.text;
    
    [[OMONetworkManager sharedData]postWithURLString:@"20001" parameters:parmas success:^(id responseObject) {
        
        if(responseObject){
            
            NSDictionary *dataSouce = (NSDictionary *)responseObject;
            
            [OMOIphoneManager initWithDictionary:dataSouce];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {
        
        [MBProgress hideAllHUD];
    }];
}
@end
