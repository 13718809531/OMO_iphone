//
//  OMOTrainingPlanCell.m
//  OMO_iphone
//
//  Created by wy on 2018/10/19.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOBuyPlanCell.h"
/**  */
#import "OMOBuyPlanDetailVC.h"
/**  */
#import "OMOBuyDeviceDetailVC.h"
/**  */
#import "OMOBuyDevicesVC.h"
/**  */
#import "OMODeviceListVC.h"

@interface OMOBuyPlanCell()

@property (nonatomic,strong)UILabel *planNameLab;
@property (nonatomic,strong)UILabel *reportLab;//
@property (nonatomic,strong)UILabel *timeLab;
@property(strong,nonatomic)UIButton *checkPlanBtn;//
@property(strong,nonatomic)UIButton *checkDeviceBtn;// 

@end

@implementation OMOBuyPlanCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = lwb_margin;
        self.backgroundColor = WHITECOLORA(1);
        [self addSubview:self.planNameLab];
        [self addSubview:self.reportLab];
        [self addSubview:self.timeLab];
        [self addSubview:self.checkPlanBtn];
        [self addSubview:self.checkDeviceBtn];
    }
    return self;
}
- (void)setBuyPlanModel:(OMOBuyPlanModel *)buyPlanModel{
    
    _buyPlanModel = buyPlanModel;
    
    _planNameLab.text = buyPlanModel.title;
    
    _reportLab.text = buyPlanModel.content;
    
    _timeLab.text = [NSString stringWithFormat:@"报告时间:%@",buyPlanModel.created];
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [_checkPlanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.mas_bottom).offset(-lwb_margin);
        make.left.equalTo(self.mas_left).offset(lwb_margin * 2);
        make.size.mas_equalTo(CGSizeMake(120, 30));
    }];
    _checkPlanBtn.layer.masksToBounds = YES;
    _checkPlanBtn.layer.cornerRadius = 15.f;
    
    [_checkDeviceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.mas_bottom).offset(-lwb_margin);
        make.left.equalTo(self.checkPlanBtn.mas_right).offset(lwb_margin * 4);
        make.size.mas_equalTo(CGSizeMake(120, 30));
    }];
    _checkDeviceBtn.layer.masksToBounds = YES;
    _checkDeviceBtn.layer.cornerRadius = 15.f;
    
    [_timeLab sizeToFit];
    [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(lwb_margin * 2);
    }];
    
    [_reportLab sizeToFit];
    [_reportLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.mas_centerY).offset(-lwb_smallMargin);
        make.left.equalTo(self.mas_left).offset(lwb_margin * 2);
    }];
    
    [_planNameLab sizeToFit];
    [_planNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mas_top).offset(lwb_margin);
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
- (UIButton *)checkPlanBtn{
    if(!_checkPlanBtn){
        
        _checkPlanBtn = [[UIButton alloc]init];
        _checkPlanBtn.backgroundColor = backColor;
        _checkPlanBtn.tag = 100;
        [_checkPlanBtn setTitle:@"方案明细" forState:UIControlStateNormal];
        _checkPlanBtn.titleLabel.font = navTitleFont;
        [_checkPlanBtn setTitleColor:WHITECOLORA(1) forState:UIControlStateNormal];
        [_checkPlanBtn addTarget:self action:@selector(md_xunLianButtonDidClickWithButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _checkPlanBtn;
}
- (UIButton *)checkDeviceBtn{
    if(!_checkDeviceBtn){
        
        _checkDeviceBtn = [[UIButton alloc]init];
        _checkDeviceBtn.backgroundColor = backColor;
        _checkDeviceBtn.tag = 200;
        [_checkDeviceBtn setTitle:@"辅具明细" forState:UIControlStateNormal];
        _checkDeviceBtn.titleLabel.font = navTitleFont;
        [_checkDeviceBtn setTitleColor:WHITECOLORA(1) forState:UIControlStateNormal];
        [_checkDeviceBtn addTarget:self action:@selector(md_xunLianButtonDidClickWithButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _checkDeviceBtn;
}
- (void)md_xunLianButtonDidClickWithButton:(UIButton *)sender{
    
    if(sender.tag == 100){
        
        OMOBuyPlanDetailVC *buyPlanDetailVC = [[OMOBuyPlanDetailVC alloc]init];
        buyPlanDetailVC.pe_order_id = _buyPlanModel.pe_order_id;
        [[OMOIphoneManager getCurrentVC].navigationController pushViewController:buyPlanDetailVC animated:YES];
    }else{
        
        if([_buyPlanModel.is_buy isEqualToString:@"1"]){
            
            OMOBuyDeviceDetailVC *buyDeviceDetailVC = [[OMOBuyDeviceDetailVC alloc]init];
            buyDeviceDetailVC.pe_order_id = _buyPlanModel.pe_order_id;
            [[OMOIphoneManager getCurrentVC].navigationController pushViewController:buyDeviceDetailVC animated:YES];
        }else{
            
            OMOBuyDevicesVC *buyDevicesVC = [[OMOBuyDevicesVC alloc]init];
            buyDevicesVC.pe_order_id = _buyPlanModel.pe_order_id;
            buyDevicesVC.numType = 2;
            buyDevicesVC.buyType = 2;
            [[OMOIphoneManager getCurrentVC].navigationController pushViewController:buyDevicesVC animated:YES];
        }
    }
}
@end
