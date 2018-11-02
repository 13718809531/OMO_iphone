//
//  OMOBuyPalnDetailHeadView.m
//  OMO_iphone
//
//  Created by wy on 2018/10/20.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOBuyPalnDetailHeadView.h"

@interface OMOBuyPalnDetailHeadView()

@property (nonatomic,strong)UILabel *planNameLab;
@property (nonatomic,strong)UILabel *reportLab;//
@property (nonatomic,strong)UILabel *timeLab;

@end

@implementation OMOBuyPalnDetailHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){

        self.backgroundColor = WHITECOLORA(1);
        [self addSubview:self.planNameLab];
        [self addSubview:self.reportLab];
        [self addSubview:self.timeLab];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.lwb_height - lwb_smallMargin, self.lwb_width, lwb_smallMargin)];
        lineView.backgroundColor = mainBackColor;
        [self addSubview:lineView];
    }
    return self;
}
- (void)setDict:(NSDictionary *)dict{
    
    _dict = dict;
    
    _planNameLab.text = dict[@"cate"];
    
    _reportLab.text = dict[@"content"];
    
    _timeLab.text = [NSString stringWithFormat:@"评估时间:%@",dict[@"pay_time"]];
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [_timeLab sizeToFit];
    [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.reportLab.mas_bottom).offset(lwb_margin);
        make.left.equalTo(self.mas_left).offset(lwb_margin * 2);
    }];
    
    [_reportLab sizeToFit];
    [_reportLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(lwb_margin * 2);
    }];
    
    [_planNameLab sizeToFit];
    [_planNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.reportLab.mas_top).offset(-lwb_margin);
        make.left.equalTo(self.mas_left).offset(lwb_margin * 2);
        make.right.equalTo(self.mas_right).offset(-lwb_margin * 2);
    }];
}
- (UILabel *)planNameLab
{
    if (!_planNameLab) {
        UILabel * label= [[UILabel alloc] init];
        label.font = navTitleFont;
        label.textColor = TextColor;
        label.textAlignment = NSTextAlignmentLeft;
        _planNameLab = label;
    }return _planNameLab;
}
- (UILabel *)reportLab
{
    if (!_reportLab) {
        UILabel * label= [[UILabel alloc] init];
        label.textColor = DetailColor;
        label.font = bigFont;
        label.textAlignment = NSTextAlignmentLeft;
        _reportLab = label;
    }return _reportLab;
}

- (UILabel *)timeLab
{
    if (!_timeLab) {
        UILabel * label= [[UILabel alloc] init];
        label.font = defoultFont;
        label.textColor = RGB(180, 180, 180);
        label.textAlignment = NSTextAlignmentLeft;
        _timeLab = label;
    }return _timeLab;
}

@end
