//
//  OMOShowWXBindingVC.m
//  OMO_iphone
//
//  Created by wy on 2018/10/22.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOShowWXBindingVC.h"

@interface OMOShowWXBindingVC ()

/**  */
@property (nonatomic,assign)CGFloat width;
/**  */
@property (nonatomic, strong)UIImageView *headImg;
/**  */
@property (nonatomic, strong)UILabel *titleLab;
/**  */
@property (nonatomic, strong)UILabel *detailLab;
/**  */
@property (nonatomic, strong)UIButton *cancelBtn;
/**  */
@property (nonatomic, strong)UIButton *determineBtn;

@end

@implementation OMOShowWXBindingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatBar];
    [self.bar addLeftButtonWithImage:[UIImage imageNamed:@"App_Back"]];
    self.bar.line.backgroundColor = WHITECOLORA(1);
    
    _width = (SCREENW - 100) * 0.5;
    
    self.view.backgroundColor = WHITECOLORA(1);
    [self.view addSubview:self.headImg];
    [self.view addSubview:self.titleLab];
    [self.view addSubview:self.detailLab];
    [self.view addSubview:self.cancelBtn];
    [self.view addSubview:self.determineBtn];
}
- (void)setWxUserInfo:(NSDictionary *)wxUserInfo{
    
    _wxUserInfo = wxUserInfo;
//    parmareter[@"openid"] = openid;
//    parmareter[@"nickname"] = nickname;
//    parmareter[@"headimgurl"] = headimgurl;
//    parmareter[@"sex"] = sex;
//    parmareter[@"mobile"] = [OMOIphoneManager sharedData].mobile;
}
- (UIImageView *)headImg{
    
    if(_headImg == nil){
        
        _headImg = [[UIImageView alloc]init];
        _headImg.size = CGSizeMake(IFFitFloat6(100), IFFitFloat6(100));
        _headImg.lwb_y = IphoneY + IFFitFloat6(50);
        _headImg.lwb_centerX = self.view.lwb_centerX;
        _headImg.contentMode = UIViewContentModeScaleToFill;
        
        __weak typeof(self) weakSelf = self;
        [_headImg sd_setImageWithURL:[NSURL URLWithString:_wxUserInfo[@"nickname"]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
            if(image){
                
                weakSelf.headImg.image = [image circleImage];
            }else{
                
                UIImage *holderImage = [UIImage imageNamed:@"Placeholder_head"];
                weakSelf.headImg.image = [holderImage circleImage];
            }
        }];
    }
    return _headImg;
}
- (UILabel *)titleLab{
    
    if(_titleLab == nil){
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.textColor = textColour;
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.text = @"您要绑定的微信,已经注册过账号";
        _titleLab.lwb_x = lwb_margin * 2;
        _titleLab.lwb_width = SCREENW - lwb_margin * 4;
        _titleLab.lwb_y = self.headImg.lwb_bottom + IFFitFloat6(50);
        _titleLab.lwb_height = 40;
    }
    return _titleLab;
}

- (UILabel *)detailLab{
    
    if(_detailLab == nil){
        
        _detailLab = [[UILabel alloc]init];
        _detailLab.textColor = DetailColor;
        _detailLab.numberOfLines = 0;
        _detailLab.lwb_x = lwb_margin * 2;
        _detailLab.lwb_width = SCREENW - lwb_margin * 4;
        _detailLab.lwb_y = self.titleLab.lwb_bottom + lwb_margin;
        _detailLab.lwb_height = 80;
        _detailLab.textAlignment = NSTextAlignmentLeft;
        _detailLab.font = defoultFont;
        NSString *oldName = [OMOIphoneManager sharedData].nickname;
        NSString *text = [NSString stringWithFormat:@"如果继续绑定,将无法用微信登录账号【%@】,%@的数据可能丢失,是否继续?",oldName,oldName];
        NSAttributedString *attText = [text setLabelSpaceOfLineSpacing:6.f Kern:1.f Font:defoultFont];
        _detailLab.attributedText = attText;
    }
    return _detailLab;
}
- (UIButton *)cancelBtn{
    if(!_cancelBtn){
        
        _cancelBtn = [[UIButton alloc]init];
        _cancelBtn.backgroundColor = WHITECOLORA(1);
        _cancelBtn.tag = 100;
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = navTitleFont;
        _cancelBtn.lwb_x = 40;
        _cancelBtn.lwb_width = _width;
        _cancelBtn.lwb_height = 40;
        _cancelBtn.lwb_bottom = SCREENH - 40 - Between;
        _cancelBtn.layer.masksToBounds = YES;
        _cancelBtn.layer.cornerRadius = 20.f;
        _cancelBtn.layer.borderColor = backColor.CGColor;
        _cancelBtn.layer.borderWidth = 1.f;
        [_cancelBtn setTitleColor:backColor forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(md_xunLianButtonDidClickWithButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}
- (UIButton *)determineBtn{
    if(!_determineBtn){
        
        _determineBtn = [[UIButton alloc]init];
        _determineBtn.backgroundColor = backColor;
        _determineBtn.tag = 200;
        [_determineBtn setTitle:@"继续绑定" forState:UIControlStateNormal];
        _determineBtn.titleLabel.font = navTitleFont;
        _determineBtn.lwb_x = 40 + lwb_margin + _width;
        _determineBtn.lwb_width = _width;
        _determineBtn.lwb_height = 40;
        _determineBtn.lwb_bottom = SCREENH - 40 - Between;
        _determineBtn.layer.masksToBounds = YES;
        _determineBtn.layer.cornerRadius = 20.f;
        [_determineBtn setTitleColor:WHITECOLORA(1) forState:UIControlStateNormal];
        [_determineBtn addTarget:self action:@selector(md_xunLianButtonDidClickWithButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _determineBtn;
}
- (void)md_xunLianButtonDidClickWithButton:(UIButton *)sender{
    
    if(sender.tag == 100){
        
        if(self.WXBindingBlock){
            
            self.WXBindingBlock(YES);
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else{
        
        if(self.WXBindingBlock){
            
            self.WXBindingBlock(NO);
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
