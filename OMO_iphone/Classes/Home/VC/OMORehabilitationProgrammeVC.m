//
//  OMORehabilitationProgrammeVC.m
//  OMO_iphone
//
//  Created by wy on 2018/9/29.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMORehabilitationProgrammeVC.h"
/** 上半部分 */
#import "OMORehabilitationHeadView.h"
/** 未登录下半部分 */
#import "OMONotLoginRehabilitationBottomView.h"
/** 康复结果,建议 */
#import "OMOAssessmentView.h"
/** 训练天数 */
#import "OMOTotalDayView.h"
/** 辅具 */
#import "OMODevicesView.h"
/** 视频 */
#import "OMOAssessmentVideoView.h"
/** 支付弹出视图 */
#import "OMOAssessmentPayAlertView.h"
//** 登录底部视图 */
#import "OMORehabilitationBottomView.h"
/** 分享视图 */
#import "OMOPbulicShareView.h"
/** 分享成功 */
#import "OMOShareSuccessVC.h"
/**  */
#import "OMOSelectPartsVC.h"

@interface OMORehabilitationProgrammeVC ()
<UIScrollViewDelegate,
OMORehabilitationDelegate>

@property (strong, nonatomic)UIScrollView *scrollView;// 主页面
/** 底部分享,支付按钮 */
@property (nonatomic, strong)OMORehabilitationBottomView *bottomView;
/** 保存判断登录信息字段 */
@property (nonatomic,copy)NSString *user_id;
/** 上半部分 */
@property (nonatomic, strong)OMORehabilitationHeadView *headView;
/** 未登录下半部分 */
@property (nonatomic, strong)OMONotLoginRehabilitationBottomView *noLoginbottomView;
/** 评估结果,建议 */
@property (nonatomic, strong)OMOAssessmentView *assessmentView;
/** 训练天数 */
@property (nonatomic, strong)OMOTotalDayView *totalDayView;
/** 辅具 */
@property (nonatomic, strong)OMODevicesView *devicesView;
/** 视频 */
@property (nonatomic, strong)OMOAssessmentVideoView *videoView;

@end

@implementation OMORehabilitationProgrammeVC

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self omo_determineLoginInformation];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = mainBackColor;
    
    [OMOIphoneManager sharedData].kangFuBao_name = _kangFuBaoModel.treat_name;
}
#pragma mark ------- 重写返回按钮的返回逻辑 ------------
- (void)backClick{
    
    for (UIViewController *vc in self.navigationController.viewControllers) {
        
        if([vc isKindOfClass:[OMOSelectPartsVC class]]){
            
            [self.navigationController popToViewController:vc animated:YES];
        }
    }
}
#pragma mark ------- 判断登录信息 ----------
- (void)omo_determineLoginInformation{
    
    NSString *newUser_id = [OMOIphoneManager sharedData].user_id;
    
    if(self.scrollView.superview){
        
        [self.scrollView removeFromSuperview];
    }
    
    if(newUser_id.length <= 0){
        //
        self.scrollView.frame = CGRectMake(0, 0, SCREENW, SCREENH);
        [self.scrollView addSubview:self.headView];
        [self.scrollView addSubview:self.noLoginbottomView];
        [self.scrollView setContentSize:CGSizeMake(SCREENW, SCREENH)];
    }else{
        //
        self.scrollView.frame = CGRectMake(0, 0, SCREENW, SCREENH - 60);
        [self.scrollView addSubview:self.headView];
        [self.scrollView addSubview:self.assessmentView];
        [self.scrollView addSubview:self.totalDayView];
        [self.scrollView addSubview:self.devicesView];
        [self.scrollView addSubview:self.videoView];
        [self.view addSubview:self.bottomView];
        [self.scrollView setContentSize:CGSizeMake(SCREENW, self.videoView.lwb_bottom + lwb_margin * 2)];
    }
    [self.view addSubview:self.scrollView];
    [self creatBar];
    [self.bar addLeftButtonWithImage:[UIImage imageNamed:@"App_Back"]];
    [self.bar addTitltLabelWithText:@"测评报告" Font:navTitleFont Color:WHITECOLORA(1)];
    self.bar.backgroundColor = [UIColor clearColor];
    self.bar.line.backgroundColor = [UIColor clearColor];
}
#pragma mark 页面视图
- (UIScrollView *)scrollView{
    
    if(_scrollView == nil){
        //     给本页面加载一个滚动视图
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREENW, SCREENH)];
        
        _scrollView.backgroundColor = mainBackColor;
        // 自动分页
        //    scroll.pagingEnabled = YES;
        
        // 隐藏滚动条
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        
        _scrollView.delegate = self;
        
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
- (OMONotLoginRehabilitationBottomView *)noLoginbottomView{
    
    if(_noLoginbottomView == nil){
        
        _noLoginbottomView = [[OMONotLoginRehabilitationBottomView alloc]init];
    }
    return _noLoginbottomView;
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
- (OMORehabilitationBottomView *)bottomView{
    
    if(_bottomView == nil){
        
        _bottomView = [[OMORehabilitationBottomView alloc]init];
        _bottomView.delegate = self;
        _bottomView.kangFuBaoModel = _kangFuBaoModel;
    }
    return _bottomView;
}
- (void)omo_rehabilitationBottomClickOfTag:(NSInteger)tag{
    
    switch (tag) {
        case 1:
            [self omo_obtainRehabilitationPlanOfpay];
            break;
        case 2:
            [self omo_obtainRehabilitationPlanOfShare];
            break;
        default:
            break;
    }
}
#pragma mark --------- 支付获取训练方案 -----------
- (void)omo_obtainRehabilitationPlanOfpay{
    
    OMOAssessmentPayAlertView *payAlertView = [[OMOAssessmentPayAlertView alloc]init];
    payAlertView.numType = _numType;
    payAlertView.kangFuBaoModel = _kangFuBaoModel;
    [payAlertView show];
}
#pragma mark ---------- 分享获取训练方案 -----------
- (void)omo_obtainRehabilitationPlanOfShare{
    
    OMOPbulicShareView *shareView = [[OMOPbulicShareView alloc]init];
    
    __weak typeof(self) weakSelf = self;
    shareView.shareBlock = ^(BOOL success) {
        
        if(success){
            
            [weakSelf omo_shareSuccess];
        }
    };
    [shareView show];
}
#pragma mark ------- 分享回调判断 ---------
- (void)omo_shareSuccess{
    
    __weak typeof(self) weakSelf = self;
    [[OMONetworkManager sharedData] postWithURLString:@"60001" parameters:@{@"pe_order_id":_kangFuBaoModel.pe_order_id} success:^(id responseObject) {
        
        if(responseObject){
            
            NSDictionary *dataSouce = (NSDictionary *)responseObject;
            
            if([[dataSouce allKeys] containsObject:@"share_type"]){
                
                NSString *share_type = [NSString stringWithFormat:@"%@",dataSouce[@"share_type"]];
                
                if([share_type isEqualToString:@"1"]){
                    
                    OMOShareSuccessVC *shareSuccessVC = [[OMOShareSuccessVC alloc]init];
                    shareSuccessVC.kangFuBaoModel = weakSelf.kangFuBaoModel;
                    [weakSelf.navigationController pushViewController:shareSuccessVC animated:YES];
                }
            }
        }
    } failure:^(NSError *error) {
        
        [MBProgress hideAllHUD];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
