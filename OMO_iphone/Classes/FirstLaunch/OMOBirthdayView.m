//
//  OMOBirthdayView.m
//  OMO_iphone
//
//  Created by wy on 2018/10/18.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOBirthdayView.h"
/**  */
#import "BRPickerView.h"

@interface OMOBirthdayView ()

/**  */
@property (nonatomic, strong)UILabel *titleLab;
/** 生日 */
@property (nonatomic, strong)UIButton *birthdayBtn;
/** 下一步按钮 */
@property (nonatomic,strong)UIButton *nextBtn;

@end

@implementation OMOBirthdayView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        self.backgroundColor = WHITECOLORA(1);
        self.frame = CGRectMake(lwb_margin * 2, SCREENH, SCREENW - lwb_margin * 4, SCREENH * 0.5);
        
        [self addSubview:self.titleLab];
        [self addSubview:self.birthdayBtn];
        [self addSubview:self.nextBtn];
    }
    return self;
}
- (UILabel *)titleLab{
    
    if(_titleLab == nil){
        
        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, lwb_margin * 2, self.lwb_width, 40)];
        _titleLab.text = @"请选择您的出生日";
        _titleLab.textColor = DetailColor;
        _titleLab.font = BoldFont(IFFitFloat6(26));
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}

- (UIButton *)birthdayBtn{
    
    if(_birthdayBtn == nil){
        
        _birthdayBtn = [[UIButton alloc]init];
        _birthdayBtn.backgroundColor = mainBackColor;
        [_birthdayBtn setTitle:@"----年--月--日" forState:UIControlStateNormal];
        [_birthdayBtn setTitleColor:DetailColor forState:UIControlStateNormal];
        _birthdayBtn.size = CGSizeMake(SCREENW * 0.5, 40);
        _birthdayBtn.lwb_centerX = self.lwb_width * 0.5;
        _birthdayBtn.lwb_centerY = self.lwb_height * 0.5;
        [_birthdayBtn addTarget:self action:@selector(omo_selectBirthday:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _birthdayBtn;
}
- (UIButton *)nextBtn{
    if(_nextBtn == nil){
        
        _nextBtn = [[UIButton alloc]init];
        _nextBtn.lwb_width = 120;
        _nextBtn.lwb_height = 40.f;
        _nextBtn.lwb_centerX = self.lwb_width * 0.5;
        _nextBtn.lwb_bottom = self.lwb_height - 40;
        _nextBtn.layer.masksToBounds = YES;
        _nextBtn.layer.cornerRadius = 20.f;
        _nextBtn.backgroundColor = backColor;
        [_nextBtn setTitle:@"确定" forState:UIControlStateNormal];
        _nextBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_nextBtn setTitleColor:WHITECOLORA(1) forState:UIControlStateNormal];
        [_nextBtn addTarget:self action:@selector(omo_nextViewController) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
}
#pragma mark ------- 选择年龄 -------
- (void)omo_selectBirthday:(UIButton *)sender{
    
    //得到当前的时间
    NSDate * nowDate = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = nil;
    //            comps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitMonth fromDate:mydate];
    comps = [calendar components:NSCalendarUnitYear fromDate:nowDate];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:-40];
    NSDate *defaultDate = [calendar dateByAddingComponents:adcomps toDate:nowDate options:0];
    NSString *defaultDateStr = [dateFormatter stringFromDate:defaultDate];
    
    [adcomps setYear:-100];
    NSDate *minDate = [calendar dateByAddingComponents:adcomps toDate:nowDate options:0];
    
    __weak typeof(self) weakSelf = self;
    [BRDatePickerView showDatePickerWithTitle:@"请选择出生日期" dateType:BRDatePickerModeDate defaultSelValue:defaultDateStr minDate:minDate  maxDate:nowDate isAutoSelect:NO themeColor:nil resultBlock:^(NSString *selectValue) {
        
        NSString *title = weakSelf.birthdayBtn.currentTitle;
        
        if([selectValue isEqualToString:title])return ;
        
        [weakSelf.birthdayBtn setTitle:selectValue forState:UIControlStateNormal];
    }];
}
#pragma mark ------- 下一步 --------
- (void)omo_nextViewController{
    
    NSString *title = _birthdayBtn.currentTitle;
    
    if([title containsString:@"--"])return;
    
    [OMOIphoneManager sharedData].birthday = title;
    
    if(self.birthdayBlock){
        
        self.birthdayBlock();
    }
}


@end
