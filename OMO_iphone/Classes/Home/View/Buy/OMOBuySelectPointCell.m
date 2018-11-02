//
//  OMOBuySelectPointCell.m
//  OMO_iphone
//
//  Created by wy on 2018/10/17.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOBuySelectPointCell.h"

@interface OMOBuySelectPointCell()

@property (nonatomic,strong)UILabel *titleLab;
/**  */
@property (nonatomic, strong)UISwitch *bindingSwitch;

@end

@implementation OMOBuySelectPointCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = WHITECOLORA(1);
        
        [self addSubview:self.titleLab];
        [self addSubview:self.bindingSwitch];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(lwb_margin * 2, self.lwb_height - 5, self.lwb_width - lwb_margin * 4, 5)];
        lineView.backgroundColor = mainBackColor;
        [self addSubview:lineView];
    }return self;
}
- (void)setTitle:(NSString *)title{
    
    _title = title;
    
    _titleLab.text = title;
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [_titleLab sizeToFit];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-100);
        make.left.equalTo(self.mas_left).offset(lwb_margin * 2);
    }];
    
    [_bindingSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.mas_centerY);
        make.height.equalTo(@(self.lwb_height * 0.5));
        make.right.equalTo(self.mas_right);
        make.width.equalTo(@(80));
    }];
}
- (UILabel *)titleLab{
    
    if(_titleLab == nil){
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.text = @"微信";
        _titleLab.textColor = textColour;
        _titleLab.font = bigFont;
        _titleLab.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLab;
}
- (UISwitch *)bindingSwitch{
    
    if(_bindingSwitch == nil){
        
        //2. create switch
        _bindingSwitch = [[UISwitch alloc] init];
        //        _bindingSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(SCREENW - 120, 15, 100, 30)];
        //        //缩小或者放大switch的size
        //        _bindingSwitch.transform = CGAffineTransformMakeScale(0.5, 0.5);
        //        _bindingSwitch.layer.anchorPoint = CGPointMake(0, 0.3);
        //    self.mainSwitch.onImage = [UIImage imageNamed:@"on.png"];   //无效
        //    self.mainSwitch.offImage = [UIImage imageNamed:@"off.png"]; //无效
        //
        //        _bindingSwitch.backgroundColor = mainBackColor;
        //它是矩形的
        // 设置开关状态(默认是 关)
        [_bindingSwitch setOn:YES animated:true];
        //animated
        
        //thumbTintColor 滑块的背景颜色
        _bindingSwitch.thumbTintColor = mainBackColor;
        
        //添加事件监听
        [_bindingSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        //定制开关颜色UI
        //tintColor 关状态下的背景颜色
        _bindingSwitch.tintColor = DetailColor;
        //onTintColor 开状态下的背景颜色
        _bindingSwitch.onTintColor = backColor;
    }
    return _bindingSwitch;
}
- (void)switchAction:(id)sender{
    
    UISwitch *switchButton = (UISwitch*)sender;
    
    BOOL isButtonOn = [switchButton isOn];
    
    if([self.delegate respondsToSelector:@selector(OMO_SwitchPointDeductionWithOn:)]){
        
        [self.delegate OMO_SwitchPointDeductionWithOn:isButtonOn];
    }
}

@end
