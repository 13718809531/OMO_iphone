//
//  OMORehabilitationProgrammeDetailVC.m
//  OMO_iphone
//
//  Created by wy on 2018/10/10.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMORehabilitationProgrammeDetailVC.h"
/**  */
#import "AppDelegate.h"
//** 底部视图 */
#import "OMORehabilitationDetailBottomView.h"
/** 分享视图 */
#import "OMOPbulicShareView.h"

@interface OMORehabilitationProgrammeDetailVC ()<
thridDelegate,
OMORehabilitationDelegate>

/** 底部分享,支付按钮 */
@property (nonatomic, strong)OMORehabilitationDetailBottomView *bottomView;

@end

@implementation OMORehabilitationProgrammeDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = mainBackColor;
    
    [self.view addSubview:self.bottomView];
}

@end
