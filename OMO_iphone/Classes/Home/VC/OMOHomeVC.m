//
//  YXHomeVC.m
//  OMO_iphone
//
//  Created by 刘卫兵 on 2018/9/6.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOHomeVC.h"
/**  */
#import "OMOHomeHeadView.h"
/**  */
#import "OMOOnlinePlanListVC.h"
/**  */
#import "OMOOfflinePlanListVC.h"

@interface OMOHomeVC ()<UIScrollViewDelegate>

/** 专属服务 */
@property (nonatomic, strong)OMOHomeHeadView *headView;
@property (nonatomic , weak)UIButton *firstBtn;// 默认选中按钮
@property (nonatomic , weak)UIView *indicatorView;
@property (nonatomic , weak)UIView *titlesView;
@property (nonatomic , weak)UIScrollView *scrollView;

@end
@implementation OMOHomeVC

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}
- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = mainBackColor;
    [self creatBar];
    [self.bar addTitltLabelWithText:@"训练" Font:navTitleFont];
    
    [self setUpChildViewController];
    [self.view addSubview:self.headView];
    [self omo_initHeadTitleView];
    [self setScrollView];
    [self addChildVcView];
}
#pragma mark --------- 为本页面设置视图 ----------
- (void)setUpChildViewController{
    
    OMOOnlinePlanListVC *onlineVC = [[OMOOnlinePlanListVC alloc]init];
    [self addChildViewController:onlineVC];
    
    OMOOfflinePlanListVC *offlineVC = [[OMOOfflinePlanListVC alloc]init];
    [self addChildViewController:offlineVC];
}
- (OMOHomeHeadView *)headView{
    
    if(_headView == nil){
        
        _headView = [[OMOHomeHeadView alloc]initWithFrame:CGRectMake(0, IphoneY, SCREENW, 44 + 20 + (SCREENW - lwb_margin * 4) / 2.5)];
    }
    return _headView;
}
#pragma mark ---------- 顶部滑动titleview --------
- (void)omo_initHeadTitleView{
    
    UIView *titlesView = [[UIView alloc]initWithFrame:CGRectMake(lwb_margin * 2, self.headView.lwb_bottom + lwb_margin, SCREENW - lwb_margin * 4, 44)];
    titlesView.layer.cornerRadius = lwb_margin;
    titlesView.backgroundColor = WHITECOLORA(1);
    self.titlesView = titlesView;
    
    NSArray *titles = @[@"自我评估",@"线下评估"];
    CGFloat margin = (titlesView.lwb_width - IFFitFloat6(120) * 2) * 0.5;
    
    for (NSInteger i = 0;i < titles.count;i ++){
        
        UIButton *typeBtn = [[UIButton alloc]init];
        typeBtn.tag = i + 10000;
        typeBtn.backgroundColor = WHITECOLORA(1);
        [typeBtn setTitle:titles[i] forState:UIControlStateNormal];
        typeBtn.titleLabel.font = navTitleFont;
        [typeBtn setTitleColor:textColour forState:UIControlStateNormal];
        [typeBtn setTitleColor:textLightColour forState:UIControlStateSelected];
        [typeBtn setFrame:CGRectMake(margin + IFFitFloat6(120) * i, 0, IFFitFloat6(120), 43)];
        [typeBtn addTarget:self action:@selector(titleClicker:) forControlEvents:UIControlEventTouchUpInside];
        typeBtn.enabled = YES;
        
        if(i == 0){
            
            typeBtn.selected = YES;
            self.firstBtn = typeBtn;
        }
        [titlesView addSubview:typeBtn];
    }
    [self.view addSubview:titlesView];
    // 标签视图的显示红条
    UIView *indicatorView = [[UIView alloc]init];
    // 提前计算出firstBtn.titleLabel的大小
    [self.firstBtn.titleLabel sizeToFit];
    
    // 获得当前按钮状态的字体颜色
    indicatorView.backgroundColor = [self.firstBtn titleColorForState:UIControlStateSelected];
    
    // 设置位置
    indicatorView.lwb_height = 2;
    indicatorView.lwb_y = titlesView.lwb_height;
    
    // 提前设置一个默认的大小,程序第一次进入不会有indicatorView动画
    indicatorView.lwb_width = [self.firstBtn.currentTitle sizeWithAttributes:@{NSFontAttributeName:self.firstBtn.titleLabel.font}].width;
    indicatorView.lwb_centerX = self.firstBtn.lwb_centerX;
    
    self.indicatorView = indicatorView;
    [titlesView addSubview:indicatorView];
}
#pragma mark ---- 顶部标签视图的点击事件 ------
- (void)titleClicker:(UIButton *)sender{
    
    if (sender.selected){
        
        return;
    }
    
    for (UIView *view in [self.titlesView subviews]){
        
        if ([view isKindOfClass:[UIButton class]]){
            
            ((UIButton*)view).selected = NO;
        }
    }
    
    sender.selected = YES;
    self.indicatorView.lwb_width = [sender.currentTitle sizeWithAttributes:@{NSFontAttributeName:sender.titleLabel.font}].width;
    [UIView animateWithDuration:0.25 animations:^{
        
        self.indicatorView.lwb_centerX = sender.lwb_centerX;
    }];
    
    // 设置视图随按钮滚动
    CGPoint offSet = self.scrollView.contentOffset;
    NSInteger insex = sender.tag - 10000;
    offSet.x = insex * self.scrollView.lwb_width;
    // 偏移距离
    [self.scrollView setContentOffset:offSet animated:YES];
}
#pragma mark 页面视图
- (void)setScrollView{
    // 不允许自动调整 scrollView 的内边距(隐藏滚动条)
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //     给本页面加载一个滚动视图
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.titlesView.lwb_bottom + 2, SCREENW, SCREENH - self.titlesView.lwb_bottom - 46 - Between)];
    
    scroll.backgroundColor = mainBackColor;
    // 自动分页
    scroll.pagingEnabled = YES;
    
    // 隐藏滚动条
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.showsVerticalScrollIndicator = NO;
    
    scroll.delegate = self;
    // 最大偏移范围
    scroll.contentSize = CGSizeMake(self.childViewControllers.count * SCREENW, 0);
    [self.view addSubview:scroll];
    
    self.scrollView = scroll;
}
#pragma pram 添加子控制器的 View
- (void)addChildVcView{
    
    // 获取正显示的视图的索引
    NSInteger index = self.scrollView.contentOffset.x / self.scrollView.lwb_width;
    
    //     得到正显示的视图
    if(index == 0){
        
        OMOOnlinePlanListVC *firstVC = (OMOOnlinePlanListVC *)self.childViewControllers[index];
        
        firstVC.view.frame = self.scrollView.bounds;
        
        if(firstVC.view.superview) return;
        
        [self.scrollView addSubview:firstVC.view];
    }else{
        
        OMOOfflinePlanListVC *childVC = (OMOOfflinePlanListVC *)self.childViewControllers[index];
        
        childVC.view.frame = self.scrollView.bounds;
        
        // 如果已经加载过,不会重复加载
        if(childVC.view.superview) return;
        
        [self.scrollView addSubview:childVC.view];
    }
}
#pragma mark <UIScrollViewDelegate>
/**
 *  当调用了[setContentOffset:animated]或者[scrollRectToVisible: animated:]方法时,当动画结束时才会调用
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    // 添加子控制器
    [self addChildVcView];
}
/**
 *   当调用了[setContentOffset:animated]或者[scrollRectToVisible: animated:]方法时,当动画结束时才会调用,当滚动视图人为手动拖拽时调用
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    // 获取正显示的视图的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.lwb_width;
    
    // 获得按钮
    UIButton *titleButton = (UIButton *)self.titlesView.subviews[index];
    
    // 实现按钮的点击方法
    [self titleClicker:titleButton];
    
    [self addChildVcView];
}
@end
