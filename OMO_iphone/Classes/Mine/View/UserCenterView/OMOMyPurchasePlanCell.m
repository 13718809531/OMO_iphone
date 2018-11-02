//
//  OMOMyPurchasePlanCell.m
//  OMO_iphone
//
//  Created by 郭越 on 2018/10/19.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOMyPurchasePlanCell.h"
@interface OMOMyPurchasePlanCell()

@property(strong,nonatomic)UIView *backView;//背景页
@property(strong,nonatomic)UIButton *planDetialButton;// 方案明细按钮
@property(strong,nonatomic)UIButton *auxiliaryButton;//辅具按钮
@property(strong,nonatomic)UILabel *titleLab;// 标题
@property(strong,nonatomic)UILabel *editDetailLab;// 详情
@property(strong,nonatomic)UILabel *timeLab;//时间

@end
@implementation OMOMyPurchasePlanCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.backgroundColor = WHITECOLORA(1);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.backView];
        [self addSubview:self.titleLab];
        [self addSubview:self.editDetailLab];
        [self addSubview:self.timeLab];
        [self addSubview:self.planDetialButton];
        [self addSubview:self.auxiliaryButton];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.mas_right).offset(-10);
        make.top.equalTo(self.mas_top).offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
        make.left.equalTo(self.mas_left).offset(10);
        
    }];
    [_titleLab sizeToFit];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(20);
        make.top.equalTo(self.mas_top).offset(20);
    }];
    
    [_editDetailLab sizeToFit];
    [_editDetailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.titleLab.mas_bottom).offset(lwb_margin);
        make.left.equalTo(self.mas_left).offset(20);
        
    }];
    
    [_timeLab sizeToFit];
    [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.editDetailLab.mas_bottom).offset(lwb_margin);
        make.left.equalTo(self.mas_left).offset(20);
        
    }];
    
    [_planDetialButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(20);
        make.top.equalTo(self.timeLab.mas_bottom).offset(lwb_margin);
        make.width.mas_equalTo(100.f);
        make.height.mas_equalTo(30.f);
        
    }];
    [_auxiliaryButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.planDetialButton.mas_right).offset(20);
        make.top.equalTo(self.timeLab.mas_bottom).offset(lwb_margin);
        make.width.mas_equalTo(100.f);
        make.height.mas_equalTo(30.f);
        
    }];
    
    
}
- (UIView *)backView{
    if (_backView == nil) {
        _backView = [[UIView alloc]init];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.masksToBounds = YES;
        _backView.layer.cornerRadius = lwb_margin;
    }
    return _backView;
}
- (UIButton *)planDetialButton{
    
    if(_planDetialButton == nil){
        _planDetialButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_planDetialButton setBackgroundColor:OrangeColor];
        [_planDetialButton.layer setMasksToBounds:YES];
        [_planDetialButton.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
        [_planDetialButton.layer setBorderWidth:0.0]; //边框宽度
        _planDetialButton.titleLabel.font = defoultFont;
        [_planDetialButton setTitle:@"方案明细" forState:UIControlStateNormal];
        [_planDetialButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _planDetialButton;
}
- (UIButton *)auxiliaryButton{
    
    if(_auxiliaryButton == nil){
        _auxiliaryButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _auxiliaryButton.backgroundColor = OrangeColor;
        [_auxiliaryButton.layer setMasksToBounds:YES];
        [_auxiliaryButton.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
        [_auxiliaryButton.layer setBorderWidth:0.0]; //边框宽度
        _auxiliaryButton.titleLabel.font = defoultFont;
        [_auxiliaryButton setTitle:@"辅具明细" forState:UIControlStateNormal];
        [_auxiliaryButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _auxiliaryButton;
}
- (UILabel *)titleLab{
    
    if(_titleLab == nil){
        _titleLab = [[UILabel alloc]init];
        _titleLab.text = @"腰部 左侧疼痛康复";
        _titleLab.textColor = textColour;
        _titleLab.font = BoldFont(16);
        _titleLab.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLab;
}
- (UILabel *)timeLab{
    
    if(_timeLab == nil){
        _timeLab = [[UILabel alloc]init];
        _timeLab.text = @"报告时间：2018-10-19 12:00";
        _timeLab.textColor = DetailColor;
        _timeLab.font = defoultFont;
        _timeLab.textAlignment = NSTextAlignmentLeft;
    }
    return _timeLab;
}
- (UILabel *)editDetailLab{
    
    if(_editDetailLab == nil){
        
        _editDetailLab = [[UILabel alloc]init];
        _editDetailLab.textColor = DetailColor;
        _editDetailLab.font = defoultFont;
        _editDetailLab.textAlignment = NSTextAlignmentCenter;
        _editDetailLab.text = @"专业评估制定报告";
    }
    return _editDetailLab;
}
@end
