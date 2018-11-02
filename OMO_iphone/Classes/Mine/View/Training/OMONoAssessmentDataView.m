//
//  OMONoAssessmentDataView.m
//  OMO_iphone
//
//  Created by wy on 2018/10/24.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMONoAssessmentDataView.h"
/**  */
#import "OMOSelectGenderVC.h"
/**  */
#import "OMOSelectBirthdayVC.h"
/**  */
#import "OMOSelectPartsVC.h"

@interface OMONoAssessmentDataView()

/**  */
@property (nonatomic, strong)UIImageView *img;
/**  */
@property (nonatomic, strong)UILabel *titleLab;
/**  */
@property (nonatomic, strong)UIButton *startBtn;

@end

@implementation OMONoAssessmentDataView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        self.backgroundColor = mainBackColor;
        self.layer.cornerRadius = lwb_margin;
        [self addSubview:self.img];
        [self addSubview:self.titleLab];
        [self addSubview:self.startBtn];
    }
    return self;
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [_img sizeToFit];
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [_titleLab sizeToFit];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(lwb_margin);
        make.top.equalTo(self.img.mas_bottom).offset(lwb_margin);
        make.right.equalTo(self.mas_right).offset(-lwb_margin);
    }];
    
    [_startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.mas_right).offset(-lwb_margin);
        make.bottom.equalTo(self.mas_bottom).offset(-lwb_margin * 2);
        make.left.equalTo(self.mas_left).offset(lwb_margin);
        make.height.equalTo(@(40));
    }];
    _startBtn.layer.masksToBounds = YES;
    _startBtn.layer.cornerRadius = 20.f;
}
- (UIImageView *)img{
    
    if(_img == nil){
        
        _img = [[UIImageView alloc]init];
        _img.clipsToBounds = YES;
        _img.contentMode = UIViewContentModeScaleToFill;
        _img.image = [UIImage imageNamed:@"No_Data"];
    }
    return _img;
}
- (UILabel *)titleLab{
    
    if(_titleLab == nil){
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.text = @"3分钟评估出您的健康水平,快去试试吧~";
        _titleLab.textColor = textColour;
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}

- (UIButton *)startBtn{

    if(_startBtn == nil){

        _startBtn = [[UIButton alloc]init];
        _startBtn.backgroundColor = backColor;
        _startBtn.titleLabel.font = navTitleFont;
        [_startBtn setTitle:@"开始评估" forState:UIControlStateNormal];
        [_startBtn setTitleColor:WHITECOLORA(1) forState:UIControlStateNormal];
        [_startBtn addTarget:self action:@selector(omo_toEvaluate) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startBtn;
}
// 立即评估
- (void)omo_toEvaluate{
    
    if([OMOIphoneManager sharedData].user_id.length > 0){
        
        if([OMOIphoneManager sharedData].gender.length <= 0){
            
            OMOSelectGenderVC *selectGenderVC = [[OMOSelectGenderVC alloc]init];
            [[OMOIphoneManager getCurrentVC].navigationController pushViewController:selectGenderVC animated:YES];
        }else if ([OMOIphoneManager sharedData].birthday.length <= 0){
            
            OMOSelectBirthdayVC *selectBirthdayVC = [[OMOSelectBirthdayVC alloc]init];
            [[OMOIphoneManager getCurrentVC].navigationController pushViewController:selectBirthdayVC animated:YES];
        }else{
            
            OMOSelectPartsVC *selectPartsVC = [[OMOSelectPartsVC alloc]init];
            [[OMOIphoneManager getCurrentVC].navigationController pushViewController:selectPartsVC animated:YES];
        }
    }else{
        
        OMOSelectGenderVC *selectGenderVC = [[OMOSelectGenderVC alloc]init];
        [[OMOIphoneManager getCurrentVC].navigationController pushViewController:selectGenderVC animated:YES];
    }
}
@end
