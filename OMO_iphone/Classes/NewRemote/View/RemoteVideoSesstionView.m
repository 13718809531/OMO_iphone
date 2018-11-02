//
//  RemoteVideoSesstionView.m
//  YXKF_MD_ipad
//
//  Created by 刘卫兵 on 2018/8/24.
//  Copyright © 2018年 元新康复. All rights reserved.
//

#import "RemoteVideoSesstionView.h"

@interface RemoteVideoSesstionView()

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIImageView *headImg;
@property(strong,nonatomic)UIButton *remoteVideo;// 远程通话
@property (nonatomic ,strong) UILabel *desLab;
@end

@implementation RemoteVideoSesstionView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        self.backgroundColor = RGBA(20, 20, 20, 0.6);
        [self addSubview:self.headImg];
        [self addSubview:self.titleLab];
        [self addSubview:self.desLab];
        [self addSubview:self.remoteVideo];
    }
    return self;
}
- (UIImageView *)headImg{
    
    if(_headImg == nil){
        
        _headImg = [[UIImageView alloc]init];
        _headImg.image = [UIImage imageNamed:@"Remote_userHead"];
        [_headImg sizeToFit];
        _headImg.lwb_centerY = self.lwb_centerY;
        _headImg.lwb_right = self.lwb_centerX;
    }
    return _headImg;
}
- (UILabel *)titleLab{
    
    if(_titleLab == nil){
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.text = @"某人";
//        self.
        _titleLab.font = [UIFont systemFontOfSize:35];
        _titleLab.textColor = [UIColor whiteColor];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        [_titleLab sizeToFit];
        _titleLab.lwb_centerX = self.headImg.lwb_centerX;
        _titleLab.lwb_centerY = self.headImg.lwb_centerY;
    }
    return _titleLab;
}
- (UILabel *)desLab{
    
    if(_desLab == nil){
        
        _desLab = [[UILabel alloc]init];
        _desLab.text = @"正在为您连接";
        _desLab.font = [UIFont systemFontOfSize:16];
        _desLab.textColor = [UIColor whiteColor];
        _desLab.textAlignment = NSTextAlignmentCenter;
        [_desLab sizeToFit];
        _desLab.lwb_centerX = self.titleLab.lwb_centerX;
        _desLab.lwb_centerY = self.headImg.lwb_centerY + 40;
    }
    return _desLab;
}

- (UIButton *)remoteVideo{
    
    if(!_remoteVideo){
        
        _remoteVideo = [[UIButton alloc]init];
        _remoteVideo.lwb_width = 80;
        _remoteVideo.lwb_height = 80;
        _remoteVideo.lwb_y = self.lwb_bottom - 150;
        _remoteVideo.lwb_centerX = self.lwb_centerX;
        [_remoteVideo setImage:[UIImage imageNamed:@"Remote_video"] forState:UIControlStateNormal];
        [_remoteVideo addTarget:self action:@selector(md_remoteVideoToHelp) forControlEvents:UIControlEventTouchUpInside];
        _remoteVideo.layer.masksToBounds = YES;
        _remoteVideo.layer.cornerRadius = 40.f;
    }
    return _remoteVideo;
}
- (void)md_remoteVideoToHelp{
    
    if(self.cancelCallVideo){
        
        self.cancelCallVideo();
    }
}

@end
