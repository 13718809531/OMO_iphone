//
//  OMOStratTrainingVC.m
//  OMO_iphone
//
//  Created by wy on 2018/10/23.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOStratTrainingVC.h"
/**  */
#import "TBPlayer.h"

@interface OMOStratTrainingVC ()<OMOScreenDirectionDelegate>

/**  */
@property (nonatomic, strong)TBPlayer *player;
/** 当前播放页 */
@property (nonatomic,assign)NSInteger index;

@end

@implementation OMOStratTrainingVC

//使用这里的代码也是oK的。 这里利用 NSInvocation 调用 对象的消息
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _player = [TBPlayer sharedInstance];
    _player.delegate = self;
    
    _index = 0;
//    OMOTrainResourceModel *resouceModel = [_videoSouce objectAtIndex:_index];
//    NSString *sss = @"http://img00.sun-hc.com/file/resource/20186/1529633366531.mp4";
//    NSString *url = resouceModel.url;
    [_player playWithUrl:[NSURL URLWithString:@"http://img00.sun-hc.com/file/resource/20186/1529633366531.mp4"] showView:self.view];
    [_player fullScreen];
    
    [self creatBar];
    [self.bar addLeftButtonWithImage:[UIImage imageNamed:@"App_Back"]];
    [self.bar addTitltLabelWithText:@"我的训练方案" Font:navTitleFont];
}
#pragma mark ------- 全屏切换 ---------
- (void)omo_screenDirectionWithIsFull:(BOOL)isFull{
    
    self.bar.hidden = isFull;
}
#pragma mark -------- 播放单个视频结束 ---------
- (void)omo_resumeDidEnd{
    
    _index += 1;
    
    if((_index >= _videoSouce.count)){
        
        return;
    }
//    OMOTrainResourceModel *resouceModel = [_videoSouce objectAtIndex:_index];
//    NSString *sss = @"http://img00.sun-hc.com/file/resource/20186/1529633366531.mp4";
    [_player playWithUrl:[NSURL URLWithString:@"http://img00.sun-hc.com/file/resource/20186/1529633366531.mp4"] showView:self.view];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
