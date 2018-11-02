//
//  YXTabBarController.m
//  OMO_iphone
//
//  Created by 刘卫兵 on 2018/9/6.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOTabBarController.h"
#import "OMOHomeVC.h"
#import "OMOFoundVC.h"
#import "OMOMineVC.h"

@interface OMOTabBarController ()

@end

@implementation OMOTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 只要appearance创建对象,默认所有控件都会遵守该对象的设置
    self.tabBarItem = [UITabBarItem appearance];
    
    [self setTabBarController];
}
#pragma mark 加载控件
- (void)setTabBarController{
    
    [self setUpOneChildViewController:[[OMOHomeVC alloc]init] title:@"训练" imager:@"Bar_Xunlian_Normal" selectImager:@"Bar_Xunlian_Select"];
    
    [self setUpOneChildViewController:[[OMOFoundVC alloc] init] title:@"发现" imager:@"Bar_Found_Normal" selectImager:@"Bar_Found_Select"];
    
    [self setUpOneChildViewController:[[OMOMineVC alloc]init] title:@"我的" imager:@"Bar_Mine_Normal" selectImager:@"Bar_Mine_Select"];
}
#pragma mark  封装方法,加载 TabBar 上的控件
- (void)setUpOneChildViewController:(UIViewController *)vc title:(NSString *)title imager:(NSString *)image selectImager:(NSString *)selectImager{
    if(vc && title.length && image.length && selectImager.length){
        //        vc.view.backgroundColor = LWBColorAlpha(206, 206, 206, 206);
        
        UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:vc];
        
        navigationController.tabBarItem.title = title;
        
        navigationController.tabBarItem.image = [[UIImage imageNamed:image]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //        navigationController.tabBarItem.imageInsets = UIEdgeInsetsMake(12, 12, 12, 12);
        // 选中图片不需要渲染成别的颜色,保持美工的颜色,另一方法为选中图片,将图片属性改为Original
        navigationController.tabBarItem.selectedImage = [[UIImage imageNamed:selectImager]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        [self addChildViewController:navigationController];
    }
}
#pragma mark 重新设置 TabBarItem
- (void)setTabBarItem:(UITabBarItem *)tabBarItem
{
    // 正常状态下设置字体和文字颜色
    NSMutableDictionary *normalDic = [[NSMutableDictionary alloc]init];
    
    // 设置字体大小
    normalDic[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    // 设置文字颜色
    normalDic[NSForegroundColorAttributeName] = DetailColor;
    
    //    normalDic[NSBackgroundColorAttributeName] = textColour;
    
    [tabBarItem setTitleTextAttributes:normalDic forState:UIControlStateNormal];
    
    // 选中状态下的字体和颜色
    NSMutableDictionary *selectDic = [[NSMutableDictionary alloc]init];
    
    selectDic[NSFontAttributeName] = [UIFont boldSystemFontOfSize:12];
    selectDic[NSForegroundColorAttributeName] = textLightColour;
    //    selectDic[NSBackgroundColorAttributeName] = [UIColor blackColor];
    [tabBarItem setTitleTextAttributes:selectDic forState:UIControlStateSelected];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
