//
//  OMORemoteBookingPayView.m
//  OMO_iphone
//
//  Created by wy on 2018/10/24.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMORemoteBookingPayView.h"
/** 支付 */
#import "OMOPayTypeCell.h"

@interface OMORemoteBookingPayView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UIButton * backButton;// 背部
/**  */
@property (nonatomic, strong)UIView *backView;
/**  */
@property (nonatomic, strong)UILabel *priceLab;
/**  */
@property (nonatomic, strong)UILabel *totalLab;
/** 记录支付方式,默认微信 */
@property (nonatomic,assign)NSInteger payType;

@end

static NSString *OMOPayTypeCellID = @"OMOPayTypeCellID";

@implementation OMORemoteBookingPayView

- (instancetype)init{
    
    if(self = [super init]){
        
        self.backgroundColor = [UIColor clearColor];
        self.frame = CGRectMake(0, 0, SCREENW, SCREENH);
        _payType = 0;
        [self addSubview:self.backButton];
        [self addSubview:self.backView];
    }
    return self;
}
- (void)setPrice:(NSString *)price{
    
    _price = price;
    
    _priceLab.text = [NSString stringWithFormat:@"预约挂号:%@",price];
    
    _totalLab.text = [NSString stringWithFormat:@"合计:¥%@  ",price];
}
- (void)show
{
    [[OMOIphoneManager getCurrentVC].view addSubview:self];
    
    //动画
    [UIView animateWithDuration:0.25 animations:^{
        
        self.backButton.alpha = 0.5;
        self.backView.lwb_bottom = SCREENH;
    }];
}
- (void)dissMiss{
    
    //动画
    [UIView animateWithDuration:0.25 animations:^{
        self.backView.lwb_y = SCREENH;
        self.backButton.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
#pragma mark - 懒加载
-(UIButton *)backButton
{
    if (!_backButton) {
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = self.bounds;
        button.backgroundColor = [UIColor clearColor];
        button.alpha = 0.4;
        [button addTarget:self action:@selector(dissMiss) forControlEvents:UIControlEventTouchUpInside];
        _backButton = button;
    }return _backButton;
}
- (UIView *)backView{
    
    if(_backView == nil){
        
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREENH, SCREENW, 44 * 4 + IFFitFloat6(100) + Between)];
        _backView.backgroundColor = mainBackColor;
        
        UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(44, 0, _backView.lwb_width - 88, 44)];
        titleLab.font = navTitleFont;
        titleLab.textColor = textColour;
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.text = @"支付";
        [_backView addSubview:titleLab];
        
        UIButton * dissMissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        dissMissBtn.frame = CGRectMake(10, 10, 24, 24);
        dissMissBtn.backgroundColor = [UIColor clearColor];
        [dissMissBtn setImage:[UIImage imageNamed:@"App_Back"] forState:UIControlStateNormal];
        [dissMissBtn addTarget:self action:@selector(dissMiss) forControlEvents:UIControlEventTouchUpInside];
        [_backView addSubview:dissMissBtn];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(lwb_margin, 44, _backView.lwb_width - lwb_margin * 2, 2)];
        lineView.backgroundColor = DetailColor;
        [_backView addSubview:lineView];
        
        _priceLab = [[UILabel alloc]initWithFrame:CGRectMake(44, 46, _backView.lwb_width - 88, IFFitFloat6(70))];
        _priceLab.font = bigFont;
        _priceLab.textColor = textColour;
        _priceLab.textAlignment = NSTextAlignmentCenter;
        [_backView addSubview:_priceLab];
        
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44 + 2 + IFFitFloat6(70), SCREENW, 88) style:UITableViewStylePlain];
        tableView.scrollEnabled = NO;
        tableView.backgroundColor = WHITECOLORA(1);
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tableView registerClass:[OMOPayTypeCell class] forCellReuseIdentifier:OMOPayTypeCellID];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tableFooterView = [[UIView alloc]init];
        [_backView addSubview:tableView];
        
        _totalLab = [[UILabel alloc]initWithFrame:CGRectMake(0, _backView.lwb_height - 44 - Between, _backView.lwb_width * 0.75, 44)];
        _totalLab.backgroundColor = WHITECOLORA(1);
        _totalLab.font = navTitleFont;
        _totalLab.textColor = textColour;
        _totalLab.textAlignment = NSTextAlignmentRight;
        [_backView addSubview:_totalLab];
        
        UIButton *submitBtn = [[UIButton alloc]initWithFrame:CGRectMake(_backView.lwb_width * 0.75, _backView.lwb_height - 44 - Between, _backView.lwb_width * 0.25, 44)];
        submitBtn.backgroundColor = backColor;
        [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        submitBtn.titleLabel.font = navTitleFont;
        [submitBtn setTitleColor:WHITECOLORA(1) forState:UIControlStateNormal];
        [submitBtn addTarget:self action:@selector(omo_submitOrderDidClik) forControlEvents:UIControlEventTouchUpInside];
        [_backView addSubview:submitBtn];
    }
    return _backView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OMOPayTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:OMOPayTypeCellID];
    cell.payType = indexPath.row;
    
    if(indexPath.row == _payType){
        
        cell.isSelect = YES;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(_payType == indexPath.row)return;
    
    _payType = indexPath.row;
    
    [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44.f;
}

#pragma mark ---------- 提交支付 ----------
- (void)omo_submitOrderDidClik{
    
    if(self.selectPayTypeBlock){
        
        self.selectPayTypeBlock([NSString stringWithFormat:@"%ld",_payType + 1]);
    }
    [self dissMiss];
}
@end
