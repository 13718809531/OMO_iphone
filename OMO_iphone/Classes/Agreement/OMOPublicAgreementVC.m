//
//  OMOPublicAgreementVC.m
//  OMO_iphone
//
//  Created by wy on 2018/10/18.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOPublicAgreementVC.h"

@interface OMOPublicAgreementVC ()

@property (nonatomic, weak)UIScrollView *scrollView;
@property (nonatomic, strong)UIImageView *headView;
@property (nonatomic, strong)UILabel *textView;
@property (nonatomic,copy)NSAttributedString *attStr;/** 富文本 */

@end

@implementation OMOPublicAgreementVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *title;
    
    if(_agreementType == 1){
        
        title = @"服务协议";
    }else if (_agreementType == 2){
        
        title = @"注册协议";
    }else if (_agreementType == 3){
        
        title = @"免责声明";
    }else if (_agreementType == 4){
        
        title = @"关于我们";
    }
    [self creatBar];
    [self.bar addLeftButtonWithImage:[UIImage imageNamed:@"App_Back"]];
    [self.bar addTitltLabelWithText:title Font:navTitleFont];
    
    [self omo_requestDataSouce];
}
- (void)omo_requestDataSouce{
    
    __weak typeof(self) weakSelf = self;
    
    [[OMONetworkManager sharedData] postWithURLString:@"10006" parameters:nil success:^(id responseObject) {
        
        if(responseObject){
            
            [weakSelf setDataSouceWithDictionary:(NSDictionary *)responseObject];
        }
    } failure:^(NSError *error) {
        
        [MBProgress hideAllHUD];
    }];
}
- (void)setDataSouceWithDictionary:(NSDictionary *)dictionary{
    
    NSString *text = dictionary[@"desc"];
    _attStr = [text setLabelSpaceOfLineSpacing:4.0 Kern:1.0 Font:bigFont];
    
    [self setScrollView];
}
#pragma mark 页面视图
- (void)setScrollView{
    // 不允许自动调整 scrollView 的内边距(隐藏滚动条)
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //     给本页面加载一个滚动视图
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, IphoneY, SCREENW, SCREENH - IphoneY)];
    
    scroll.backgroundColor = WHITECOLORA(1);
    
    // 隐藏滚动条
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.showsVerticalScrollIndicator = NO;
    [scroll addSubview:self.headView];
    [scroll addSubview:self.textView];
    [self.view addSubview:scroll];
    self.scrollView = scroll;
    // 最大偏移范围
    scroll.contentSize = CGSizeMake(SCREENW, self.textView.lwb_bottom + lwb_margin);
}
- (UIImageView *)headView{
    
    if(_headView == nil){
        
        _headView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREENW, IFFitFloat6(200))];
        _headView.backgroundColor = backColor;
    }
    return _headView;
}
- (UILabel *)textView{
    
    if(_textView == nil){
        
        _textView = [[UILabel alloc]initWithFrame:CGRectMake(lwb_margin, self.headView.lwb_bottom, SCREENW - lwb_margin * 2, 1)];
        _textView.numberOfLines = 0;
        _textView.textColor = textColour;
        _textView.font = bigFont;
        _textView.textAlignment = NSTextAlignmentLeft;
        _textView.attributedText = _attStr;
        _textView.lwb_height = [_textView getLabelHightOfLineSpacing:4.f Kern:1.f] + lwb_margin * 4;
    }
    return _textView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
