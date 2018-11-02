//
//  OMOHomeExclusiveDetailVC.m
//  OMO_iphone
//
//  Created by wy on 2018/10/29.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOHomeExclusiveDetailVC.h"
/**  */
#import "OMOPbulicShareView.h"

@interface OMOHomeExclusiveDetailVC ()

/**  */
@property (nonatomic, strong)UIWebView *webView;

@end

@implementation OMOHomeExclusiveDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.webView];
    [self creatBar];
    [self.bar addLeftButtonWithImage:[UIImage imageNamed:@"App_Back"]];
    [self.bar addRightButtonWithImage:[UIImage imageNamed:@"icon_xq_qx_1"]];
    [self.bar.rightButton addTarget:self action:@selector(omo_shareExclusive) forControlEvents:UIControlEventTouchUpInside];
}
- (UIWebView *)webView   {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _webView.dataDetectorTypes = UIDataDetectorTypeAll;
    }
    return _webView;
}
// 让浏览器加载指定的字符串,使用m.baidu.com进行搜索
- (void)loadString:(NSString *)str  {
    // 1. URL 定位资源,需要资源的地址
    NSString *urlStr = str;
    if (![str hasPrefix:@"http://"]) {
        urlStr = [NSString stringWithFormat:@"http://m.baidu.com/s?id=%@", str];
    }
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    // 2. 把URL告诉给服务器,请求,从m.baidu.com请求数据
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 3. 发送请求给服务器
    [self.webView loadRequest:request];
}
#pragma mark --------- 分享服务 ----------
- (void)omo_shareExclusive{
    
    OMOPbulicShareView *shareView = [[OMOPbulicShareView alloc]init];
    [shareView show];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
