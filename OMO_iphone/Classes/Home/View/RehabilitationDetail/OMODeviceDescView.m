//
//  OMODeviceDescView.m
//  OMO_iphone
//
//  Created by wy on 2018/10/18.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMODeviceDescView.h"

@interface OMODeviceDescView()

/**  */
@property (nonatomic,strong)UIButton * backButton;// 背部
/**  */
@property (nonatomic, strong)UIView *backView;
/**  */
@property (nonatomic, strong)UIImageView *goodsImgV;
/**  */
@property (nonatomic, strong)UIButton *closeBtn;
/**  */
@property (nonatomic, strong)UILabel *descLab;

@end

@implementation OMODeviceDescView

- (instancetype)init{
    
    if(self = [super init]){
        
        self.frame = CGRectMake(0, 0, SCREENW, SCREENH);
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.backButton];
        [self addSubview:self.backView];
    }
    return self;
}
- (void)setItemModel:(OMOKangFuBaoMtItemModel *)itemModel{
    
    _itemModel = itemModel;
    
    [_goodsImgV sd_setImageWithURL:[NSURL URLWithString:itemModel.url] placeholderImage:[UIImage imageNamed:@""]];
    
    NSString *str = @"asdfghjjfjhgfassdghdjkjglfkdjfhdgsfsgshgfdjgfkhhfjhgsfdsshgdhmhnbvjtyrtertefdfggfjfshbzv";
    
    _descLab.attributedText = [str setLabelSpaceOfLineSpacing:6.f Kern:4.f Font:bigFont];
}
- (void)show{
    
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
- (UIView *)backView{
    
    if(_backView == nil){
        
        CGFloat height = SCREENH / 3 * 2;
        
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREENH - height, SCREENW, height)];
        _backView.backgroundColor = mainBackColor;
        [_backView addSubview:self.goodsImgV];
        [_backView addSubview:self.descLab];
        [_backView addSubview:self.closeBtn];
    }
    return _backView;
}
-(UIButton *)backButton
{
    if (!_backButton) {
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = self.bounds;
        button.backgroundColor = [UIColor whiteColor];
        button.alpha = 0.4;
        [button addTarget:self action:@selector(dissMiss) forControlEvents:UIControlEventTouchUpInside];
        _backButton = button;
    }return _backButton;
}
- (UIButton *)closeBtn{
    
    if(_closeBtn == nil){
        
        _closeBtn = [[UIButton alloc]init];
        _closeBtn.titleLabel.font = navTitleFont;
        _closeBtn.lwb_x = SCREENW - lwb_margin * 2 - 30.f;
        _closeBtn.lwb_y = lwb_margin * 2;
        _closeBtn.lwb_height = 40;
        _closeBtn.lwb_width = 120.f;
        _closeBtn.layer.masksToBounds = YES;
        _closeBtn.layer.cornerRadius = 15.f;
        _closeBtn.layer.borderWidth = 1.f;
        _closeBtn.layer.borderColor = backColor.CGColor;
        [_closeBtn addTarget:self action:@selector(dissMiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}
- (UIImageView *)goodsImgV{
    
    if(_goodsImgV == nil){
        
        _goodsImgV = [[UIImageView alloc]initWithFrame:CGRectMake(IFFitFloat6(50), 70, SCREENW - IFFitFloat6(100), self.backView.lwb_height / 3)];
        _goodsImgV.backgroundColor = WHITECOLORA(1);
        _goodsImgV.clipsToBounds = YES;
        _goodsImgV.contentMode = UIViewContentModeScaleToFill;
    }
    return _goodsImgV;
}
- (UILabel *)descLab{
    
    if(_descLab == nil){
        
        _descLab = [[UILabel alloc]initWithFrame:CGRectMake(IFFitFloat6(50), self.goodsImgV.lwb_bottom + lwb_margin * 2, SCREENW - IFFitFloat6(100), self.backView.lwb_height - self.goodsImgV.lwb_bottom - lwb_margin * 4)];
        _descLab.textAlignment = NSTextAlignmentLeft;
        _descLab.textColor = textColour;
    }
    return _descLab;
}
@end
