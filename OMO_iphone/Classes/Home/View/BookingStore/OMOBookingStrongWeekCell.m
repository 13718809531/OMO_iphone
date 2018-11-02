//
//  OMOBookingStrongWeekCell.m
//  OMO_iphone
//
//  Created by wy on 2018/10/9.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOBookingStrongWeekCell.h"

@interface OMOBookingStrongWeekCell()

@property(strong,nonatomic)UILabel *timeLab;
@property(strong,nonatomic)UILabel *weekLab;

@end

@implementation OMOBookingStrongWeekCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        [self addSubview:self.timeLab];
        [self addSubview:self.weekLab];
    }
    return self;
}
- (void)setWeekModel:(OMOStoreWeekModel *)weekModel{
    
    _weekModel = weekModel;
    
    _timeLab.text = [weekModel.time substringFromIndex:5];
    _weekLab.text = weekModel.week;
    
    if(weekModel.isSelect){
        
        self.backgroundColor = backColor;
        _timeLab.textColor = WHITECOLORA(1);
    }else{
        
        self.backgroundColor = RGBA(20, 20, 20, 0.6);
        _timeLab.textColor = DetailColor;
    }
    
    [self md_setSubViewsFrame];
}
- (UILabel *)timeLab{
    
    if(_timeLab == nil){
        
        _timeLab = [[UILabel alloc]init];
        _timeLab.font = bigFont;
        _timeLab.textColor = [UIColor whiteColor];
        _timeLab.textAlignment = NSTextAlignmentCenter;
    }
    return _timeLab;
}
- (UILabel *)weekLab{
    
    if(_weekLab == nil){
        
        _weekLab = [[UILabel alloc]init];
        _weekLab.font = defoultFont;
        _weekLab.textColor = [UIColor whiteColor];
        _weekLab.textAlignment = NSTextAlignmentCenter;
    }
    return _weekLab;
}
- (void)md_setSubViewsFrame{
    
    [_weekLab sizeToFit];
    [_weekLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_centerY);
    }];
    
    [_timeLab sizeToFit];
    [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_centerY);
    }];
}

@end
