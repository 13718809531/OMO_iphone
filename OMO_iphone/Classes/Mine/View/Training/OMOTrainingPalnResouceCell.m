//
//  OMOTariningPalnResouceCell.m
//  OMO_iphone
//
//  Created by wy on 2018/10/23.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOTrainingPalnResouceCell.h"

@interface OMOTrainingPalnResouceCell()

/**  */
@property (nonatomic, strong)UIImageView *coverImg;// 背景图,占位图
@property(strong,nonatomic)UILabel *titleLab;// 标题
@property(strong,nonatomic)UILabel *timeLab;// 时长
@property(strong,nonatomic)UIView *progressView;// Jin度
@property(strong,nonatomic)UIButton *startTrainingBtn;// 开始训练

@end

@implementation OMOTrainingPalnResouceCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        self.backgroundColor = mainBackColor;
        [self addSubview:self.coverImg];
        [self addSubview:self.titleLab];
        [self addSubview:self.timeLab];
        [self addSubview:self.progressView];
//        [self addSubview:self.startTrainingBtn];
    }
    return self;
}
- (void)setResouceModel:(OMOTrainResourceModel *)resouceModel{
    
    _resouceModel = resouceModel;
    
    [_coverImg sd_setImageWithURL:[NSURL URLWithString:resouceModel.cover_img] placeholderImage:[UIImage imageNamed:@""]];
    _titleLab.text = resouceModel.resource_name;
    _timeLab.text = [NSString stringWithFormat:@"%.0f秒",resouceModel.duration.doubleValue];
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [_coverImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.mas_top);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom).offset(-2);
    }];
    
    [_titleLab sizeToFit];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(lwb_margin);
        make.top.equalTo(self.mas_top).offset(lwb_margin);
        make.right.equalTo(self.timeLab.mas_left).offset(-lwb_margin);
    }];
    
    [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.mas_right).offset(-lwb_margin);
        make.top.equalTo(self.mas_top).offset(lwb_margin);
        make.width.equalTo(@(60));
        make.height.equalTo(@(20));
    }];
    _timeLab.layer.masksToBounds = YES;
    _timeLab.layer.cornerRadius = 3.f;
    
//    CGFloat column = _resouceModel.train_times.integerValue / _resouceModel.total_train_times.integerValue;
    
//    [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.left.equalTo(self.mas_left).offset(lwb_margin);
//        make.bottom.equalTo(self.mas_bottom);
//        make.width.equalTo(@(self.lwb_width * column));
//        make.height.equalTo(@(2));
//    }];
    
//    [_startTrainingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.right.equalTo(self.numLab.mas_right).offset(-lwb_margin);
//        make.centerY.equalTo(self.stateImgV.mas_centerY);
//        make.left.equalTo(self.timeLab.mas_left).offset(lwb_margin);
//        make.height.equalTo(@(35));
//    }];
//    _startTrainingBtn.layer.masksToBounds = YES;
//    _startTrainingBtn.layer.cornerRadius = 17.5f;
//    _startTrainingBtn.layer.borderColor = backColor.CGColor;
//    _startTrainingBtn.layer.borderWidth = 1.f;
}
- (UIImageView *)coverImg{
    
    if(_coverImg == nil){
        
        _coverImg = [[UIImageView alloc]init];
        _coverImg.clipsToBounds = YES;
        _coverImg.contentMode = UIViewContentModeScaleToFill;
    }
    return _coverImg;
}
- (UILabel *)titleLab{
    
    if(_titleLab == nil){
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.text = @"全身疼痛";
        _titleLab.textColor = textColour;
        _titleLab.font = Font(16);
        _titleLab.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLab;
}
- (UILabel *)timeLab{
    
    if(_timeLab == nil){
        
        _timeLab = [[UILabel alloc]init];
        _timeLab.text = @"15分钟";
        _timeLab.textColor = WHITECOLORA(1);
        _timeLab.backgroundColor = YellowColor;
        _timeLab.font = Font(10);
        _timeLab.textAlignment = NSTextAlignmentCenter;
    }
    return _timeLab;
}

- (UIView *)progressView{
    
    if(_progressView == nil){
        
        _progressView = [[UIView alloc]init];
        _progressView.backgroundColor = GreenColor;
    }
    return _progressView;
}
//
//- (UIButton *)startTrainingBtn{
//
//    if(_startTrainingBtn == nil){
//
//        _startTrainingBtn = [[UIButton alloc]init];
//        _startTrainingBtn.titleLabel.font = Font(16);
//    }
//    return _startTrainingBtn;
//}

@end
