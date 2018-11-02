//
//  MDPlayRemoteResourceView.m
//  YXKF_MD_ipad
//
//  Created by 刘卫兵 on 2018/8/24.
//  Copyright © 2018年 元新康复. All rights reserved.
//

#import "MDPlayRemoteResourceView.h"

@interface MDPlayRemoteResourceView()

@property(strong,nonatomic)UIImageView *backgroundImageView;

@end

@implementation MDPlayRemoteResourceView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        self.backgroundColor = RGBA(20, 20, 20, 0.6);
        [self addSubview:self.backgroundImageView];
    }
    return self;
}
- (void)setVideoUrl:(NSString *)videoUrl{
    
    _videoUrl = videoUrl;
    
    if(videoUrl.length > 0){
    
        //初始化播放器
        self.player = [[SBPlayer alloc]initWithUrl:[NSURL URLWithString:videoUrl]];
        //设置标题
        [self.player setTitle:@"这是一个标题"];
        //设置播放器背景颜色
        self.player.backgroundColor = [UIColor blackColor];
        //设置播放器填充模式 默认SBLayerVideoGravityResizeAspectFill，可以不添加此语句
        self.player.mode = SBLayerVideoGravityResizeAspect;
        // 移除背景图
        [self.backgroundImageView removeFromSuperview];
        //添加播放器到视图
        [self addSubview:self.player];
        //约束，也可以使用Frame
        self.player.frame = self.frame;
        
        [self.player play];
    }
}
- (UIImageView *)backgroundImageView{
    
    if(_backgroundImageView == nil){
        
        _backgroundImageView = [[UIImageView alloc]initWithFrame:self.bounds];
        _backgroundImageView.backgroundColor = [UIColor redColor];
    }
    return _backgroundImageView;
}
@end
