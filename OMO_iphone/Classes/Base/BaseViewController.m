//
//  BaseViewController.m
//  JXYH
//
//  Created by 惠发 on 2017/11/23.
//  Copyright © 2017年 友惠家(北京)信息科技有限公司. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    self.tabBarController.tabBar.hidden = YES;
    
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}
//创建bar
-(void)creatBar{
    
    [self.view addSubview:self.bar];
    
    if (kDevice_Is_iPhoneX) {
        self.bar.frame = CGRectMake(0, 0, SCREENW, 88);
    }else{
        self.bar.frame = CGRectMake(0, 0, SCREENW, 64);
    }
    
    self.bar.backgroundColor = WHITECOLORA(1);
    [self.bar.leftButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
}

//返回
- (void)backClick{
    
    [MBProgress hideAllHUD];
    
    if (self.isH5) {
        
    }
    [self.navigationController popViewControllerAnimated:YES];
}
//添加标题
- (void)addTitltLabelWithText:(NSString *)text Font:(CGFloat )font{
    
    UIFont *titleFont = [UIFont systemFontOfSize:font];
    [self.bar addTitltLabelWithText:text Font:titleFont];
}
//添加左侧按钮
- (void)addLeftButtonWithImage:(UIImage *)image{
    
    [self.bar addLeftButtonWithImage:image];
}
//添加右侧图片按钮
- (void)addRightButtonWithImage:(UIImage *)image{
    
    [self.bar addRightButtonWithImage:image];
}
//添加右侧cunstom按钮
- (void)addRightButtonWithButton:(UIButton *)button{
    
    [self.bar addRightButtonWithButton:button];
}
- (PublicNavgationBar *)bar{
    
    if (!_bar) {
        
        _bar = [[PublicNavgationBar alloc] init];
    }
    return _bar;
}
@end
