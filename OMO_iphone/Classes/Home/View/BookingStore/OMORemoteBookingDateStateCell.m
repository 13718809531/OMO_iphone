//
//  OMORemoteBookingDateStateCell.m
//  OMO_iphone
//
//  Created by wy on 2018/10/9.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMORemoteBookingDateStateCell.h"

@interface OMORemoteBookingDateStateCell()

@property(strong,nonatomic)UILabel *timeLab;
@property(strong,nonatomic)UILabel *stateLab;
@property(strong,nonatomic)UILabel *statusLab;

@end

@implementation OMORemoteBookingDateStateCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.timeLab];
        [self addSubview:self.stateLab];
        [self addSubview:self.statusLab];
    }
    return self;
}
- (void)setTimeModel:(OMOStoreTimeModel *)timeModel{
    
    _timeModel = timeModel;
    
    _timeLab.text = timeModel.time;
    
    if(timeModel.isSelect){
        
        self.backgroundColor = backColor;
    }else{
        
//        if(timeModel.status){
//
//            self.backgroundColor = WHITECOLORA(1);
//        }else{
//
//            self.backgroundColor = mainBackColor;
//        }
        self.backgroundColor = mainBackColor;
    }
    if(timeModel.status){
        
        _statusLab.hidden = NO;
        _stateLab.hidden = YES;
        _timeLab.textColor = TextColor;
    }else{
        
        _statusLab.hidden = YES;
        _stateLab.hidden = NO;
        _timeLab.textColor = DetailColor;
    }
    
    [self md_setSubViewsFrame];
}
- (UILabel *)timeLab{
    
    if(_timeLab == nil){
        
        _timeLab = [[UILabel alloc]init];
        _timeLab.font = defoultFont;
        _timeLab.textColor = [UIColor whiteColor];
        _timeLab.textAlignment = NSTextAlignmentRight;
    }
    return _timeLab;
}
- (UILabel *)stateLab{
    
    if(_stateLab == nil){
        
        _stateLab = [[UILabel alloc]init];
        _stateLab.font = defoultFont;
        _stateLab.textColor = DetailColor;
        _stateLab.textAlignment = NSTextAlignmentCenter;
        _stateLab.text = @"满";
        _stateLab.hidden = YES;
    }
    return _stateLab;
}
- (UILabel *)statusLab{
    
    if(_statusLab == nil){
        
        _statusLab = [[UILabel alloc]initWithFrame:CGRectMake(self.lwb_width * 0.5, 5, self.lwb_width * 0.5, 20)];
        UIBezierPath * maskPath = [UIBezierPath bezierPathWithRoundedRect:_statusLab.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerTopLeft cornerRadii:CGSizeMake(12.5f, 12.5f)];
        _statusLab.hidden = YES;
        CAShapeLayer * maskLayer = [CAShapeLayer new];
        maskLayer.frame = _statusLab.bounds;
        maskLayer.path = maskPath.CGPath;
        _statusLab.layer.mask = maskLayer;
        _statusLab.font = defoultFont;
        _statusLab.textColor = WHITECOLORA(1);
        _statusLab.textAlignment = NSTextAlignmentCenter;
        _statusLab.text = @"可约";
        _statusLab.backgroundColor = backColor;
    }
    return _statusLab;
}
- (void)md_setSubViewsFrame{
    
    [_timeLab size];
    [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(lwb_smallMargin * 0.5);
        make.right.mas_equalTo(self.mas_right).offset(-lwb_smallMargin * 0.5);
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [_stateLab sizeToFit];
    [_stateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(lwb_smallMargin * 0.5);
        make.right.equalTo(self.mas_right).offset(-lwb_smallMargin);
    }];
}

@end
