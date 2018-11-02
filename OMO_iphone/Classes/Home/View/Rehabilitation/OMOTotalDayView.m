//
//  OMOTotalDayView.m
//  OMO_iphone
//
//  Created by wy on 2018/10/15.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOTotalDayView.h"

@interface OMOTotalDayView()

/**  */
@property (nonatomic, strong)UILabel *titleLab;
/**  */
@property (nonatomic, strong)UILabel *dayLab;

@end

@implementation OMOTotalDayView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        self.backgroundColor = WHITECOLORA(1);
        self.layer.cornerRadius = lwb_margin;
        
        [self addSubview:self.titleLab];
        [self addSubview:self.dayLab];
    }
    return self;
}
- (void)setPe_planModel:(OMOKangFuBaoPe_PlanModel *)pe_planModel{
    
    _pe_planModel = pe_planModel;
    
    _titleLab.text = pe_planModel.title;
    
    NSString *dayStr = [NSString stringWithFormat:@"共%@天",pe_planModel.total_level_day];
    
    NSString *str = [NSString stringWithFormat:@"%@：%@",pe_planModel.level_day_text_prefix,dayStr];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:str];
    NSDictionary * attriBute = @{NSForegroundColorAttributeName:textColour,NSFontAttributeName:BoldFont(18)};
    [attStr addAttributes:attriBute range:[str rangeOfString:dayStr]];
    
    _dayLab.attributedText = attStr;
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(lwb_margin * 2);
        make.right.equalTo(self.mas_right).offset(-lwb_margin);
        make.height.equalTo(@(self.lwb_height * 0.5));
        make.top.equalTo(self.mas_top).offset(lwb_smallMargin);
    }];
    
    [_dayLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(lwb_margin * 2);
        make.right.equalTo(self.mas_right).offset(-lwb_margin);
        make.height.equalTo(@(self.lwb_height * 0.5));
        make.bottom.equalTo(self.mas_bottom).offset(-lwb_smallMargin);
    }];
}
- (UILabel *)titleLab{
    
    if(_titleLab == nil){
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.textColor = textColour;
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.font = BoldFont(18);
    }
    return _titleLab;
}
- (UILabel *)dayLab{
    
    if(_dayLab == nil){
        
        _dayLab = [[UILabel alloc]init];
        _dayLab.textColor = DetailColor;
        _dayLab.textAlignment = NSTextAlignmentLeft;
        _dayLab.font = bigFont;
    }
    return _dayLab;
}

@end
