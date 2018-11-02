//
//  OMOShareFootView.m
//  OMO_iphone
//
//  Created by wy on 2018/10/10.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOShareFootView.h"

@interface OMOShareFootView()

@property(strong,nonatomic)UIButton *clooseBtn;// 关闭

@end

@implementation OMOShareFootView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        [self addSubview:self.clooseBtn];
        self.backgroundColor = RGB(255, 255, 255);
    }
    return self;
}
- (UIButton *)clooseBtn{
    
    if(_clooseBtn == nil){
        
        _clooseBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.lwb_width / 2 - 15, lwb_smallMargin, 30, 30)];
        [_clooseBtn setImage:[UIImage imageNamed:@"icon_xq_qx_1"] forState:UIControlStateNormal];
        [_clooseBtn addTarget:self action:@selector(clooseBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clooseBtn;
}
- (void)clooseBtnDidClick{
    
    if(self.clooseBlock){
        
        self.clooseBlock();
    }
}

@end
