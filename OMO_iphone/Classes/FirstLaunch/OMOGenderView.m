//
//  OMOGenderView.m
//  OMO_iphone
//
//  Created by wy on 2018/10/18.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOGenderView.h"

@interface OMOGenderView()

/**  */
@property (nonatomic, strong)UILabel *titleLab;
/** 男 */
@property (nonatomic, strong)UIButton *maleBtn;
/** 女 */
@property (nonatomic, strong)UIButton *femaleBtn;
/** 下一步按钮 */
@property (nonatomic,strong)UIButton *nextBtn;

@end

@implementation OMOGenderView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        self.backgroundColor = WHITECOLORA(1);
//        self.frame = CGRectMake(lwb_margin * 2, SCREENH, SCREENW - lwb_margin * 4, SCREENH * 0.5);
        
        [self addSubview:self.titleLab];
        [self addSubview:self.maleBtn];
        [self addSubview:self.femaleBtn];
        [self addSubview:self.nextBtn];
    }
    return self;
}
- (UILabel *)titleLab{
    
    if(_titleLab == nil){
        
        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, lwb_margin, self.lwb_width, 40)];
        _titleLab.text = @"请选择您的性别";
        _titleLab.textColor = DetailColor;
        _titleLab.font = BoldFont(IFFitFloat6(26));
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}

- (UIButton *)maleBtn{
    
    if(_maleBtn == nil){
        
        _maleBtn = [[UIButton alloc]init];
        _maleBtn.size = CGSizeMake(self.lwb_width * 0.3, self.lwb_width * 0.3);
        _maleBtn.lwb_x = self.lwb_width * 0.15;
        _maleBtn.lwb_centerY = SCREENH * 0.25;
        [_maleBtn setBackgroundImage:[UIImage imageNamed:@"Male_Normal"] forState:UIControlStateNormal];
        [_maleBtn setBackgroundImage:[UIImage imageNamed:@"Male_Select"] forState:UIControlStateSelected];
        _maleBtn.tag = 100;
        [_maleBtn addTarget:self action:@selector(omo_selectGender:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _maleBtn;
}
- (UIButton *)femaleBtn{
    
    if(_femaleBtn == nil){
        
        _femaleBtn = [[UIButton alloc]init];
        [_femaleBtn setBackgroundImage:[UIImage imageNamed:@"Female_Normal"] forState:UIControlStateNormal];
        [_femaleBtn setBackgroundImage:[UIImage imageNamed:@"Female_Select"] forState:UIControlStateSelected];
        _femaleBtn.tag = 200;
        _femaleBtn.size = CGSizeMake(self.lwb_width * 0.3, self.lwb_width * 0.3);
        _femaleBtn.lwb_x = self.lwb_width * 0.55;
        _femaleBtn.lwb_centerY = SCREENH * 0.25;
        [_femaleBtn addTarget:self action:@selector(omo_selectGender:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _femaleBtn;
}
- (UIButton *)nextBtn{
    if(_nextBtn == nil){
        
        _nextBtn = [[UIButton alloc]init];
        _nextBtn.lwb_width = self.lwb_width / 3;
        _nextBtn.lwb_height = 40.f;
        _nextBtn.lwb_centerX = self.lwb_centerX;
        _nextBtn.lwb_bottom = self.lwb_height - 40;
        _nextBtn.layer.masksToBounds = YES;
        _nextBtn.layer.cornerRadius = 20.f;
        _nextBtn.backgroundColor = backColor;
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        _nextBtn.titleLabel.font = navTitleFont;
        [_nextBtn setTitleColor:WHITECOLORA(1) forState:UIControlStateNormal];
        [_nextBtn addTarget:self action:@selector(omo_nextViewController) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
}
#pragma mark ------- 选择性别 -------
- (void)omo_selectGender:(UIButton *)sender{
    
    if(sender.tag == 100){
        
        [OMOIphoneManager sharedData].gender = @"1";
        self.femaleBtn.selected = NO;
    }else{
        
        [OMOIphoneManager sharedData].gender = @"0";
        self.maleBtn.selected = NO;
    }
    sender.selected = YES;
}
#pragma mark ------- 下一步 --------
- (void)omo_nextViewController{
    
    if ([OMOIphoneManager sharedData].birthday.length <= 0){
        
        [MBProgress showInfoMessage:@"App需要您的性别以完善您的信息"];
    }else{
        
        if(self.genderBlock){
            
            self.genderBlock();
        }
    }
}
@end
