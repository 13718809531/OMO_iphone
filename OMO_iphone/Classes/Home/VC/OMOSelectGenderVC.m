//
//  OMOSelectGenderVC.m
//  OMO_iphone
//
//  Created by wy on 2018/10/16.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOSelectGenderVC.h"
/**  */
#import "OMOSelectBirthdayVC.h"
/**  */
#import "OMOSelectPartsVC.h"

@interface OMOSelectGenderVC ()

/**  */
@property (nonatomic, strong)UILabel *titleLab;
/**  */
@property (nonatomic, strong)UILabel *promptLab;
/**  */
@property (nonatomic, strong)UILabel *selectLab;
/** 男 */
@property (nonatomic, strong)UIButton *maleBtn;
/** 女 */
@property (nonatomic, strong)UIButton *femaleBtn;
/** 下一步按钮 */
@property (nonatomic,strong)UIButton *nextBtn;

@end

@implementation OMOSelectGenderVC

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
    [self.view addSubview:self.maleBtn];
    [self.view addSubview:self.femaleBtn];
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
        _promptLab.textAlignment = NSTextAlignmentLeft;
    }
    return _promptLab;
}
- (UILabel *)selectLab{
    
    if(_selectLab == nil){
        
        _selectLab = [[UILabel alloc]init];
        _selectLab.text = @"请选择您的性别";
        _selectLab.textColor = DetailColor;
        _selectLab.font = FontMas(20);
        _selectLab.textAlignment = NSTextAlignmentCenter;
        [_selectLab sizeToFit];
        _selectLab.lwb_centerX = SCREENW * 0.5;
        _selectLab.lwb_bottom = self.maleBtn.lwb_y - lwb_margin;
    }
    return _selectLab;
}
- (UIButton *)maleBtn{
    
    if(_maleBtn == nil){
        
        _maleBtn = [[UIButton alloc]init];
        [_maleBtn setBackgroundImage:[UIImage imageNamed:@"Male_Normal"] forState:UIControlStateNormal];
        [_maleBtn setBackgroundImage:[UIImage imageNamed:@"Male_Select"] forState:UIControlStateSelected];
        _maleBtn.tag = 100;
        [_maleBtn sizeToFit];
        _maleBtn.lwb_centerX = SCREENW * 0.5;
        _maleBtn.lwb_bottom = SCREENH * 0.5;
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
        [_femaleBtn sizeToFit];
        _femaleBtn.lwb_centerX = SCREENW * 0.5;
        _femaleBtn.lwb_y = SCREENH * 0.5 + lwb_margin * 4;
        [_femaleBtn addTarget:self action:@selector(omo_selectGender:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _femaleBtn;
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
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        _nextBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_nextBtn setTitleColor:WHITECOLORA(1) forState:UIControlStateNormal];
        //        _nextBtn.enabled = NO;
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
    
    if([OMOIphoneManager sharedData].user_id.length > 0){
        
        NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
        
        parmas[@"gender"] = [OMOIphoneManager sharedData].gender;
        
        [[OMONetworkManager sharedData]postWithURLString:@"20001" parameters:parmas success:^(id responseObject) {
            
            if(responseObject){
                
                NSDictionary *dataSouce = (NSDictionary *)responseObject;
                
                [OMOIphoneManager initWithDictionary:dataSouce];
                
                [self omo_judgePushViewController];
            }
        } failure:^(NSError *error) {
            
            [MBProgress hideAllHUD];
        }];
    }else{
        
        [self omo_judgePushViewController];
    }
}
- (void)omo_judgePushViewController{
    
    if ([OMOIphoneManager sharedData].birthday.length <= 0){
        
        OMOSelectBirthdayVC *selectBirthdayVC = [[OMOSelectBirthdayVC alloc]init];
        [self.navigationController pushViewController:selectBirthdayVC animated:YES];
    }else{
        
        OMOSelectPartsVC *selectPartsVC = [[OMOSelectPartsVC alloc]init];
        [self.navigationController pushViewController:selectPartsVC animated:YES];
    }
}
@end
