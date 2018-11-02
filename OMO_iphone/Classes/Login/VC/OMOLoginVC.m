//
//  YXOMOLoginVCViewController.m
//  OMO_iphone
//
//  Created by 刘卫兵 on 2018/9/6.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOLoginVC.h"
#import "OMOMobileView.h"
#import "OMOCodeView.h"
#import "OMOTabBarController.h"
#import "OMOBindingMobileVC.h"

@interface OMOLoginVC ()

/** 手机号码登录 */
@property (nonatomic, strong)UILabel *titleLab;


@property(strong,nonatomic)OMOMobileView *mobileView;// 输入视图
@property (nonatomic,strong)UIButton *loginButton;// 去登录

@end

@implementation OMOLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //判断是否需要有返回按钮
    
    NSArray *arrViewControllers = self.navigationController.viewControllers;
    
    if ([arrViewControllers indexOfObject:self] > 0){
        
        UIBarButtonItem *itemBack = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"App_Back"] style:UIBarButtonItemStylePlain target:self action:@selector(clickBarBtLeft)];
        
        itemBack.tintColor = [UIColor grayColor];
        
        self.navigationItem.leftBarButtonItem = itemBack;
    }
    self.view.backgroundColor = mainBackColor;
    [self.view addSubview:self.titleLab];
    [self.view addSubview:self.mobileView];
//    [self.view addSubview:self.codeView];
//    [self.view addSubview:self.loginButton];
//    [self.view addSubview:self.titleLab];
//    [self.view addSubview:self.leftLineView];
//    [self.view addSubview:self.rightLineView];
//    [self.view addSubview:self.wxLoginbtn];
}
- (void)clickBarBtLeft{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
- (UILabel *)titleLab{
    
    if(_titleLab == nil){
        
        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(IFFitFloat6(50), IphoneY + IFFitFloat6(60), SCREENW, 40)];
        _titleLab.text = @"手机号码登录";
        _titleLab.textColor = textColour;
        _titleLab.font = BoldFont(28);
        _titleLab.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLab;
}
- (OMOMobileView *)mobileView{
    
    if(_mobileView == nil){
        
        _mobileView = [[OMOMobileView alloc]initWithFrame:CGRectMake(0, IFFitFloat6(160), SCREENW, 60)];
    }
    return _mobileView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
