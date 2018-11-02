//
//  OMOStoreBookingCell.m
//  OMO_iphone
//
//  Created by wy on 2018/10/25.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOStoreBookingCell.h"

@interface OMOStoreBookingCell()

/**  */
@property (nonatomic, strong)UILabel *titleLab;
/**  */
@property (nonatomic, strong)UILabel *storeNameLab;
/**  */
@property (nonatomic, strong)UILabel *mobileLab;
/**  */
@property (nonatomic, strong)UILabel *modeLab;
/**  */
@property (nonatomic, strong)UILabel *dateLab;
/**  */
@property (nonatomic, strong)UILabel *descLab;
/**  */
@property (nonatomic, strong)UILabel *creatLab;
/**  */
@property (nonatomic, strong)UIButton *stateBtn;

@end

@implementation OMOStoreBookingCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        self.layer.cornerRadius = lwb_smallMargin;
        self.backgroundColor = WHITECOLORA(1);
        [self addSubview:self.titleLab];
        [self addSubview:self.storeNameLab];
        [self addSubview:self.mobileLab];
        [self addSubview:self.modeLab];
        [self addSubview:self.dateLab];
        [self addSubview:self.descLab];
        [self addSubview:self.creatLab];
        [self addSubview:self.stateBtn];
    }
    return self;
}
- (void)setModel:(OMOStoreBookingModel *)model{
    
    _model = model;
    
    _titleLab.text = model.title;
    _storeNameLab.text = [NSString stringWithFormat:@"服务中心:%@",model.store_name];
    _mobileLab.text = [NSString stringWithFormat:@"中心电话:%@",model.store_mobile];
    _modeLab.text = [NSString stringWithFormat:@"服务方式:%@",model.service_mode];
    _dateLab.text = [NSString stringWithFormat:@"预约时间:%@",model.date];
    _descLab.text = [NSString stringWithFormat:@"病情描述:%@",model.desc];
    if([model.state isEqualToString:@"1"]){
        
        [_stateBtn setTitle:@"取消预约" forState:UIControlStateNormal];
        _stateBtn.backgroundColor = backColor;
    }else if ([model.state isEqualToString:@"2"]){
        
        [_stateBtn setTitle:@"取消预约" forState:UIControlStateNormal];
        _stateBtn.backgroundColor = backColor;
    }else if ([model.state isEqualToString:@"3"]){
        
        [_stateBtn setTitle:@"已完成" forState:UIControlStateNormal];
        _stateBtn.backgroundColor = DetailColor;
    }else if ([model.state isEqualToString:@"4"]){
        
        [_stateBtn setTitle:@"已取消" forState:UIControlStateNormal];
        _stateBtn.backgroundColor = DetailColor;
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
    
    [_storeNameLab sizeToFit];
    [_storeNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(lwb_margin * 2);
        make.top.equalTo(self.titleLab.mas_bottom).offset(lwb_margin * 2);
        make.right.equalTo(self.mas_right).offset(-lwb_margin * 2);
    }];
    
    [_mobileLab sizeToFit];
    [_mobileLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(lwb_margin * 2);
        make.top.equalTo(self.storeNameLab.mas_bottom).offset(lwb_margin);
        make.right.equalTo(self.mas_right).offset(-lwb_margin * 2);
    }];
    
    [_modeLab sizeToFit];
    [_modeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(lwb_margin * 2);
        make.top.equalTo(self.mobileLab.mas_bottom).offset(lwb_margin);
        make.right.equalTo(self.mas_right).offset(-lwb_margin * 2);
    }];
    
    [_dateLab sizeToFit];
    [_dateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(lwb_margin * 2);
        make.top.equalTo(self.modeLab.mas_bottom).offset(lwb_margin);
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
        make.top.equalTo(self.descLab.mas_top).offset(lwb_margin);
        make.right.equalTo(self.mas_right).offset(-lwb_margin * 2);
    }];
    
    [_stateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(lwb_margin * 2);
        make.bottom.equalTo(self.mas_bottom).offset(-lwb_margin);
        make.width.equalTo(@(130));
        make.height.equalTo(@(30));
    }];
    _stateBtn.layer.cornerRadius = 15.f;
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
- (UILabel *)storeNameLab{
    
    if(_storeNameLab == nil){
        
        _storeNameLab = [[UILabel alloc]init];
        _storeNameLab.textColor = DetailColor;
        _storeNameLab.font = bigFont;
        _storeNameLab.textAlignment = NSTextAlignmentLeft;
    }
    return _storeNameLab;
}
- (UILabel *)mobileLab{
    
    if(_mobileLab == nil){
        
        _mobileLab = [[UILabel alloc]init];
        _mobileLab.textColor = DetailColor;
        _mobileLab.font = bigFont;
        _mobileLab.textAlignment = NSTextAlignmentLeft;
    }
    return _mobileLab;
}
- (UILabel *)modeLab{
    
    if(_modeLab == nil){
        
        _modeLab = [[UILabel alloc]init];
        _modeLab.textColor = DetailColor;
        _modeLab.font = bigFont;
        _modeLab.textAlignment = NSTextAlignmentLeft;
    }
    return _modeLab;
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
- (void)md_xunLianButtonDidClickWithButton:(UIButton *)sender{
    
    if([_model.state isEqualToString:@"1"] || [_model.state isEqualToString:@"2"]){
        
        if([self.delegate respondsToSelector:@selector(OMOCancelStoreBookingWithBookingId:)]){
            
            [self.delegate OMOCancelStoreBookingWithBookingId:_model.booking_id];
        }
    }
}

@end
