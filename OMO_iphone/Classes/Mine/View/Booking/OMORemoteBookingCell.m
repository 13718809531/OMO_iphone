//
//  OMORemoteBookingCell.m
//  OMO_iphone
//
//  Created by wy on 2018/10/25.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMORemoteBookingCell.h"
/**  */
#import "OMOCancelBookingAlertView.h"
/**  */
#import "OMORemoteResultVC.h"

@interface OMORemoteBookingCell()

/**  */
@property (nonatomic, strong)UILabel *titleLab;
/**  */
@property (nonatomic, strong)UILabel *nickLab;
/**  */
@property (nonatomic, strong)UILabel *dateLab;
/**  */
@property (nonatomic, strong)UILabel *descLab;
/**  */
@property (nonatomic, strong)UILabel *creatLab;
/**  */
@property (nonatomic, strong)UILabel *promptLab;
/**  */
@property (nonatomic, strong)UIButton *stateBtn;
/**  */
@property (nonatomic, strong)UIButton *remoteBtn;

@end

@implementation OMORemoteBookingCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        self.layer.cornerRadius = lwb_smallMargin;
        self.backgroundColor = WHITECOLORA(1);
        [self addSubview:self.titleLab];
        [self addSubview:self.nickLab];
        [self addSubview:self.dateLab];
        [self addSubview:self.descLab];
        [self addSubview:self.creatLab];
        [self addSubview:self.promptLab];
        [self addSubview:self.stateBtn];
        [self addSubview:self.remoteBtn];
    }
    return self;
}
- (void)setModel:(OMORemoteBookingModel *)model{
    
    _model = model;
    
    _titleLab.text = model.title;
    _nickLab.text = [NSString stringWithFormat:@"预约姓名:%@",model.realname];
    _dateLab.text = [NSString stringWithFormat:@"预约时间:%@",model.time];
    _descLab.text = [NSString stringWithFormat:@"病情描述:%@",model.consult_question];
    _creatLab.text = [NSString stringWithFormat:@"提交时间:%@",model.created];
    
    if([model.state isEqualToString:@"1"]){
        
        _promptLab.hidden = YES;
        [_stateBtn setTitle:@"取消预约" forState:UIControlStateNormal];
        _stateBtn.backgroundColor = backColor;
        _remoteBtn.hidden = NO;
    }else if ([model.state isEqualToString:@"2"]){
        
        _promptLab.hidden = YES;
        [_stateBtn setTitle:@"查看报告" forState:UIControlStateNormal];
        _stateBtn.backgroundColor = backColor;
        _remoteBtn.hidden = YES;
    }else if ([model.state isEqualToString:@"3"]){
        
        _promptLab.hidden = NO;
        [_stateBtn setTitle:@"已取消" forState:UIControlStateNormal];
        _stateBtn.backgroundColor = DetailColor;
        _remoteBtn.hidden = YES;
    }else if ([model.state isEqualToString:@"4"]){
        
        _promptLab.hidden = YES;
        [_stateBtn setTitle:@"已拒绝" forState:UIControlStateNormal];
        _stateBtn.backgroundColor = DetailColor;
        _remoteBtn.hidden = YES;
    }
    [self setSubViwsFrame];
}

- (void)setSubViwsFrame{
    
    [_titleLab sizeToFit];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(lwb_margin * 2);
        make.top.equalTo(self.mas_top).offset(lwb_margin * 2);
        make.right.equalTo(self.mas_right).offset(-lwb_margin * 2);
    }];
    
    [_nickLab sizeToFit];
    [_nickLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(lwb_margin * 2);
        make.top.equalTo(self.titleLab.mas_bottom).offset(lwb_margin * 2);
        make.right.equalTo(self.mas_right).offset(-lwb_margin * 2);
    }];
    
    [_dateLab sizeToFit];
    [_dateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(lwb_margin * 2);
        make.top.equalTo(self.nickLab.mas_bottom).offset(lwb_margin);
        make.right.equalTo(self.mas_right).offset(-lwb_margin * 2);
    }];
    
    [_descLab sizeToFit];
    [_descLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(lwb_margin * 2);
        make.top.equalTo(self.dateLab.mas_bottom).offset(lwb_margin);
        make.right.equalTo(self.mas_right).offset(-lwb_margin * 2);
    }];
    
    [_creatLab sizeToFit];
    [_creatLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(lwb_margin * 2);
        make.top.equalTo(self.descLab.mas_bottom).offset(lwb_margin);
        make.right.equalTo(self.mas_right).offset(-lwb_margin * 2);
    }];
    
    [_promptLab sizeToFit];
    [_promptLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(lwb_margin * 2);
        make.bottom.equalTo(self.stateBtn.mas_top).offset(-lwb_smallMargin);
        make.right.equalTo(self.mas_right).offset(-lwb_margin * 2);
    }];

    [_stateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(lwb_margin * 2);
        make.bottom.equalTo(self.mas_bottom).offset(-lwb_margin);
        make.width.equalTo(@(120));
        make.height.equalTo(@(30));
    }];
    _stateBtn.layer.cornerRadius = 15.f;
    
    [_remoteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.stateBtn.mas_right).offset(lwb_margin * 2);
        make.bottom.equalTo(self.mas_bottom).offset(-lwb_margin);
        make.width.equalTo(@(120));
        make.height.equalTo(@(30));
    }];
    _remoteBtn.layer.cornerRadius = 15.f;
}

- (UILabel *)titleLab{
    
    if(_titleLab == nil){
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.textColor = textColour;
        _titleLab.font = BoldFont(22);
        _titleLab.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLab;
}
- (UILabel *)nickLab{
    
    if(_nickLab == nil){
        
        _nickLab = [[UILabel alloc]init];
        _nickLab.textColor = DetailColor;
        _nickLab.font = bigFont;
        _nickLab.textAlignment = NSTextAlignmentLeft;
    }
    return _nickLab;
}
- (UILabel *)dateLab{
    
    if(_dateLab == nil){
        
        _dateLab = [[UILabel alloc]init];
        _dateLab.textColor = DetailColor;
        _dateLab.font = bigFont;
        _dateLab.textAlignment = NSTextAlignmentLeft;
    }
    return _dateLab;
}
- (UILabel *)descLab{
    
    if(_descLab == nil){
        
        _descLab = [[UILabel alloc]init];
        _descLab.textColor = DetailColor;
        _descLab.font = bigFont;
        _descLab.textAlignment = NSTextAlignmentLeft;
    }
    return _descLab;
}
- (UILabel *)creatLab{
    
    if(_creatLab == nil){
        
        _creatLab = [[UILabel alloc]init];
        _creatLab.textColor = DetailColor;
        _creatLab.font = bigFont;
        _creatLab.textAlignment = NSTextAlignmentLeft;
    }
    return _creatLab;
}
- (UILabel *)promptLab{
    
    if(_promptLab == nil){
        
        _promptLab = [[UILabel alloc]init];
        _promptLab.textColor = RGB(155, 155, 155);
        _promptLab.font = smallFont;
        _promptLab.text = @"退款金额将在1-3个工作日退回原账户";
        _promptLab.textAlignment = NSTextAlignmentLeft;
    }
    return _promptLab;
}
- (UIButton *)stateBtn{
    if(!_stateBtn){
        
        _stateBtn = [[UIButton alloc]init];
        _stateBtn.tag = 100;
        _stateBtn.titleLabel.font = navTitleFont;
        [_stateBtn setTitleColor:WHITECOLORA(1) forState:UIControlStateNormal];
        [_stateBtn addTarget:self action:@selector(md_xunLianButtonDidClickWithButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _stateBtn;
}
- (UIButton *)remoteBtn{
    if(!_remoteBtn){
        
        _remoteBtn = [[UIButton alloc]init];
        _remoteBtn.backgroundColor = backColor;
        _remoteBtn.tag = 200;
        [_remoteBtn setTitle:@"开始视频" forState:UIControlStateNormal];
        _remoteBtn.titleLabel.font = navTitleFont;
        [_remoteBtn setTitleColor:WHITECOLORA(1) forState:UIControlStateNormal];
        [_remoteBtn addTarget:self action:@selector(md_xunLianButtonDidClickWithButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _remoteBtn;
}
- (void)md_xunLianButtonDidClickWithButton:(UIButton *)sender{
    
    if(sender.tag == 100){
        
        if([_model.state isEqualToString:@"1"]){
            
            OMOCancelBookingAlertView *alertView = [[OMOCancelBookingAlertView alloc]init];
            
            __weak typeof(self) weakSelf = self;
            
            alertView.cancelBookingBlock = ^{
                
                [weakSelf omo_cancelRemoteBooking];
            };
            [alertView show];
        }else if ([_model.state isEqualToString:@"2"]){
            
            OMORemoteResultVC *remoteResultVC = [[OMORemoteResultVC alloc]init];
            remoteResultVC.remote_appoint_id = _model.booking_id;
            [[OMOIphoneManager getCurrentVC].navigationController pushViewController:remoteResultVC animated:YES];
        }
    }else{
        
        [[OMONetworkManager sharedData]postWithURLString:@"41006" parameters:@{@"remote_appoint_id":_model.booking_id} success:^(id responseObject) {
            
            if(responseObject){
                [self omo_startRemoteVideoWithID:[responseObject objectForKey:@"otherAccount"]];
            }else{
                
            }
        } failure:^(NSError *error) {
            
            [MBProgress hideAllHUD];
        }];
    }
}
#pragma mark --------- 取消预约 -------
- (void)omo_cancelRemoteBooking{
    
    if([self.delegate respondsToSelector:@selector(omo_cancelRemoteBookingWithBookingId:)]){
        
        [self.delegate omo_cancelRemoteBookingWithBookingId:_model.booking_id];
    }
}
#pragma mark --------- 开始视频 -------
- (void)omo_startRemoteVideoWithID:(NSString *)ID{
    
    if([self.delegate respondsToSelector:@selector(omo_startRemoteVideoWithID:)]){
        
        [self.delegate omo_startRemoteVideoWithID:ID];
    }
}
@end
