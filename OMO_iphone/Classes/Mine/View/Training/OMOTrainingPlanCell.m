//
//  OMOTrainingPlanCell.m
//  OMO_iphone
//
//  Created by wy on 2018/10/19.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOTrainingPlanCell.h"

@interface OMOTrainingPlanCell()

@property(strong,nonatomic)UILabel *titleLab;// 标题
@property(strong,nonatomic)UILabel *detaiLab;// 详情
@property(strong,nonatomic)UILabel *timeLab;// 时长
@property(strong,nonatomic)UILabel *numLab;// 次数
@property(strong,nonatomic)UIView *progressBackView;
@property(strong,nonatomic)UIView *progressView;
@property(strong,nonatomic)UILabel *progressLab;// 进度
@property(strong,nonatomic)UIImageView *stateImgV;// 第N天
@property(strong,nonatomic)UILabel *oilingLab;// 加油
@property(strong,nonatomic)UILabel *startTrainingLab;// 开始训练

@end

@implementation OMOTrainingPlanCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        self.layer.cornerRadius = lwb_smallMargin;
        self.backgroundColor = WHITECOLORA(1);
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = lwb_margin;
        [self addSubview:self.titleLab];
        [self addSubview:self.detaiLab];
        [self addSubview:self.timeLab];
        [self addSubview:self.numLab];
        [self addSubview:self.progressBackView];
        [self addSubview:self.progressView];
        [self addSubview:self.progressLab];
        [self addSubview:self.stateImgV];
        [self addSubview:self.oilingLab];
        [self addSubview:self.startTrainingLab];
    }
    return self;
}
- (void)setTrainModel:(OMOTrainingPlanModel *)trainModel{
    
    _trainModel= trainModel;
    
    _titleLab.text = [NSString stringWithFormat:@"%@ %@",trainModel.cate_name,trainModel.type_name];
    NSString *text = trainModel.title;
    _detaiLab.attributedText = [text setLabelSpaceOfLineSpacing:4.f Kern:1.f Font:defoultFont];
    _timeLab.text = [NSString stringWithFormat:@"%@分钟",trainModel.train_times];
    _numLab.text = [NSString stringWithFormat:@"%@天",trainModel.train_days];
    _progressLab.text = [NSString stringWithFormat:@"完成%.0f%%",trainModel.progress.doubleValue * 100];
    _oilingLab.text = trainModel.progress_desc;
    
    if(trainModel.progress.doubleValue == 1.0){
        
        _startTrainingLab.text = @"完成训练";
        _startTrainingLab.textColor = backColor;
        _startTrainingLab.backgroundColor = WHITECOLORA(1);
        _stateImgV.image = [UIImage imageNamed:@"Tran_end"];
    }else{
        
        _startTrainingLab.text = @"开始训练";
        _startTrainingLab.textColor = WHITECOLORA(1);
        _startTrainingLab.backgroundColor = backColor;
        _stateImgV.image = [UIImage imageNamed:@"Tran_progress"];
    }
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [_titleLab sizeToFit];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(lwb_margin);
        make.top.equalTo(self.mas_top).offset(lwb_margin);
        make.width.equalTo(@(self.lwb_width * 2 / 3));
    }];
    
    [_detaiLab sizeToFit];
    [_detaiLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(lwb_margin);
        make.top.equalTo(self.titleLab.mas_bottom).offset(lwb_smallMargin * 0.5);
        make.right.equalTo(self.timeLab.mas_left).offset(-lwb_margin);
    }];
    
    [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.numLab.mas_left).offset(-lwb_margin);
        make.centerY.equalTo(self.titleLab.mas_centerY);
        make.width.equalTo(@(60));
        make.height.equalTo(@(20));
    }];
    _timeLab.layer.masksToBounds = YES;
    _timeLab.layer.cornerRadius = 10.f;
    
    [_numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.mas_right).offset(-lwb_margin);
        make.centerY.equalTo(self.titleLab.mas_centerY);
        make.width.equalTo(@(60));
        make.height.equalTo(@(20));
    }];
    _numLab.layer.masksToBounds = YES;
    _numLab.layer.cornerRadius = 10.f;
    
    CGFloat width = self.lwb_width - 60 * 2 - lwb_margin * 3;
    [_progressBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.timeLab.mas_left).offset(lwb_margin * 2);
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(lwb_margin);
        make.height.equalTo(@(lwb_smallMargin));
    }];
    _progressBackView.layer.masksToBounds = YES;
    _progressBackView.layer.cornerRadius = lwb_smallMargin * 0.5;
    
    [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(lwb_margin);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo(@(width * self.trainModel.progress.doubleValue));
        make.height.equalTo(@(lwb_smallMargin));
    }];
    _progressView.layer.masksToBounds = YES;
    _progressView.layer.cornerRadius = lwb_smallMargin * 0.5;
    
    [_progressLab sizeToFit];
    [_progressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.mas_right).offset(-lwb_margin * 2);
        make.centerY.equalTo(self.progressBackView.mas_centerY);
    }];
    
    CGFloat width1 = 30;
    [_stateImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(lwb_margin);
        make.width.equalTo(@(width1));
        make.bottom.equalTo(self.mas_bottom).offset(-lwb_margin);
        make.height.equalTo(@(width1));
    }];
//    _numDayLab.layer.cornerRadius = width1 * 0.5;
    
    [_oilingLab sizeToFit];
    [_oilingLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.stateImgV.mas_right).offset(lwb_margin);
        make.centerY.equalTo(self.stateImgV.mas_centerY);
    }];
    
    [_startTrainingLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.numLab.mas_right).offset(-lwb_margin);
        make.centerY.equalTo(self.stateImgV.mas_centerY);
        make.left.equalTo(self.timeLab.mas_left).offset(lwb_margin);
        make.height.equalTo(@(35));
    }];
    _startTrainingLab.layer.masksToBounds = YES;
    _startTrainingLab.layer.cornerRadius = 17.5f;
    _startTrainingLab.layer.borderColor = backColor.CGColor;
    _startTrainingLab.layer.borderWidth = 1.f;
}
- (UILabel *)titleLab{
    
    if(_titleLab == nil){
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.textColor = textColour;
        _titleLab.font = Font(16);
        _titleLab.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLab;
}
- (UILabel *)detaiLab{
    
    if(_detaiLab == nil){
        
        _detaiLab = [[UILabel alloc]init];
        _detaiLab.font = defoultFont;
        _detaiLab.textColor = DetailColor;
        _detaiLab.textAlignment = NSTextAlignmentLeft;
    }
    return _detaiLab;
}
- (UILabel *)timeLab{
    
    if(_timeLab == nil){
        
        _timeLab = [[UILabel alloc]init];
        _timeLab.textColor = WHITECOLORA(1);
        _timeLab.backgroundColor = YellowColor;
        _timeLab.font = Font(10);
        _timeLab.textAlignment = NSTextAlignmentCenter;
    }
    return _timeLab;
}
- (UILabel *)numLab{
    
    if(_numLab == nil){
        
        _numLab = [[UILabel alloc]init];
        _numLab.font = Font(10);
        _numLab.textColor = WHITECOLORA(1);
        _numLab.backgroundColor = GreenColor;
        _numLab.textAlignment = NSTextAlignmentCenter;
    }
    return _numLab;
}
- (UIView *)progressBackView{
    
    if(_progressBackView == nil){
        
        _progressBackView = [[UIView alloc]init];
        _progressBackView.backgroundColor = mainBackColor;
    }
    return _progressBackView;
}
- (UIView *)progressView{
    
    if(_progressView == nil){
        
        _progressView = [[UIView alloc]init];
        _progressView.backgroundColor = GreenColor;
    }
    return _progressView;
}
- (UILabel *)progressLab{
    
    if(_progressLab == nil){
        
        _progressLab = [[UILabel alloc]init];
        _progressLab.textColor = DetailColor;
        _progressLab.textAlignment = NSTextAlignmentCenter;
        _progressLab.font = defoultFont;
    }
    return _progressLab;
}
- (UIImageView *)stateImgV{
    
    if(_stateImgV == nil){
        
        _stateImgV = [[UIImageView alloc]init];
    }
    return _stateImgV;
}
- (UILabel *)oilingLab{
    
    if(_oilingLab == nil){
        
        _oilingLab = [[UILabel alloc]init];
        _oilingLab.textColor = textColour;
        _oilingLab.textAlignment = NSTextAlignmentCenter;
        _oilingLab.font = defoultFont;
    }
    return _oilingLab;
}
- (UILabel *)startTrainingLab{
    
    if(_startTrainingLab == nil){
        
        _startTrainingLab = [[UILabel alloc]init];
        _startTrainingLab.font = Font(16);
        _startTrainingLab.textAlignment = NSTextAlignmentCenter;
    }
    return _startTrainingLab;
}

@end
