//
//  OMOMakeAssessCell.m
//  OMO_iphone
//
//  Created by wy on 2018/10/22.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOMakeRemoteView.h"
/**  */
#import "TBPlayer.h"
/** 远程 */
#import "OMOResultRemoteVC.h"

@interface OMOMakeRemoteView()

/**  */
@property (nonatomic, strong)TBPlayer *player;
/** 播放view */
@property (nonatomic, strong)UIView *videoView;
/** 控制播放 */
@property (nonatomic, strong)UIButton *playerBtn;
/**  */
@property (nonatomic, strong)UILabel *videoNameLab;
/**  */
@property (nonatomic, strong)UIButton *bookingBtn;
/** 是否播放过 */
@property (nonatomic,assign)NSInteger isStart;

@end

@implementation OMOMakeRemoteView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){

        self.backgroundColor = WHITECOLORA(1);
        self.layer.cornerRadius = lwb_margin;
        [self addSubview:self.videoView];
        [self addSubview:self.videoNameLab];
        [self addSubview:self.bookingBtn];
    }
    return self;
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat height = (self.lwb_width - lwb_margin * 6) * 0.5;
    [_videoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(lwb_margin * 3);
        make.right.equalTo(self.mas_right).offset(-lwb_margin * 3);
        make.height.equalTo(@(height));
        make.top.equalTo(self.mas_top).offset(lwb_margin);
    }];
    
    [_playerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.videoView.mas_centerX);
        make.centerY.equalTo(self.videoView.mas_centerY);
        make.height.mas_equalTo(height - lwb_margin * 4);
        make.width.mas_equalTo(height - lwb_margin * 4);
    }];
    
    [_videoNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(lwb_margin * 3);
        make.right.equalTo(self.mas_right).offset(-lwb_margin * 3);
        make.top.equalTo(self.videoView.mas_bottom).offset(lwb_margin);
        make.bottom.equalTo(self.mas_bottom).offset(-60);
    }];
    
    [_bookingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@((self.lwb_width - lwb_margin * 6) * 0.5));
        make.centerX.equalTo(self.mas_centerX);
        make.height.equalTo(@(40));
        make.bottom.equalTo(self.mas_bottom).offset(-lwb_margin);
    }];
}
- (UIView *)videoView{
    
    if(_videoView == nil){
        
        _videoView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.lwb_width, self.lwb_height - 40)];
        _videoView.backgroundColor = RGBA(50, 50, 50, 0.4);
        [_videoView addSubview:self.playerBtn];
    }
    return _videoView;
}
- (UIButton *)playerBtn{
    
    if(_playerBtn == nil){
        
        _playerBtn = [[UIButton alloc]init];
        [_playerBtn setImage:[UIImage imageNamed:@"Player_Start"] forState:UIControlStateNormal];
        [_playerBtn setImage:[UIImage imageNamed:@"Player_pause"] forState:UIControlStateSelected];
        [_playerBtn addTarget:self action:@selector(omo_videoPlayer:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playerBtn;
}
- (UILabel *)videoNameLab{
    
    if(_videoNameLab == nil){
        
        _videoNameLab = [[UILabel alloc]init];
        _videoNameLab.textColor = textColour;
        _videoNameLab.textAlignment = NSTextAlignmentLeft;
        _videoNameLab.font = defoultFont;
        _videoNameLab.numberOfLines = 0;
        _videoNameLab.text = @"adasjklFKAJLSFBALBKJSFBJSFPWEUFLBJBJKLDSVFLDKjfvsFJA,FAHKSJVVJKWV    LV";
    }
    return _videoNameLab;
}
- (UIButton *)bookingBtn{
    
    if(_bookingBtn == nil){
        
        _bookingBtn = [[UIButton alloc]init];
        [_bookingBtn setImage:[UIImage imageNamed:@"Booking_Remote"] forState:UIControlStateNormal];
        [_bookingBtn setTitle:@"远程评估" forState:UIControlStateNormal];
        [_bookingBtn setTitleColor:WHITECOLORA(1) forState:UIControlStateNormal];
        _bookingBtn.titleLabel.font = bigFont;
        _bookingBtn.layer.cornerRadius = 20.f;
        _bookingBtn.backgroundColor = backColor;
        [_bookingBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:5.f];
        [_bookingBtn addTarget:self action:@selector(omo_remoteBooking) forControlEvents:UIControlEventTouchUpInside];
        _bookingBtn.selected = YES;
    }
    return _bookingBtn;
}
#pragma mark -------- 点击视频播放 -----------
- (void)omo_videoPlayer:(UIButton *)sender{
    
    BOOL select = sender.isSelected;
    
    if(!select){
        
        if(_isStart == 0){
            
            [_player playWithUrl:[NSURL URLWithString:@"http://img00.sun-hc.com/file/resource/20186/1529633366531.mp4"] showView:self.videoView];
        }else{
            
            [_player resume];
        }
    }else{
        
        [_player pause];
    }
    sender.selected = !select;
    
    _isStart += 1;
}
#pragma mark --------- 预约 ------------
- (void)omo_remoteBooking{
    
    OMOResultRemoteVC *resultRemoteVC = [[OMOResultRemoteVC alloc]init];
    [[OMOIphoneManager getCurrentVC].navigationController pushViewController:resultRemoteVC animated:YES];
}
@end
