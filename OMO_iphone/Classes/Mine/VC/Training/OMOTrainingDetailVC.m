//
//  OMOTrainingDetailVC.m
//  OMO_iphone
//
//  Created by wy on 2018/10/26.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOTrainingDetailVC.h"
/**  */
#import "OMOTrainingDetailHeadView.h"

@interface OMOTrainingDetailVC ()

/**  */
@property (nonatomic, strong)OMOTrainingDetailHeadView *headView;

@end

@implementation OMOTrainingDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatBar];
    [self.bar addLeftButtonWithImage:[UIImage imageNamed:@"App_Back"]];
    [self.bar addTitltLabelWithText:@"我的训练方案" Font:navTitleFont];
    
    [self.view addSubview:self.headView];
}
- (OMOTrainingDetailHeadView *)headView{
    
    if(_headView == nil){
        
        _headView = [[OMOTrainingDetailHeadView alloc]initWithFrame:CGRectMake(lwb_margin * 2, IphoneY + lwb_margin, SCREENW - lwb_margin * 4, SCREENH * 0.2)];
        _headView.backgroundColor = [UIColor redColor];
        _headView.url = _resouceModel.url;
    }
    return _headView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
