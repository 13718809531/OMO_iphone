//
//  OMOFirstLaunchVC.m
//  OMO_iphone
//
//  Created by wy on 2018/10/18.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOFirstLaunchVC.h"
#import <AVFoundation/AVFoundation.h>
/**  */
#import "OMOGenderView.h"
/**  */
#import "AppDelegate.h"
/**  */
#import "OMOTabBarController.h"
/**  */
#import "OMOBirthdayView.h"
/**  */
#import "OMOSelectPartsVC.h"

@interface OMOFirstLaunchVC ()

/**  */
@property (nonatomic, strong)NSArray *videos;
@property (strong, nonatomic)AVPlayer *myPlayer;//播放器
@property (strong, nonatomic)AVPlayerItem *item;//播放单元
@property (strong, nonatomic)AVPlayerLayer *playerLayer;//播放界面（layer）
/** 记录播放 */
@property (nonatomic,assign)NSInteger index;

/** 设置性别 */
@property (nonatomic, strong)OMOGenderView *genderView;
/**  */
@property (nonatomic, strong)OMOBirthdayView *birthdayView;
/** 跳过 */
@property (nonatomic,strong)UIButton *nextBtn;

@end

@implementation OMOFirstLaunchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _index = 0;
    _videos = @[@"http://img00.sun-hc.com/file/resource/20186/1529633366531.mp4",@"http://img00.sun-hc.com/file/resource/20186/1529633366531.mp4",@"http://img00.sun-hc.com/file/resource/20186/1529633366531.mp4",@"http://img00.sun-hc.com/file/resource/20186/1529633366531.mp4"];
    
    // 第一步：首先我们需要一个播放的网址
    NSURL *mediaURL = [NSURL URLWithString:_videos[_index]];
    // 第二步：初始化一个播放单元
    self.item = [AVPlayerItem playerItemWithURL:mediaURL];
    // 第三步：初始化一个播放器对象
    self.myPlayer = [AVPlayer playerWithPlayerItem:self.item];
    // 第四步：初始化一个播放器的Layer
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.myPlayer];
    self.playerLayer.frame = CGRectMake(0, 0, SCREENW, SCREENH);
    [self.view.layer addSublayer:self.playerLayer];
    // 第五步：开始播放
    [self.myPlayer play];
    self.myPlayer.rate = 3.0;//注意更改播放速度要在视频开始播放之后才会生效
    [self omo_notificationCenterPlayer];
    
    [self.view addSubview:self.nextBtn];
    [self.view addSubview:self.genderView];
    [self.view addSubview:self.birthdayView];
}
#pragma mark -------- 监测视频 ---------
- (void)omo_notificationCenterPlayer{
    
    __weak typeof(self) weakSelf = self;
    
    dispatch_queue_t queue = dispatch_queue_create("com.gcd-group.www", DISPATCH_QUEUE_CONCURRENT);
    
    [self.myPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:queue usingBlock:^(CMTime time) {
        
        AVPlayerItem *item = weakSelf.item;
        NSInteger currentTime = item.currentTime.value / item.currentTime.timescale;
        NSInteger totalTime   = CMTimeGetSeconds(item.duration);
        
        if(currentTime != 0 && totalTime != 0){
            
            if(currentTime == totalTime){
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    weakSelf.index = weakSelf.index + 1;
                    [weakSelf omo_playerOfIndex:weakSelf.index];
                });
            }
        }
    }];
}
- (void)omo_playerOfIndex:(NSInteger)index{
    
    self.item = nil;
    [self.myPlayer pause];
    
    if(index == 1){
        
        [UIView animateWithDuration:0.25 animations:^{
            
            self.genderView.lwb_bottom = SCREENH;
        }];
    }
    if(index == 2){
        
        if([OMOIphoneManager sharedData].gender.length <= 0){
            
            return;
        }else{
            
            [UIView animateWithDuration:0.25 animations:^{
                
                self.birthdayView.lwb_bottom = SCREENH;
            }];
        }
    }else if(index == 3){
        
        if([OMOIphoneManager sharedData].birthday.length <= 0){
            
            return;
        }else{
            
            [self.view addSubview:self.birthdayView];
            [UIView animateWithDuration:0.25 animations:^{
                
                self.birthdayView.lwb_bottom = SCREENH;
            }];
        }
    }else if(index == 4){
        
        if([OMOIphoneManager sharedData].birthday.length <= 0){
            
            return;
        }else{
            
            [self.view addSubview:self.birthdayView];
            [UIView animateWithDuration:0.25 animations:^{
                
                self.birthdayView.lwb_bottom = SCREENH;
            }];
        }
    }
    // 第一步：首先我们需要一个播放的网址
    NSURL *mediaURL = [NSURL URLWithString:_videos[index]];
    // 第二步：初始化一个播放单元
    self.item = [AVPlayerItem playerItemWithURL:mediaURL];
    // 第三步：初始化一个播放器对象
    self.myPlayer = [AVPlayer playerWithPlayerItem:self.item];
    // 第四步：初始化一个播放器的Layer
    self.playerLayer.player = self.myPlayer;
    // 第五步：开始播放
    [self.myPlayer play];
    self.myPlayer.rate = 3.0;//注意更改播放速度要在视频开始播放之后才会生效
    [self omo_notificationCenterPlayer];
}
- (UIButton *)nextBtn{
    if(_nextBtn == nil){
        
        _nextBtn = [[UIButton alloc]init];
        _nextBtn.lwb_width = 100;
        _nextBtn.lwb_height = 40.f;
        _nextBtn.lwb_x = SCREENW - lwb_margin * 2 - 100;
        _nextBtn.lwb_y = Between + 27;
        _nextBtn.layer.masksToBounds = YES;
        _nextBtn.layer.cornerRadius = 20.f;
        _nextBtn.layer.borderWidth = 1.f;
        _nextBtn.layer.borderColor = mainBackColor.CGColor;
        _nextBtn.backgroundColor = WHITECOLORA(1);
        [_nextBtn setTitle:@"跳过" forState:UIControlStateNormal];
        _nextBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_nextBtn setTitleColor:textColour forState:UIControlStateNormal];
        [_nextBtn addTarget:self action:@selector(omo_setRootViewController) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
}
- (OMOGenderView *)genderView{
    
    if(_genderView == nil){
        
        _genderView = [[OMOGenderView alloc]initWithFrame:CGRectMake(lwb_margin, SCREENH, SCREENW - lwb_margin * 2, SCREENH * 0.5)];
        
        __weak typeof(self) weakSelf = self;
        
        _genderView.genderBlock = ^{
          
            [UIView animateWithDuration:0.25 animations:^{
                
                weakSelf.genderView.lwb_y = SCREENH;
            } completion:^(BOOL finished) {
                
                [weakSelf.genderView removeFromSuperview];
                [weakSelf omo_playerOfIndex:2];
            }];
        };
    }
    return _genderView;
}
- (OMOBirthdayView *)birthdayView{
    
    if(_birthdayView == nil){
        
        _birthdayView = [[OMOBirthdayView alloc]initWithFrame:CGRectMake(lwb_margin, SCREENH, SCREENW - lwb_margin * 2, SCREENH * 0.5)];
        
        __weak typeof(self) weakSelf = self;
        
        _birthdayView.birthdayBlock = ^{
            
            [UIView animateWithDuration:0.25 animations:^{
                
                weakSelf.birthdayView.lwb_y = SCREENH;
            } completion:^(BOOL finished) {
                
                [weakSelf.birthdayView removeFromSuperview];
                OMOSelectPartsVC *seletPartsVC = [[OMOSelectPartsVC alloc]init];
                [weakSelf.navigationController pushViewController:seletPartsVC animated:YES];
            }];
        };
    }
    return _birthdayView;
}
#pragma mark ------ 切换到tabbar ---------
- (void)omo_setRootViewController{
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    app.window.rootViewController = [[OMOTabBarController alloc]init];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
