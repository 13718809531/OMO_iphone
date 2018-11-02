//
//  BaseViewController.h
//  JXYH
//
//  Created by 惠发 on 2017/11/23.
//  Copyright © 2017年 友惠家(北京)信息科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PublicNavgationBar.h"
@interface BaseViewController : UIViewController
//假navBar
@property (nonatomic,strong) PublicNavgationBar *bar;
//是否是h5
@property (nonatomic,assign) BOOL isH5;//如果设这个参数为yes,则返回时间发生改变
//创建bar
-(void)creatBar;
// 返回事件
- (void)backClick;
//添加标题
-(void)addTitltLabelWithText:(NSString *)text Font:(CGFloat )font;
//添加左侧按钮
-(void)addLeftButtonWithImage:(UIImage *)image;
//添加右侧图片按钮
-(void)addRightButtonWithImage:(UIImage *)image;
//添加右侧custom按钮
-(void)addRightButtonWithButton:(UIButton *)button;

@end
