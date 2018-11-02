//
//  InviteTeamShareView.m
//  OMO_iphone
//
//  Created by wy on 2018/10/10.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "InviteTeamShareView.h"
#import "WTShareManager.h"
#import "OMOCustomButtom.h"
#import <Photos/Photos.h>

@interface InviteTeamShareView()

@property (nonatomic,strong)UIButton * backButton;
@property (nonatomic,strong)UIView * whiteView;
@property (nonatomic,strong)UIButton * cancelButton;

@end

@implementation InviteTeamShareView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }return self;
}
-(void)setTitleArray:(NSArray *)titleArray
{
    _titleArray = titleArray;
    
    NSInteger maxColsCount = 0; // 一行的最大列数
    
    if(titleArray.count > 4){
        
        maxColsCount = 4;
    }else{
        
        maxColsCount = titleArray.count;
    }
    CGFloat buttonW = SCREENW / maxColsCount;
    //    CGFloat buttonH = 93;
    for (int i = 0; i < titleArray.count; i++) {
        
        OMOCustomButtom * button = [OMOCustomButtom buttonWithType:UIButtonTypeCustom];
        [button setTitleColor:TextColor forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [button addTarget:self action:@selector(clickShare:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:self.iconArray[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:self.iconArray[i]] forState:UIControlStateHighlighted];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [self.whiteView addSubview:button];
        // 设置frame
        button.lwb_x = (i % maxColsCount) * buttonW;
        button.lwb_y = (i / maxColsCount) * buttonW;
        button.lwb_width = buttonW;
        button.lwb_height = buttonW;
    }
}
-(void)show
{
    //动画
    [UIView animateWithDuration:0.25 animations:^{
        self.whiteView.lwb_y = self.bounds.size.height-261;
        self.backButton.alpha = 0.5;
    }];
}
-(void)dissMiss
{
    if ([self.titleArray containsObject:@"保存到相册"]) {
        if (self.cancelBlock) {
            self.cancelBlock();
        }
    }
    //动画
    [UIView animateWithDuration:0.25 animations:^{
        self.whiteView.lwb_y = self.bounds.size.height;
        self.backButton.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
#pragma mark - 点击按钮
-(void)clickShare:(OMOCustomButtom *)sender
{
    if ([sender.currentTitle isEqualToString:@"生成海报"]) {
        
        if (self.creatPosterBlock) {
            
            self.creatPosterBlock();
        }
    }else if ([sender.currentTitle isEqualToString:@"微信好友"]){
        //        _shareItem.title = @"微信分享的标题";
        //        _shareItem.summary = @"微信朋友哈哈哈哈哈哈";
        //        _shareItem.thumbImage = [UIImage imageNamed:@"icon_dianp_dpsc_sel_2"];
        //        _shareItem.bigImage = [UIImage imageNamed:@"icon_dianp_dpsc_sel_2"];
        //        _shareItem.urlString = [NSString stringWithFormat:@"%@",@"http://www.jhjvip.cn"];
        [WTShareManager wt_shareWithContent:_shareItem shareType:WTShareTypeWeiXinSession shareResult:^(NSString *shareResult) {
            NSLog(@"🐒🐒🐒🐒🐒🐒---%@", shareResult);
        }];
    }else if ([sender.currentTitle isEqualToString:@"朋友圈"]){
        //        _shareItem.title = @"朋友圈分享的标题";
        //        _shareItem.summary = @"朋友圈哈哈哈哈哈哈";
        //        _shareItem.thumbImage = [UIImage imageNamed:@"icon_dianp_dpsc_sel_2"];
        //        _shareItem.bigImage = [UIImage imageNamed:@"icon_dianp_dpsc_sel_2"];
        //        _shareItem.urlString = [NSString stringWithFormat:@"%@",@"http://www.jhjvip.cn"];
        [WTShareManager wt_shareWithContent:_shareItem shareType:WTShareTypeWeiXinTimeline shareResult:^(NSString *shareResult) {
            NSLog(@"🐒🐒🐒🐒🐒🐒---%@", shareResult);
        }];
    }
}
#pragma mark ----- 保存图片 ------------
- (void)loadImageFinished:(UIImage *)image
{
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
}
#pragma mark ----- 保存图片回调 ------------
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    if(error){
        
        [MBProgress showInfomationWithMessage:@"保存失败" duration:1.5];
    }else{
        
        [MBProgress showInfomationWithMessage:@"保存成功" duration:1.5];
    }
}
- (void)setUI{
    
    [self addSubview:self.backButton];
    [self addSubview:self.whiteView];
    [self.whiteView addSubview:self.cancelButton];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.whiteView.mas_left);
        make.right.equalTo(self.whiteView.mas_right);
        make.bottom.equalTo(self.whiteView.mas_bottom);
        make.height.mas_equalTo(52.5);
    }];
    UILabel * line = [[UILabel alloc] init];
    line.backgroundColor = mainBackColor;
    [self.whiteView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.whiteView.mas_left);
        make.right.equalTo(self.whiteView.mas_right);
        make.bottom.equalTo(self.cancelButton.mas_top);
        make.height.mas_equalTo(1);
    }];
    
}
#pragma mark - 懒加载
-(UIButton *)backButton
{
    if (!_backButton) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = self.bounds;
        button.backgroundColor = [UIColor blackColor];
        button.alpha = 0.1;
        [button addTarget:self action:@selector(dissMiss) forControlEvents:UIControlEventTouchUpInside];
        _backButton = button;
    }return _backButton;
}
-(UIView *)whiteView
{
    if (!_whiteView) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height, self.bounds.size.width, 261)];
        view.backgroundColor = [UIColor whiteColor];
        _whiteView = view;
    }return _whiteView;
}
-(UIButton *)cancelButton
{
    if (!_cancelButton) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [button setTitle:@"取消" forState:UIControlStateNormal];
        [button setTitleColor:TextColor forState:UIControlStateNormal];
        [button addTarget:self action:@selector(dissMiss) forControlEvents:UIControlEventTouchUpInside];
        _cancelButton = button;
    }return _cancelButton;
}

@end
