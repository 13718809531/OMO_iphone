//
//  OMOCheckHealthReportVC.m
//  OMO_iphone
//
//  Created by wy on 2018/10/28.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOCheckHealthReportVC.h"
/** 上半部分 */
#import "OMORehabilitationHeadView.h"
/** 康复结果,建议 */
#import "OMOAssessmentView.h"
/** 训练天数 */
#import "OMOTotalDayView.h"
/** 辅具 */
#import "OMODevicesView.h"
/** 视频 */
#import "OMOAssessmentVideoView.h"

@interface OMOCheckHealthReportVC ()<UIScrollViewDelegate>

@property (strong, nonatomic)UIScrollView *scrollView;// 主页面
/** 保存判断登录信息字段 */
@property (nonatomic,copy)NSString *user_id;
/** 上半部分 */
@property (nonatomic, strong)OMORehabilitationHeadView *headView;
/** 评估结果,建议 */
@property (nonatomic, strong)OMOAssessmentView *assessmentView;
/** 训练天数 */
@property (nonatomic, strong)OMOTotalDayView *totalDayView;
/** 辅具 */
@property (nonatomic, strong)OMODevicesView *devicesView;
/**  */
@property (nonatomic, strong)OMOAssessmentVideoView *videoView;

@end

@implementation OMOCheckHealthReportVC

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = mainBackColor;
    
    [self.view addSubview:self.scrollView];
    
    [self creatBar];
    [self.bar addLeftButtonWithImage:[UIImage imageNamed:@"App_Back"]];
    [self.bar addTitltLabelWithText:@"我的健康报告" Font:navTitleFont Color:WHITECOLORA(1)];
    self.bar.backgroundColor = [UIColor clearColor];
    self.bar.line.backgroundColor = [UIColor clearColor];
}
#pragma mark 页面视图
- (UIScrollView *)scrollView{
    
    if(_scrollView == nil){
        //     给本页面加载一个滚动视图
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREENW, SCREENH)];
        
        _scrollView.backgroundColor = mainBackColor;
        
        // 隐藏滚动条
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        
        _scrollView.delegate = self;
        
        [_scrollView addSubview:self.headView];
        [_scrollView addSubview:self.assessmentView];
        [_scrollView addSubview:self.totalDayView];
        [_scrollView addSubview:self.devicesView];
        [_scrollView addSubview:self.videoView];
        [_scrollView setContentSize:CGSizeMake(SCREENW, self.videoView.lwb_bottom + lwb_margin * 2)];
        
        // 不允许自动调整 scrollView 的内边距(隐藏滚动条)
        if (@available(iOS 11.0, *)) {
            
            _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else {
            
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        [_scrollView setContentInset:UIEdgeInsetsZero];
    }
    return _scrollView;
}
- (OMORehabilitationHeadView *)headView{
    
    if(_headView == nil){
        
        _headView = [[OMORehabilitationHeadView alloc]init];
        _headView.scoreModel = _kangFuBaoModel.pe_score;
    }
    return _headView;
}
- (OMOAssessmentView *)assessmentView{
    
    if(_assessmentView == nil){
        
        _assessmentView = [[OMOAssessmentView alloc]initWithFrame:CGRectMake(lwb_margin, self.headView.lwb_bottom + lwb_margin * 2, SCREENW - lwb_margin * 2, 10) style:UITableViewStylePlain];
        
        __weak typeof(self) weakSelf = self;
        _assessmentView.setViewHeight = ^(CGFloat height) {
            
            weakSelf.assessmentView.lwb_height = height;
        };
        
        _assessmentView.kangFuBaoModel = _kangFuBaoModel;
    }
    return _assessmentView;
}
- (OMOTotalDayView *)totalDayView{
    
    if(_totalDayView == nil){
        
        _totalDayView = [[OMOTotalDayView alloc]initWithFrame:CGRectMake(lwb_margin, self.assessmentView.lwb_bottom + lwb_margin * 2, SCREENW - lwb_margin * 2, 80)];
        _totalDayView.pe_planModel = _kangFuBaoModel.pe_plan;
    }
    return _totalDayView;
}
- (OMODevicesView *)devicesView{
    
    if(_devicesView == nil){
        
        CGFloat height = 0.f;
        
        if(_kangFuBaoModel.mt_item.count > 0){
            
            height = 100.f;
        }
        _devicesView = [[OMODevicesView alloc]initWithFrame:CGRectMake(lwb_margin, self.totalDayView.lwb_bottom + lwb_margin * 2, SCREENW - lwb_margin * 2, height)];
        
        _devicesView.items = _kangFuBaoModel.mt_item;
    }
    return _devicesView;
}
- (OMOAssessmentVideoView *)videoView{
    
    if(_videoView == nil){
        
        CGFloat y = self.totalDayView.lwb_bottom + lwb_margin * 2;
        
        if(_kangFuBaoModel.mt_item.count > 0){
            
            y = self.devicesView.lwb_bottom + lwb_margin * 2;
        }
        
        CGFloat height = 0.f;
        
        if (_kangFuBaoModel.videos.count > 1){
            
            height += IFFitFloat6(280.f);
            
            height += IFFitFloat6(120) * (_kangFuBaoModel.videos.count - 1);
            
            height = height + 40;
        }else if(_kangFuBaoModel.videos.count == 1){
            
            height += IFFitFloat6(280.f);
            
            height = height + 40;
        }
        _videoView = [[OMOAssessmentVideoView alloc]initWithFrame:CGRectMake(lwb_margin, y, SCREENW - lwb_margin * 2, height)];
        
        _videoView.videos = _kangFuBaoModel.videos;
    }
    return _videoView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
