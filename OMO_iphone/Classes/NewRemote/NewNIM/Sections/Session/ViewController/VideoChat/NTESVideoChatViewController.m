//
//  NTESVideoChatViewController.m
//  NIM
//
//  Created by chris on 15/5/5.
//  Copyright (c) 2015年 Netease. All rights reserved.
//

#import "NTESVideoChatViewController.h"
#import "UIView+Toast.h"
#import "NTESTimerHolder.h"
#import "NTESAudioChatViewController.h"
#import "NTESNetCallChatInfo.h"
#import "NTESSessionUtil.h"
#import "NTESVideoChatNetStatusView.h"
#import "NTESGLView.h"
#import "NTESBundleSetting.h"
#import "NTESRecordSelectView.h"
#import "UIView+NTES.h"
#import "AppDelegate.h"
#import "MDPlayRemoteResourceView.h"
#define NTESUseGLView

@interface NTESVideoChatViewController ()

@property (nonatomic,assign) NIMNetCallCamera cameraType;
@property (nonatomic,strong) CALayer *localVideoLayer;
@property (nonatomic,assign) BOOL oppositeCloseVideo;
#if defined (NTESUseGLView)
@property (nonatomic, strong) NTESGLView *remoteGLView;
#endif
@property (nonatomic,weak) UIView   *localView;
@property (nonatomic,weak) UIView   *localPreView;
@property (nonatomic, assign) BOOL calleeBasy;
@property (nonatomic, assign) BOOL isHorizontal;
@property (nonatomic ,strong) MDPlayRemoteResourceView *playView;
@end

@implementation NTESVideoChatViewController

- (instancetype)initWithCallInfo:(NTESNetCallChatInfo *)callInfo
{
    self = [self initWithNibName:nil bundle:nil];
    if (self) {
        self.callInfo = callInfo;
        self.callInfo.isMute = NO;
        self.callInfo.useSpeaker = NO;
        self.callInfo.disableCammera = NO;
        if (!self.localPreView) {
            //没有的话，尝试去取一把预览层（从视频切到语音再切回来的情况下是会有的）
            self.localPreView = [NIMAVChatSDK sharedSDK].netCallManager.localPreview;
        }
        [[NIMAVChatSDK sharedSDK].netCallManager switchType:NIMNetCallMediaTypeVideo];
    }
    return self;
}


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.callInfo.callType = NIMNetCallTypeVideo;
        _cameraType = [[NTESBundleSetting sharedConfig] startWithBackCamera] ? NIMNetCallCameraBack :NIMNetCallCameraFront;
    }
    return self;
}
- (void)viewWillDisappear:(BOOL)animated{
    [self pushOrback];
    if (_playView!=nil) {
        [_playView.player stop];
        [_playView removeFromSuperview];
    }
    /**
     *  移除广播通知
     */
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"InsertVideoNotification" object:nil];
}
- (void)viewDidLoad {
    self.isHorizontal = YES;
    self.localView = self.smallVideoView;
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(insertVideoWithURL:) name:@"InsertVideoNotification" object:nil];

    self.view.backgroundColor = RGBA(20, 20, 20, 0.8);
    if (self.localPreView) {
        self.localPreView.frame = self.localView.bounds;
        [self.localView addSubview:self.localPreView];
    }
    [self initUI];
}
- (void)initUI
{
    self.netStatusView.hidden = YES;
    self.switchModelBtn.hidden = YES;
    self.connectingLabel.hidden = YES;
    self.durationLabel.hidden = YES;
    
    self.localRecordingView.layer.cornerRadius = 10.0;
    self.localRecordingRedPoint.layer.cornerRadius = 4.0;
    self.lowMemoryView.layer.cornerRadius = 10.0;
    self.lowMemoryRedPoint.layer.cornerRadius = 4.0;
    self.refuseBtn.exclusiveTouch = YES;
    self.acceptBtn.exclusiveTouch = YES;
    if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateActive) {
        [self initRemoteGLView];
    }
}

- (void)initRemoteGLView {
#if defined (NTESUseGLView)
    if (_remoteGLView !=nil) {
        [_remoteGLView removeFromSuperview];
        _remoteGLView=nil;
    }
    _remoteGLView = [[NTESGLView alloc] initWithFrame:_bigVideoView.bounds];
    [_remoteGLView setContentMode:[[NTESBundleSetting sharedConfig] videochatRemoteVideoContentMode]];
    [_remoteGLView setBackgroundColor:[UIColor clearColor]];
    _remoteGLView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [_bigVideoView addSubview:_remoteGLView];
#endif
}


#pragma mark - Call Life
- (void)startByCaller{
    [super startByCaller];
    [self startInterface];
}

- (void)startByCallee{
    [super startByCallee];
    [self waitToCallInterface];
}
- (void)onCalling{
    [super onCalling];
    [self videoCallingInterface];
}

- (void)waitForConnectiong{
    [super waitForConnectiong];
    [self connectingInterface];
}

- (void)onCalleeBusy
{
    _calleeBasy = YES;
    if (_localPreView)
    {
        [_localPreView removeFromSuperview];
    }
}

#pragma mark - Interface
//正在接听中界面
- (void)startInterface{
    self.acceptBtn.hidden = YES;
    self.refuseBtn.hidden   = YES;
    self.hungUpBtn.hidden   = NO;
//    self.connectingLabel.hidden = YES;
//    self.connectingLabel.text = @"正在呼叫，请稍候...";
//    self.switchModelBtn.hidden = YES;
    
    self.des.hidden = YES;
    self.name.hidden = YES;
    self.switchCameraBtn.hidden = YES;
    self.muteBtn.hidden = YES;
    self.disableCameraBtn.hidden = YES;
    self.localRecordBtn.hidden = YES;
    self.muteBtn.enabled = YES;
    self.disableCameraBtn.enabled = YES;
    self.localRecordBtn.enabled = YES;
    self.localRecordingView.hidden = YES;
    self.lowMemoryView.hidden = YES;
    [self.hungUpBtn removeTarget:self action:NULL forControlEvents:UIControlEventTouchUpInside];
    [self.hungUpBtn addTarget:self action:@selector(hangup) forControlEvents:UIControlEventTouchUpInside];
    self.localView = self.bigVideoView;
}

//选择是否接听界面
- (void)waitToCallInterface{
    self.acceptBtn.hidden = NO;
    self.refuseBtn.hidden   = NO;
    self.hungUpBtn.hidden   = YES;
    NSString *nick = [NTESSessionUtil showNick:self.callInfo.caller inSession:nil];
//    self.connectingLabel.text = [nick stringByAppendingString:@"的来电"];
//    self.switchModelBtn.hidden = YES;
    self.name.text = nick;
    self.des.text = @"邀请您进行视频评估";
    self.des.textColor = [UIColor whiteColor];
    self.muteBtn.hidden = YES;
    self.switchCameraBtn.hidden = YES;
    self.disableCameraBtn.hidden = YES;
    self.localRecordBtn.hidden = YES;
    self.localRecordingView.hidden = YES;
    self.lowMemoryView.hidden = YES;
}

//连接对方界面
- (void)connectingInterface{
    
//    self.switchModelBtn.hidden = YES;
//    self.connectingLabel.hidden = NO;
//    self.connectingLabel.text = @"正在连接对方...请稍后...";
    self.acceptBtn.hidden = YES;
    self.refuseBtn.hidden   = YES;
    self.hungUpBtn.hidden   = NO;
    self.name.hidden = YES;
    self.des.hidden = YES;
    self.switchCameraBtn.hidden = NO;
    self.muteBtn.hidden = YES;
    self.disableCameraBtn.hidden = YES;
    self.localRecordBtn.hidden = YES;
    self.localRecordingView.hidden = YES;
    self.lowMemoryView.hidden = YES;
    [self.hungUpBtn removeTarget:self action:NULL forControlEvents:UIControlEventTouchUpInside];
    [self.hungUpBtn addTarget:self action:@selector(hangup) forControlEvents:UIControlEventTouchUpInside];
}

//接听中界面(视频)
- (void)videoCallingInterface{
    
//    NIMNetCallNetStatus status = [[NIMAVChatSDK sharedSDK].netCallManager netStatus:self.peerUid];
//    [self.netStatusView refreshWithNetState:status];
//    self.switchModelBtn.hidden = YES;
//    [self.switchModelBtn setTitle:@"语音模式" forState:UIControlStateNormal];
//    self.connectingLabel.hidden = YES;
    self.acceptBtn.hidden = YES;
    self.refuseBtn.hidden   = YES;
    self.hungUpBtn.hidden   = NO;

    self.muteBtn.hidden = YES;
    self.switchCameraBtn.hidden = NO;
    self.disableCameraBtn.hidden = YES;
    self.localRecordBtn.hidden = YES;
    self.muteBtn.enabled = NO;
    self.disableCameraBtn.enabled = NO;
    self.localRecordBtn.enabled = NO;
    
    self.muteBtn.selected = self.callInfo.isMute;
    self.disableCameraBtn.selected = self.callInfo.disableCammera;
    self.localRecordBtn.selected = ![self allRecordsStopped];
    self.localRecordingView.hidden = [self allRecordsStopped];
    self.lowMemoryView.hidden = YES;
    
    [self.hungUpBtn removeTarget:self action:NULL forControlEvents:UIControlEventTouchUpInside];
    [self.hungUpBtn addTarget:self action:@selector(hangup) forControlEvents:UIControlEventTouchUpInside];
    self.localVideoLayer.hidden = NO;
    self.localPreView.hidden = NO;
}

//切换接听中界面(语音)
- (void)audioCallingInterface{
    NTESAudioChatViewController *vc = [[NTESAudioChatViewController alloc] initWithCallInfo:self.callInfo];
    [UIView  beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.75];
    [self.navigationController pushViewController:vc animated:NO];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
    [UIView commitAnimations];
    NSMutableArray * vcs = [self.navigationController.viewControllers mutableCopy];
    [vcs removeObject:self];
    self.navigationController.viewControllers = vcs;
}

- (void)udpateLowSpaceWarning:(BOOL)show {
    
    self.lowMemoryView.hidden = !show;
    self.localRecordingView.hidden = show;
    
}


#pragma mark - IBAction

- (IBAction)acceptToCall:(id)sender{
    BOOL accept = (sender == self.acceptBtn);
    //防止用户在点了接收后又点拒绝的情况
    [self response:accept];
}
//关闭声音
- (IBAction)mute:(BOOL)sender{
    self.callInfo.isMute = !self.callInfo.isMute;
    self.player.volume = !self.callInfo.isMute;
    [[NIMAVChatSDK sharedSDK].netCallManager setMute:self.callInfo.isMute];
    self.muteBtn.selected = self.callInfo.isMute;
}

/**
 * 接收通知，切换横竖屏，插入视频播放
 */
-(void)insertVideoWithURL:(NSNotification *)info{
    if(self.isHorizontal){
        //接收通知 旋转屏幕并改变视频摄像头大小位置重新布局
        AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        appDelegate.allowRotation = YES;
        [self setNewOrientation:YES];
        _localView.frame = CGRectMake(SCREENW*0.8, 0, SCREENW*0.2, SCREENW*0.2);
        _localPreView.frame = CGRectMake(SCREENW*0.8, 0, SCREENW*0.2, SCREENW*0.2);
        [self onLocalDisplayviewReady:_localPreView];
        _bigVideoView.frame = CGRectMake(SCREENW*0.8, SCREENW*0.2, SCREENW*0.2, SCREENW*0.2);
        //_remoteGLView.frame = CGRectMake(SCREENW-100, 200, 100, 100);
        [self initRemoteGLView];
        self.hungUpBtn.frame = CGRectMake(SCREENW*0.9 -30 , SCREENW*0.4+10, 60, 60);
        
        
        self.switchCameraBtn.frame= CGRectMake(SCREENW*0.8 , SCREENW*0.4+70, SCREENW*0.2, SCREENH-SCREENW*0.4-70);
        [self.playView setVideoUrl:info];
        [self.view addSubview:self.playView];
        self.isHorizontal = NO;
    }else{
        //接收通知 旋转屏幕并改变视频摄像头大小位置重新布局
        AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        appDelegate.allowRotation = NO;
        [self setNewOrientation:NO];
        
        _bigVideoView.frame = CGRectMake(0, 0, SCREENW, SCREENH);
        [self initRemoteGLView];
        _localView.frame = CGRectMake(30, 30, 0.264*SCREENW, 0.37*SCREENW);
        _localPreView.frame = CGRectMake(30, 30, 0.264*SCREENW, 0.37*SCREENW);
        [self onLocalDisplayviewReady:_localPreView];
        [self.playView.player stop];
        [self.playView removeFromSuperview];
        self.hungUpBtn.frame = CGRectMake(SCREENW/2-50, SCREENH-60, 60, 60);
        self.switchCameraBtn.frame= CGRectMake(0, SCREENH-30, 100, 30);
        self.isHorizontal = YES;
    }
}
#pragma mark ------- 切换摄像头 --------
- (IBAction)switchCamera:(id)sender{
    if (self.cameraType == NIMNetCallCameraFront) {
        self.cameraType = NIMNetCallCameraBack;
    }else{
        self.cameraType = NIMNetCallCameraFront;
    }
    [[NIMAVChatSDK sharedSDK].netCallManager switchCamera:self.cameraType];
    self.switchCameraBtn.selected = (self.cameraType == NIMNetCallCameraBack);
    
//    [self insertVideoWithURL:@"http://movie.vods2.cnlive.com/3/vod/2018/1024/3_de63bd3bcb2345e39b645f1bead1a1b7/ff80808165fb8da10166a4a004f1578f_1500.m3u8"];
}

//关闭摄像头
- (IBAction)disableCammera:(id)sender{
    self.callInfo.disableCammera = !self.callInfo.disableCammera;
    [[NIMAVChatSDK sharedSDK].netCallManager setCameraDisable:self.callInfo.disableCammera];
    self.disableCameraBtn.selected = self.callInfo.disableCammera;
    if (self.callInfo.disableCammera) {
        [self.localPreView removeFromSuperview];
        [[NIMAVChatSDK sharedSDK].netCallManager control:self.callInfo.callID type:NIMNetCallControlTypeCloseVideo];
    }else{
        [self.localView addSubview:self.localPreView];

        [[NIMAVChatSDK sharedSDK].netCallManager control:self.callInfo.callID type:NIMNetCallControlTypeOpenVideo];
    }
}
#pragma mark --------- 录制 -----------
- (IBAction)localRecord:(id)sender {
    //出现录制选择框
    if ([self allRecordsStopped]) {
        [self showRecordSelectView:YES];
    }
    //同时停止所有录制
    else
    {
        //结束语音对话
        if (self.callInfo.audioConversation) {
            [self stopAudioRecording];
            if([self allRecordsStopped])
            {
                self.localRecordBtn.selected = NO;
                self.localRecordingView.hidden = YES;
                self.lowMemoryView.hidden = YES;
            }
        }
        [self stopRecordTaskWithVideo:YES];
    }

}


- (IBAction)switchCallingModel:(id)sender{
    [[NIMAVChatSDK sharedSDK].netCallManager control:self.callInfo.callID type:NIMNetCallControlTypeToAudio];
    [self switchToAudio];
}


#pragma mark - NTESRecordSelectViewDelegate

-(void)onRecordWithAudioConversation:(BOOL)audioConversationOn myMedia:(BOOL)myMediaOn otherSideMedia:(BOOL)otherSideMediaOn
{
    if (audioConversationOn) {
        //开始语音对话
        if ([self startAudioRecording]) {
            self.callInfo.audioConversation = YES;
            self.localRecordBtn.selected = YES;
            self.localRecordingView.hidden = NO;
            self.lowMemoryView.hidden = YES;
        }
    }
    [self recordWithAudioConversation:audioConversationOn myMedia:myMediaOn otherSideMedia:otherSideMediaOn video:YES];
}


#pragma mark - NIMNetCallManagerDelegate
- (void)onLocalDisplayviewReady:(UIView *)displayView
{
    if (_calleeBasy) {
        return;
    }
    
    if (self.localPreView) {
        [self.localPreView removeFromSuperview];
    }
    
    self.localPreView = displayView;
    displayView.frame = self.localView.bounds;

    [self.localView addSubview:displayView];
}

#if defined(NTESUseGLView)
/**
 *  远程视频YUV数据就绪
 *
 *  @param yuvData  远程视频YUV数据, 紧凑型 (stride 等于 width)
 *  @param width    远程视频画面宽度
 *  @param height   远程视频画面长度
 *  @param user     远程视频画面属于的用户
 *
 *  @discussion 将YUV数据直接渲染在OpenGL上比UIImageView贴图占用更少的cpu
 */
- (void)onRemoteYUVReady:(NSData *)yuvData
                   width:(NSUInteger)width
                  height:(NSUInteger)height
                    from:(NSString *)user
{
    if (([[UIApplication sharedApplication] applicationState] == UIApplicationStateActive) && !self.oppositeCloseVideo) {
        
        if (!_remoteGLView) {
            [self initRemoteGLView];
        }
        [_remoteGLView render:yuvData width:width height:height];
    }
}
#else
- (void)onRemoteImageReady:(CGImageRef)image{
    if (self.oppositeCloseVideo) {
        return;
    }
    self.bigVideoView.contentMode = UIViewContentModeScaleAspectFill;
    self.bigVideoView.image = [UIImage imageWithCGImage:image];
}
#endif
/**
 *  收到对方网络通话控制信息，用于方便通话双方沟通信息
 *
 *  @param callID  相关网络通话的call id
 *  @param user    对方帐号
 *  @param control 控制类型
 */
- (void)onControl:(UInt64)callID
             from:(NSString *)user
             type:(NIMNetCallControlType)control{
    [super onControl:callID from:user type:control];
    switch (control) {
        case NIMNetCallControlTypeToAudio:
            [self switchToAudio];
            break;
        case NIMNetCallControlTypeCloseVideo:
            [self resetRemoteImage];
            self.oppositeCloseVideo = YES;
            [self.view makeToast:@"对方关闭了摄像头"
                        duration:2
                        position:CSToastPositionCenter];
            break;
        case NIMNetCallControlTypeOpenVideo:
            self.oppositeCloseVideo = NO;
            [self.view makeToast:@"对方开启了摄像头"
                        duration:2
                        position:CSToastPositionCenter];
            break;
        default:
            break;
    }
}

/**
 点对点通话建立成功
 
 @param callID call id
 */
- (void)onCallEstablished:(UInt64)callID
{
    if (self.callInfo.callID == callID) {
        [super onCallEstablished:callID];
        
//        self.durationLabel.hidden = NO;
//        self.durationLabel.text = self.durationDesc;
        
        if (self.localView == self.bigVideoView) {
            self.localView = self.smallVideoView;
            
            if (self.localPreView) {
                [self onLocalDisplayviewReady:self.localPreView];
            }
        }
    }
}
/**
 *  当前通话网络状态
 *
 *  @param status 网络状态
 *  @param user   网络状态对应的用户；如果是自己，表示自己的发送网络状态
 */
- (void)onNetStatus:(NIMNetCallNetStatus)status user:(NSString *)user
{
    if ([user isEqualToString:self.peerUid]) {
//        [self.netStatusView refreshWithNetState:status];
    }
}

/**
 *  录制成功开始
 *
 *  @param callID  录制的相关网络通话的call id
 *  @param fileURL 录制的文件路径
 *  @param userId  录制用户对象的id
 */
- (void)onRecordStarted:(UInt64)callID fileURL:(NSURL *)fileURL                          uid:(NSString *)userId
{
    [super onRecordStarted:callID fileURL:fileURL uid:userId];
    if (self.callInfo.callID == callID) {
        self.localRecordBtn.selected = YES;
        self.localRecordingView.hidden = NO;
        self.lowMemoryView.hidden = YES;
    }
}

/**
 *  录制发生了错误
 *
 *  @param error  错误
 *  @param callID 录制错误相关网络通话的call id
 *  @param userId 录制用户对象的id
 */
- (void)onRecordError:(NSError *)error
                    callID:(UInt64)callID
                       uid:(NSString *)userId;
{
    
    [super onRecordError:error callID:callID uid:userId];
    if (self.callInfo.callID == callID) {
        //判断是否全部结束
        if([self allRecordsStopped])
        {
            self.localRecordBtn.selected = NO;
            self.localRecordingView.hidden = YES;
            self.lowMemoryView.hidden = YES;
        }
    }
}
/**
 *  录制成功结束
 *
 *  @param callID  录制的相关网络通话的call id
 *  @param fileURL 录制的文件路径
 *  @param userId  录制用户对象的id
 */
- (void) onRecordStopped:(UInt64)callID
                      fileURL:(NSURL *)fileURL
                          uid:(NSString *)userId;

{
    [super onRecordStopped:callID fileURL:fileURL uid:userId];
    if (self.callInfo.callID == callID) {
        if([self allRecordsStopped])
        {
            self.localRecordBtn.selected = NO;
            self.localRecordingView.hidden = YES;
            self.lowMemoryView.hidden = YES;
        }
    }
}

#pragma mark - M80TimerHolderDelegate

- (void)onNTESTimerFired:(NTESTimerHolder *)holder{
    [super onNTESTimerFired:holder];
//    self.durationLabel.text = self.durationDesc;
}

#pragma mark - Misc
- (void)switchToAudio{
    [self audioCallingInterface];
}

- (NSString*)durationDesc{
    if (!self.callInfo.startTime) {
        return @"";
    }
    NSTimeInterval time = [NSDate date].timeIntervalSince1970;
    NSTimeInterval duration = time - self.callInfo.startTime;
    return [NSString stringWithFormat:@"%02d:%02d",(int)duration/60,(int)duration%60];
}

- (void)resetRemoteImage{
#if defined (NTESUseGLView)
    [self.remoteGLView render:nil width:0 height:0];
#endif

    self.bigVideoView.image = [UIImage imageNamed:@"netcall_bkg.png"];
}
//转屏核心代码
- (void)setNewOrientation:(BOOL)fullscreen

{
    
    if (fullscreen) {
        
        NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
        
        [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
        
        NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
        
        [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
        
    }else{
        
        NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
        
        [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
        
        NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
        
        [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
        
    }
    
}

//离开这个界面别忘记关闭横屏
-(void)pushOrback

{
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    appDelegate.allowRotation = NO;
    
    [self setNewOrientation:NO];
    
}
- (MDPlayRemoteResourceView *)playView{
    
    if(_playView == nil){
        _playView = [[MDPlayRemoteResourceView alloc]initWithFrame:CGRectMake(0, 0, SCREENW*0.8, SCREENH)];
    }
    return _playView;
}
@end
