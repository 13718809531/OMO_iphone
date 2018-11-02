//
//  OMOAssessmentVideoCell.m
//  OMO_iphone
//
//  Created by wy on 2018/10/16.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOAssessmentVideoCell.h"
/** 播放器 */
#import "TBPlayer.h"

@interface OMOAssessmentVideoCell()

/**  */
@property (nonatomic,assign)NSInteger isStart;
/**  */
@property (nonatomic, strong)TBPlayer *player;
/** 播放view */
@property (nonatomic, strong)UIView *videoView;
/** 控制播放 */
@property (nonatomic, strong)UIButton *playerBtn;
/**  */
@property (nonatomic, strong)UILabel *videoNameLab;
/**  */
@property (nonatomic, strong)UILabel *videoTimeLab;

@end

@implementation OMOAssessmentVideoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _isStart = 0;
        _player = [TBPlayer sharedInstance];
        
        [self addSubview:self.videoView];
        [self addSubview:self.videoNameLab];
        [self addSubview:self.videoTimeLab];
    }
    return self;
}
- (void)setVideoModel:(OMOKangFuBaoVideoModel *)videoModel{
    
    _videoModel = videoModel;
    
    _videoNameLab.text = videoModel.question_name;
    
    _videoTimeLab.text = videoModel.options_name;
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [_videoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom).offset(-40);
        make.top.equalTo(self.mas_top);
    }];
    
    [_playerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.videoView.mas_centerX);
        make.centerY.equalTo(self.videoView.mas_centerY);
        make.height.mas_equalTo(self.videoView.lwb_height - lwb_margin * 4);
        make.width.mas_equalTo(self.videoView.lwb_height - lwb_margin * 4);
    }];
    
    [_videoNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.videoTimeLab.mas_left).offset(-lwb_margin);
        make.height.equalTo(@(40));
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    [_videoTimeLab sizeToFit];
    [_videoTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.centerY.equalTo(self.videoNameLab.mas_centerY);
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
        _videoNameLab.font = Font(18);
    }
    return _videoNameLab;
}
- (UILabel *)videoTimeLab{
    
    if(_videoTimeLab == nil){
        
        _videoTimeLab = [[UILabel alloc]init];
        _videoTimeLab.textColor = DetailColor;
        _videoTimeLab.textAlignment = NSTextAlignmentRight;
        _videoTimeLab.font = bigFont;
    }
    return _videoTimeLab;
}
- (void)omo_videoPlayer:(UIButton *)sender{
    
    BOOL select = sender.isSelected;
    
    if(!select){
        
        if(_isStart == 0){
                
            [_player playWithUrl:[NSURL URLWithString:_videoModel.url] showView:self.videoView];
        }else{
            
            [_player resume];
        }
    }else{
        
        [_player pause];
    }
    sender.selected = !select;
    
    _isStart += 1;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
