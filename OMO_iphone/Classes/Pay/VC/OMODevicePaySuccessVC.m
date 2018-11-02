//
//  OMODevicePaySuccessVC.m
//  OMO_iphone
//
//  Created by wy on 2018/10/17.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMODevicePaySuccessVC.h"
/**  */
#import "OMOPayShareSuccessTopView.h"
/**  */
#import "OMOPayShareSuccessFootView.h"
/**  */
#import "OMOTrainingListVC.h"
/**  */
#import "OMOOrderModel.h"

@interface OMODevicePaySuccessVC ()

/**  */
@property (nonatomic, strong)OMOPayShareSuccessTopView *topView;
/**  */
@property (nonatomic, strong)OMOPayShareSuccessFootView *footView;
/**  */
@property (nonatomic, strong)NSArray *dataSouce;
/** 不需要 */
@property (nonatomic, strong)UIButton *startBtn;
/**  */
@property (nonatomic, strong)OMOOrderModel *orderModel;

@end

@implementation OMODevicePaySuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatBar];
    [self.bar addLeftButtonWithImage:[UIImage imageNamed:@"App_Back"]];
    [self.bar addTitltLabelWithText:@"支付成功" Font:navTitleFont];
    
    self.view.backgroundColor = WHITECOLORA(1);
    [self omo_requestData];
    
    [self.view addSubview:self.topView];
    [self.view addSubview:self.footView];
    [self.view addSubview:self.startBtn];
}
- (void)omo_requestData{
    
    __weak typeof(self) weakSelf = self;
    
    [[OMONetworkManager  sharedData]postWithURLString:@"60002" parameters:@{@"pe_order_id":_pe_order_id} success:^(id responseObject) {
        
        if(responseObject){
            
            NSDictionary *dataSouce = (NSDictionary *)responseObject;
            
            weakSelf.orderModel = [OMOOrderModel mj_objectWithKeyValues:dataSouce[@"order_info"]];
            [weakSelf setDataSouce];
        }
    } failure:^(NSError *error) {
        
        [MBProgress hideAllHUD];
    }];
}
- (void)setDataSouce{
    
    NSDictionary *dict1 = @{@"title":@"订单编号",@"detail":checkNull(_orderModel.out_trade_no)};
    NSDictionary *dict2 = @{@"title":@"下单时间",@"detail":checkNull(_orderModel.pay_time)};
    NSDictionary *dict3 = @{@"title":@"支付金额",@"detail":checkNull(_orderModel.total_fee)};
    NSDictionary *dict4 = @{@"title":@"支付方式",@"detail":checkNull(_orderModel.pay_type)};
    
    self.footView.dataSouce = @[dict1,dict2,dict3,dict4];
}
- (OMOPayShareSuccessTopView *)topView{
    
    if(_topView == nil){
        
        _topView = [[OMOPayShareSuccessTopView alloc]initWithFrame:CGRectMake(0, IphoneY, SCREENW, (SCREENH - IphoneY - 80) * 0.5)];
    }
    return _topView;
}
- (OMOPayShareSuccessFootView *)footView{
    
    if(_footView == nil){
        
        _footView = [[OMOPayShareSuccessFootView alloc]initWithFrame:CGRectMake(0, self.topView.lwb_bottom, SCREENW, (SCREENH - IphoneY - 80) * 0.5) style:UITableViewStylePlain];
        _footView.dataSouce = _dataSouce;
    }
    return _footView;
}
- (UIButton *)startBtn{
    
    if(_startBtn == nil){
        
        _startBtn = [[UIButton alloc]initWithFrame:CGRectMake(IFFitFloat6(lwb_pblicX), SCREENH - 80, SCREENW - IFFitFloat6(lwb_pblicX) * 2, 40)];
        _startBtn.backgroundColor = backColor;
        _startBtn.titleLabel.font = navTitleFont;
        [_startBtn setTitle:@"开始训练" forState:UIControlStateNormal];
        [_startBtn setTitleColor:WHITECOLORA(1) forState:UIControlStateNormal];
        _startBtn.layer.cornerRadius = 20.f;
        [_startBtn addTarget:self action:@selector(omo_startStaining:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startBtn;
}
#pragma mark ------- 开始训练 --------
- (void)omo_startStaining:(UIButton *)sender{
    
    OMOTrainingListVC *trainingListVC = [[OMOTrainingListVC alloc]init];
    [self.navigationController pushViewController:trainingListVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
