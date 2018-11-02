//
//  OMORehabilitationDetailBottomView.m
//  OMO_iphone
//
//  Created by wy on 2018/10/10.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMORehabilitationBottomView.h"

@interface OMORehabilitationBottomView()

/** 获取训练计划 */
@property (nonatomic, strong)UIButton *obtainBtn;
/**  */
@property (nonatomic, strong)UIView *obtainView;
/** 分享 */
@property (nonatomic, strong)UIButton *shareBtn;

@end

@implementation OMORehabilitationBottomView

- (instancetype)init{
    
    if(self = [super init]){
        
        self.backgroundColor = WHITECOLORA(1);
        self.frame = CGRectMake(0, SCREENH - Between - 60, SCREENW, 60);
        [self addSubview:self.obtainBtn];
//        [self addSubview:self.obtainView];
        [self addSubview:self.shareBtn];
    }
    return self;
}
- (void)setKangFuBaoModel:(OMOKangFuBaoModel *)kangFuBaoModel{
    
    _kangFuBaoModel = kangFuBaoModel;
    
    NSString *str1 = [NSString stringWithFormat:@"购买训练方案¥%@",kangFuBaoModel.discount_price];
    NSString *str2 = [NSString stringWithFormat:@"¥%@",kangFuBaoModel.treat_price];
    NSString *money = [NSString stringWithFormat:@"%@\n%@",str1,str2];
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:money];
    [att addAttribute:NSForegroundColorAttributeName value:backColor range:
     [money rangeOfString:str1]];
    [att addAttribute:NSForegroundColorAttributeName value:RGBA(238, 80, 78, 0.4) range:
     [money rangeOfString:str2]];
    [att addAttribute:NSStrikethroughStyleAttributeName value:@1 range:
     [money rangeOfString:str2]];
    [_obtainBtn setAttributedTitle:att forState:UIControlStateNormal];
}
- (UIButton *)obtainBtn{
    
    if(_obtainBtn == nil){
        
        _obtainBtn = [[UIButton alloc]init];
        _obtainBtn.tag = 100;
        _obtainBtn.lwb_x = 0;
        _obtainBtn.lwb_y = 0;
        _obtainBtn.lwb_size = CGSizeMake(SCREENW * 0.5, self.lwb_height);
        _obtainBtn.backgroundColor = WHITECOLORA(1);
        _obtainBtn.titleLabel.lineBreakMode = 0;
        _obtainBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_obtainBtn addTarget:self action:@selector(omo_rehabilitationClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _obtainBtn;
}
- (UIButton *)shareBtn{
    
    if(_shareBtn == nil){
        
        _shareBtn = [[UIButton alloc]init];
        _shareBtn.tag = 200;
        _shareBtn.lwb_x = SCREENW * 0.5;
        _shareBtn.lwb_y = 0;
        _shareBtn.lwb_size = CGSizeMake(SCREENW * 0.5, self.lwb_height);
        [_shareBtn setTitle:@"免费获取训练方案" forState:UIControlStateNormal];
        _shareBtn.backgroundColor = backColor;
        [_shareBtn setTitleColor:WHITECOLORA(1) forState:UIControlStateNormal];
        _shareBtn.titleLabel.font = bigFont;
        [_shareBtn addTarget:self action:@selector(omo_rehabilitationClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn;
}
- (void)omo_rehabilitationClick:(UIButton *)sender{
    
    
    if([self.delegate respondsToSelector:@selector(omo_rehabilitationBottomClickOfTag:)]){
        
        [self.delegate omo_rehabilitationBottomClickOfTag:sender.tag / 100];
    }
}
@end
