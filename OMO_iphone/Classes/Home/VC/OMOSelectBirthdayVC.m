//
//  OMOSelectBirthdayVC.m
//  OMO_iphone
//
//  Created by wy on 2018/10/16.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOSelectBirthdayVC.h"
/**  */
#import "BRPickerView.h"
/**  */
#import "OMOSelectPartsVC.h"

@interface OMOSelectBirthdayVC ()

/**  */
@property (nonatomic, strong)UILabel *titleLab;
/**  */
@property (nonatomic, strong)UILabel *promptLab;
/**  */
@property (nonatomic, strong)UILabel *selectLab;
/** 生日 */
@property (nonatomic, strong)UIButton *birthdayBtn;
/** 下一步按钮 */
@property (nonatomic,strong)UIButton *nextBtn;

@end

@implementation OMOSelectBirthdayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = WHITECOLORA(1);
    [self creatBar];
    [self.bar addLeftButtonWithImage:[UIImage imageNamed:@"App_Back"]];
    self.bar.line.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.titleLab];
    [self.view addSubview:self.promptLab];
    [self.view addSubview:self.selectLab];
    [self.view addSubview:self.birthdayBtn];
    [self.view addSubview:self.nextBtn];
}
- (UILabel *)titleLab{
    
    if(_titleLab == nil){
        
        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(IFFitFloat6(lwb_pblicX), IphoneY + IFFitFloat6(lwb_margin), SCREENW - lwb_pblicX * 2, 40)];
        _titleLab.text = @"完善资料";
        _titleLab.textColor = textColour;
        _titleLab.font = BoldFont(28);
        _titleLab.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLab;
}
- (UILabel *)promptLab{
    
    if(_promptLab == nil){
        
        _promptLab = [[UILabel alloc]initWithFrame:CGRectMake(IFFitFloat6(lwb_pblicX), self.titleLab.lwb_bottom + lwb_smallMargin, SCREENW - lwb_pblicX * 2, 30)];
        _promptLab.text = @"提供准确的信息,保证评估的准确性";
        _promptLab.textColor = DetailColor;
        _promptLab.font = Font(22);
        _promptLab.textAlignment = NSTextAlignmentLeft;
    }
    return _promptLab;
}
- (UILabel *)selectLab{
    
    if(_selectLab == nil){
        
        _selectLab = [[UILabel alloc]init];
        _selectLab.text = @"请选择您的出生日期";
        _selectLab.textColor = DetailColor;
        _selectLab.font = FontMas(20);
        _selectLab.textAlignment = NSTextAlignmentCenter;
        [_selectLab sizeToFit];
        _selectLab.lwb_centerX = SCREENW * 0.5;
        _selectLab.lwb_bottom = SCREENH * 0.5 - IFFitFloat6(60);
    }
    return _selectLab;
}
- (UIButton *)birthdayBtn{
    
    if(_birthdayBtn == nil){
        
        _birthdayBtn = [[UIButton alloc]init];
        _birthdayBtn.backgroundColor = mainBackColor;
        [_birthdayBtn setTitle:@"----年--月--日" forState:UIControlStateNormal];
        [_birthdayBtn setTitleColor:DetailColor forState:UIControlStateNormal];
        _birthdayBtn.size = CGSizeMake(SCREENW * 0.5, 40);
        _birthdayBtn.center = self.view.center;
        [_birthdayBtn addTarget:self action:@selector(omo_selectBirthday:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _birthdayBtn;
}
- (UIButton *)nextBtn{
    if(_nextBtn == nil){
        
        _nextBtn = [[UIButton alloc]init];
        _nextBtn.lwb_width = SCREENW - IFFitFloat6(lwb_pblicX) * 2;
        _nextBtn.lwb_height = 40.f;
        _nextBtn.lwb_centerX = self.view.lwb_centerX;
        _nextBtn.lwb_bottom = SCREENH - 40;
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
    
    if([OMOIphoneManager sharedData].birthday.length > 9){
        
        defaultDateStr = [OMOIphoneManager sharedData].birthday;
    }
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
    
    if([OMOIphoneManager sharedData].user_id.length > 0){
        
        NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
        
        parmas[@"birthday"] = [OMOIphoneManager sharedData].birthday;
        
        [[OMONetworkManager sharedData]postWithURLString:@"20001" parameters:parmas success:^(id responseObject) {
            
            if(responseObject){
                
                NSDictionary *dataSouce = (NSDictionary *)responseObject;
                
                [OMOIphoneManager initWithDictionary:dataSouce];
                
                OMOSelectPartsVC *seletPartsVC = [[OMOSelectPartsVC alloc]init];
                [self.navigationController pushViewController:seletPartsVC animated:YES];
            }
        } failure:^(NSError *error) {
            
            [MBProgress hideAllHUD];
        }];
    }else{
        
        OMOSelectPartsVC *seletPartsVC = [[OMOSelectPartsVC alloc]init];
        [self.navigationController pushViewController:seletPartsVC animated:YES];
    }
}

@end
