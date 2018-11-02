////
////  OMOMakeAssessVC.m
////  OMO_iphone
////
////  Created by wy on 2018/10/22.
////  Copyright © 2018年 刘卫兵. All rights reserved.
////
//
#import "OMOMakeAssessVC.h"
/**  */
#import "OMOMakeRemoteView.h"
/**  */
#import "OMOBookingStoreView.h"

@interface OMOMakeAssessVC ()

/**  */
@property (nonatomic, strong)OMOMakeRemoteView *remoteView;
/**  */
@property (nonatomic, strong)OMOBookingStoreView *storeView;

@end

@implementation OMOMakeAssessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatBar];
    [self.bar addLeftButtonWithImage:[UIImage imageNamed:@"App_Back"]];
    [self.bar addTitltLabelWithText:@"预约" Font:navTitleFont];
    self.view.backgroundColor = mainBackColor;
    [self.view addSubview:self.remoteView];
    [self.view addSubview:self.storeView];
}
- (OMOMakeRemoteView *)remoteView{
    
    if(_remoteView == nil){
        
        NSString *text = @"adasjklFKAJLSFBALBKJSFBJSFPWEUFLBJBJKLDSVFLDKjfvsFJA,FAHKSJVVJKWV    LV";
        CGFloat height1 = (SCREENW - lwb_margin * 10) * 0.5;
        CGFloat height = [text autoHeightWithFout:defoultFont width:SCREENW - lwb_margin * 10];
        
        _remoteView = [[OMOMakeRemoteView alloc]initWithFrame:CGRectMake(lwb_margin * 2, IphoneY + lwb_margin, SCREENW - lwb_margin * 4, height1 + height + lwb_margin * 4 + 40)];
    }
    return _remoteView;
}
- (OMOBookingStoreView *)storeView{
    
    if(_storeView == nil){
        
        NSString *text = @"adasjklFKAJLSFBALBKJSFBJSFPWEUFLBJBJKLDSVFLdasdasdasdasdasdasdasdasDKjfvsFJA,FAHKSJVVJKWV    LV";
        CGFloat height1 = (SCREENW - lwb_margin * 10) * 0.5;
        CGFloat height = [text autoHeightWithFout:defoultFont width:SCREENW - lwb_margin * 10];
        _storeView = [[OMOBookingStoreView alloc]initWithFrame:CGRectMake(lwb_margin * 2, self.remoteView.lwb_bottom + lwb_margin, SCREENW - lwb_margin * 4, height1 + height + lwb_margin * 4 + 40)];
    }
    return _storeView;
}
@end
