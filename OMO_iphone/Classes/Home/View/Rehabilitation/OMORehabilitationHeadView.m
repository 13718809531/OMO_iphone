//
//  OMONotLoginRehabilitationView.m
//  OMO_iphone
//
//  Created by wy on 2018/10/13.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMORehabilitationHeadView.h"

@interface OMORehabilitationHeadView ()

/**  */
@property (nonatomic, strong)UIImageView *backImg;
/**  */
@property (nonatomic, strong)UILabel *titleLab2;
/**  */
@property (nonatomic, strong)UILabel *titleLab3;

@end

@implementation OMORehabilitationHeadView

- (instancetype)init{
    
    if(self = [super init]){
        
        self.frame = CGRectMake(0, 0, SCREENW, SCREENH * 0.5);
    
        [self addSubview:self.backImg];
        [self addSubview:self.titleLab2];
        [self addSubview:self.titleLab3];
    }
    return self;
}
- (void)setScoreModel:(OMOKangFuBaoPe_ScoreModel *)scoreModel{
    
    _scoreModel = scoreModel;
    
    NSInteger score = scoreModel.score.integerValue;
    NSString *image = @"";
    
    if(score == 100){
        
        self.backgroundColor = RGB(121, 179, 53);
//        _backImg.image = [UIImage imageNamed:@""];
        image = @"";
    }else if (score >= 80){
        
        self.backgroundColor = RGB(253, 168, 72);
//        _backImg.image = [UIImage imageNamed:@""];
        image = @"";
    }else if (score >= 60){
        
        self.backgroundColor = RGB(240, 110, 55);
//        _backImg.image = [UIImage imageNamed:@""];
        image = @"";
    }else if (score >= 40){
        
        self.backgroundColor = RGB(245, 110, 54);
//        _backImg.image = [UIImage imageNamed:@""];
        image = @"";
    }else if (score >= 20){
        
        self.backgroundColor = RGB(211, 60, 41);
//        _backImg.image = [UIImage imageNamed:@""];
        image = @"";
    }else{
        
        self.backgroundColor = RGB(200, 80, 20);
//        _backImg.image = [UIImage imageNamed:@""];
        image = @"";
    }
    NSTextAttachment *attchImage = [[NSTextAttachment alloc] init];
    // 表情图片
    attchImage.image = [UIImage imageNamed:image];
    // 设置图片大小
    attchImage.bounds = CGRectMake(0, -5, 20, 20);
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc]initWithString:scoreModel.title];
    NSAttributedString *stringImage = [NSAttributedString attributedStringWithAttachment:attchImage];
    [attriStr insertAttributedString:stringImage atIndex:0];
    
    _titleLab3.attributedText = attriStr;
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [_titleLab2 sizeToFit];
    [_titleLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(@(IphoneY + lwb_margin * 2));
    }];
    
    [_titleLab3 sizeToFit];
    [_titleLab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_bottom).offset(-IFFitFloat6(lwb_margin * 2));
    }];
}

- (UIImageView *)backImg{
    
    if(_backImg == nil){
        
        _backImg = [[UIImageView alloc]init];
        _backImg.image = [UIImage imageNamed:@"Slice 7"];
        _backImg.size = CGSizeMake(self.lwb_width + IFFitFloat6(100), self.lwb_width + IFFitFloat6(100));
        _backImg.center = self.center;
    }
    return _backImg;
}
- (UILabel *)titleLab2{
    
    if(_titleLab2 == nil){
        
        _titleLab2 = [[UILabel alloc]init];
        _titleLab2.textColor = WHITECOLORA(1);
        _titleLab2.textAlignment = NSTextAlignmentCenter;
        _titleLab2.text = [NSString stringWithFormat:@"经过测评 您目前的%@功能水平为",[OMOIphoneManager sharedData].cate_name];
    }
    return _titleLab2;
}
- (UILabel *)titleLab3{
    
    if(_titleLab3 == nil){
        
        _titleLab3 = [[UILabel alloc]init];
        _titleLab3.textColor = DetailColor;
        _titleLab3.textAlignment = NSTextAlignmentRight;
        _titleLab3.font = bigFont;
    }
    return _titleLab3;
}
@end
