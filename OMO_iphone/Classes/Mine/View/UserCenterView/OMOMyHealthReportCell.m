//
//  OMOMyHealthReportCell.m
//  OMO_iphone
//
//  Created by 郭越 on 2018/10/18.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOMyHealthReportCell.h"
/**  */
#import "OMOKangFuBaoModel.h"
/**  */
#import "OMOCheckHealthReportVC.h"
/**  */
#import "OMOBuyDevicesVC.h"

@interface OMOMyHealthReportCell()

@property(strong,nonatomic)UIView *backView;
@property(strong,nonatomic)UIButton *checkDetial;// 查看详情按钮
@property(strong,nonatomic)UILabel *titleLab;// 标题
@property(strong,nonatomic)UILabel *editDetailLab;// 详情
@property(strong,nonatomic)UILabel *timeLab;//时间

@end
@implementation OMOMyHealthReportCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.backgroundColor = WHITECOLORA(1);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.backView];
        [self addSubview:self.checkDetial];
        [self addSubview:self.titleLab];
        [self addSubview:self.editDetailLab];
        [self addSubview:self.timeLab];
    }
    return self;
}
- (void)setReportModel:(OMOHealthReportModel *)reportModel{
    
    _reportModel = reportModel;
    
    _titleLab.text = reportModel.title;
    
    _timeLab.text = [NSString stringWithFormat:@"报告时间:%@",reportModel.created];
    
    if([reportModel.state isEqualToString:@"1"]){
        
        [_checkDetial setTitle:@"去支付" forState:UIControlStateNormal];
    }else{
        
        [_checkDetial setTitle:@"查看报告" forState:UIControlStateNormal];
    }
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
    [_checkDetial mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.mas_right).offset(-20);
        make.top.equalTo(self.titleLab.mas_bottom).offset(lwb_margin);
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
- (UIButton *)checkDetial{
    
    if(_checkDetial == nil){
        _checkDetial = [[UIButton alloc]init];
        _checkDetial.backgroundColor = OrangeColor;
        [_checkDetial.layer setMasksToBounds:YES];
        [_checkDetial.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
        [_checkDetial.layer setBorderWidth:0.0]; //边框宽度
        _checkDetial.titleLabel.font = bigFont;
//        [_checkDetial setTitle:@"查看报告" forState:UIControlStateNormal];
        [_checkDetial setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_checkDetial addTarget:self action:@selector(omo_checkHealthReport) forControlEvents:UIControlEventTouchUpInside];
    }
    return _checkDetial;
}
- (UILabel *)timeLab{
    
    if(_timeLab == nil){
        _timeLab = [[UILabel alloc]init];
        _timeLab.textColor = DetailColor;
        _timeLab.font = defoultFont;
        _timeLab.textAlignment = NSTextAlignmentLeft;
    }
    return _timeLab;
}
- (UILabel *)titleLab{
    
    if(_titleLab == nil){
        _titleLab = [[UILabel alloc]init];
        _titleLab.textColor = textColour;
        _titleLab.font = BoldFont(16);
        _titleLab.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLab;
}
- (UILabel *)editDetailLab{
    
    if(_editDetailLab == nil){
        
        _editDetailLab = [[UILabel alloc]init];
        _editDetailLab.textColor = DetailColor;
        _editDetailLab.font = defoultFont;
        _editDetailLab.textAlignment = NSTextAlignmentCenter;
//        _editDetailLab.text = @"专业评估制定报告";
    }
    return _editDetailLab;
}
- (void)omo_checkHealthReport{
    
    __weak typeof(self) weakSelf = self;;
    
    [[OMONetworkManager sharedData]postWithURLString:@"20016" parameters:@{@"pe_order_id":_reportModel.report_id} success:^(id responseObject) {
        
        if(responseObject){
            
            NSDictionary *dataSouce = (NSDictionary *)responseObject;
            
            OMOKangFuBaoModel *kangFuBaoModel = [OMOKangFuBaoModel mj_objectWithKeyValues:dataSouce[@"value"]];
            
            if([weakSelf.reportModel.state isEqualToString:@"1"]){
                
                OMOBuyDevicesVC *buyDevicesVC = [[OMOBuyDevicesVC alloc]init];
                buyDevicesVC.numType = 2;
                buyDevicesVC.buyType = 0;
                buyDevicesVC.kangFuBaoModel = kangFuBaoModel;
                [[OMOIphoneManager getCurrentVC].navigationController pushViewController:buyDevicesVC animated:YES];
            }else{
                
                OMOCheckHealthReportVC *checkHealthReportVC = [[OMOCheckHealthReportVC alloc]init];
                checkHealthReportVC.kangFuBaoModel = kangFuBaoModel;
                [[OMOIphoneManager getCurrentVC].navigationController pushViewController:checkHealthReportVC animated:YES];
            }
        }
    } failure:^(NSError *error) {
        
        [MBProgress hideAllHUD];
    }];
}
@end
