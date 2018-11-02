//
//  OMORiskProblemHeadView.m
//  OMO_iphone
//
//  Created by wy on 2018/9/27.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMORiskProblemHeadView.h"

@interface OMORiskProblemHeadView()

@property (nonatomic, strong)UILabel *titleLab;
@property (nonatomic, strong)UILabel *detailLab;

@end

@implementation OMORiskProblemHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        self.backgroundColor = WHITECOLORA(1);
        [self addSubview:self.titleLab];
//        [self addSubview:self.detailLab];
    }
    return self;
}
- (UILabel *)titleLab{
    
    if(_titleLab == nil){
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.text = @"免责声明";
        _titleLab.textColor = TextColor;
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.font = Font(20);
    }
    return _titleLab;
}
- (UILabel *)detailLab{
    
    if(_detailLab == nil){
        
        _detailLab = [[UILabel alloc]init];
        _detailLab.text = @"(多选)";
        _detailLab.textColor = backColor;
        _detailLab.textAlignment = NSTextAlignmentLeft;
        _detailLab.font = Font(20);
    }
    return _detailLab;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    [_detailLab sizeToFit];
    [_detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.titleLab.mas_right).offset(lwb_margin);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [_titleLab sizeToFit];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(lwb_margin * 2);
        make.centerY.equalTo(self.mas_centerY);
    }];
}
@end
