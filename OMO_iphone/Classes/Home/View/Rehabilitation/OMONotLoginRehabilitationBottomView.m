//
//  OMONotLoginRehabilitationBottomView.m
//  OMO_iphone
//
//  Created by wy on 2018/10/15.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMONotLoginRehabilitationBottomView.h"
/**  */
#import "OMOLoginMobileVC.h"

@interface OMONotLoginRehabilitationBottomView ()

/** 查看训练方案 */
@property (nonatomic, strong)UIButton *checkPlanBtn;

@end

@implementation OMONotLoginRehabilitationBottomView

- (instancetype)init{
    
    if(self = [super init]){
        
        self.frame = CGRectMake(0, SCREENH * 0.5, SCREENW, SCREENH * 0.5);
        [self addSubview:self.checkPlanBtn];
    }
    return self;
}
- (void)setScore:(NSString *)score{
    
    _score = score;
    
    NSInteger sco = score.integerValue;
    
    if(sco == 100){
        
        self.backgroundColor = RGB(121, 179, 53);
    }else if (sco >= 80){
        
        self.backgroundColor = RGB(253, 168, 72);
    }else if (sco >= 60){
        
        self.backgroundColor = RGB(240, 110, 55);
    }else if (sco >= 40){
        
        self.backgroundColor = RGB(245, 110, 54);
    }else if (sco >= 20){
        
        self.backgroundColor = RGB(211, 60, 41);
    }else{
        
        self.backgroundColor = RGB(200, 80, 20);
    }
}
- (UIButton *)checkPlanBtn{
    
    if(_checkPlanBtn == nil){
        
        _checkPlanBtn = [[UIButton alloc]init];
        _checkPlanBtn.lwb_x = IFFitFloat6(40);
        _checkPlanBtn.lwb_y = self.lwb_height - 80;
        _checkPlanBtn.lwb_size = CGSizeMake(SCREENW - IFFitFloat6(40) * 2, 40);
        [_checkPlanBtn setTitle:@"登录查看训练方案" forState:UIControlStateNormal];
        _checkPlanBtn.layer.masksToBounds = YES;
        _checkPlanBtn.layer.cornerRadius = 20.f;
        _checkPlanBtn.layer.borderWidth = 1.f;
        _checkPlanBtn.layer.borderColor = WHITECOLORA(1).CGColor;
        _checkPlanBtn.backgroundColor = mainBackColor;
        [_checkPlanBtn setTitleColor:WHITECOLORA(1) forState:UIControlStateNormal];
        _checkPlanBtn.titleLabel.font = bigFont;
        [_checkPlanBtn addTarget:self action:@selector(omo_checkPlan) forControlEvents:UIControlEventTouchUpInside];
    }
    return _checkPlanBtn;
}

#pragma mark ----- 查看训练方案 ---------
- (void)omo_checkPlan{
    
    OMOLoginMobileVC *detailVC = [[OMOLoginMobileVC alloc]init];
    
    [[OMOIphoneManager getCurrentVC].navigationController pushViewController:detailVC animated:YES];
}

@end
