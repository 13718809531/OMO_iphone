//
//  OMORemoteTimeCell.m
//  OMO_iphone
//
//  Created by wy on 2018/10/24.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMORemoteTimeCell.h"

@interface OMORemoteTimeCell()

@property(strong,nonatomic)UILabel *startTimeLab;
/**  */
@property (nonatomic, strong)UILabel *endTimeLab;
@property(strong,nonatomic)UILabel *stateLab;
@property(strong,nonatomic)UILabel *statusLab;

@end

@implementation OMORemoteTimeCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        self.backgroundColor = self.backgroundColor = mainBackColor;
        [self addSubview:self.startTimeLab];
        [self addSubview:self.endTimeLab];
        [self addSubview:self.stateLab];
        [self addSubview:self.statusLab];
    }
    return self;
}
- (void)setTimeModel:(OMORemoteTimeModel *)timeModel{
    
    _timeModel = timeModel;
    
    _startTimeLab.text = [timeModel.time substringToIndex:6];
    _endTimeLab.text = [timeModel.time substringFromIndex:6];
    
    if(timeModel.isSelect){
        
        self.backgroundColor = backColor;
    }else{
        
        self.backgroundColor = mainBackColor;
    }
    if(timeModel.status){
        
        _statusLab.hidden = NO;
        _stateLab.hidden = YES;
        _startTimeLab.textColor = TextColor;
        _endTimeLab.textColor = TextColor;
    }else{
        
        _statusLab.hidden = YES;
        _stateLab.hidden = NO;
        _startTimeLab.textColor = DetailColor;
        _endTimeLab.textColor = DetailColor;
    }
    
    [self md_setSubViewsFrame];
}
- (UILabel *)startTimeLab{
    
    if(_startTimeLab == nil){
        
        _startTimeLab = [[UILabel alloc]init];
        _startTimeLab.textColor = [UIColor whiteColor];
        _startTimeLab.textAlignment = NSTextAlignmentLeft;
    }
    return _startTimeLab;
}
- (UILabel *)endTimeLab{
    
    if(_endTimeLab == nil){
        
        _endTimeLab = [[UILabel alloc]init];
        _endTimeLab.textColor = [UIColor whiteColor];
        _endTimeLab.textAlignment = NSTextAlignmentLeft;
    }
    return _endTimeLab;
}
- (UILabel *)stateLab{
    
    if(_stateLab == nil){
        
        _stateLab = [[UILabel alloc]init];
        _stateLab.font = smallFont;
        _stateLab.textColor = DetailColor;
        _stateLab.textAlignment = NSTextAlignmentCenter;
        _stateLab.text = @"满";
        _stateLab.hidden = YES;
    }
    return _stateLab;
}
- (UILabel *)statusLab{
    
    if(_statusLab == nil){
        
        _statusLab = [[UILabel alloc]initWithFrame:CGRectMake(self.lwb_width - 30, 2.5, 30, IFFitFloat6(16))];
        UIBezierPath * maskPath = [UIBezierPath bezierPathWithRoundedRect:_statusLab.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerTopLeft cornerRadii:CGSizeMake(12.5f, 12.5f)];
        _statusLab.hidden = YES;
        CAShapeLayer * maskLayer = [CAShapeLayer new];
        maskLayer.frame = _statusLab.bounds;
        maskLayer.path = maskPath.CGPath;
        _statusLab.layer.mask = maskLayer;
        _statusLab.textColor = WHITECOLORA(1);
        _statusLab.textAlignment = NSTextAlignmentRight;
        _statusLab.text = @"可约";
        _statusLab.font = FontMas(12);
        _statusLab.backgroundColor = backColor;
    }
    return _statusLab;
}
- (void)md_setSubViewsFrame{
    
    [_startTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(lwb_smallMargin * 0.5);
        make.right.mas_equalTo(self.mas_right).offset(-lwb_smallMargin * 0.5);
        make.centerY.equalTo(self.mas_centerY);
        make.height.equalTo(@(self.lwb_height / 3));
    }];
    
    [_endTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(lwb_smallMargin * 0.5);
        make.right.mas_equalTo(self.mas_right).offset(-lwb_smallMargin * 0.5);
        make.bottom.equalTo(self.mas_bottom);
        make.height.equalTo(@(self.lwb_height / 3));
    }];
    
    [_stateLab sizeToFit];
    [_stateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(lwb_smallMargin * 0.5);
        make.right.equalTo(self.mas_right).offset(-lwb_smallMargin);
    }];
}

@end
