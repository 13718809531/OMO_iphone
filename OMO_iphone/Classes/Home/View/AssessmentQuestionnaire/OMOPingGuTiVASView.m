//
//  OMOPingGuTiVASView.m
//  OMO_iphone
//
//  Created by wy on 2018/9/28.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOPingGuTiVASView.h"
#import "UIImage+ColorImage.h"
#import "OMOVasCustomSlider.h"

@interface OMOPingGuTiVASView()

@property (nonatomic, strong)NSArray <UIColor *> *colors;
@property (nonatomic, strong)UIImageView *img;
@property (nonatomic, strong)UIImageView *sliderImg;
@property (nonatomic, strong)OMOVasCustomSlider *slider;
@property (nonatomic, strong)UILabel *daFenLab;
@property (nonatomic, strong)UILabel *titleLab;

@end

@implementation OMOPingGuTiVASView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        _colors = [NSArray arrayWithObjects:RGB(106, 197, 36),RGB(106, 197, 36),RGB(118, 198, 36),RGB(185, 202, 41),RGB(252, 201, 46),RGB(252, 181, 43),RGB(252, 153, 39),RGB(246, 127, 34),RGB(243, 112, 48),RGB(240, 104, 62),RGB(236, 96, 76), nil];
        
        [self addSubview:self.img];
        [self addSubview:self.daFenLab];
        [self addSubview:self.titleLab];
        [self addSubview:self.sliderImg];
        
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.colors = @[(__bridge id)RGB(106, 197, 36).CGColor, (__bridge id)RGB(252, 160, 40).CGColor, (__bridge id)RGB(236, 75, 77).CGColor];
        gradientLayer.locations = @[@0.1,@0.5,@1.0];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1.0, 0);
        gradientLayer.frame = CGRectMake(lwb_margin * 2, _sliderImg.lwb_bottom + lwb_margin * 2, self.lwb_width - lwb_margin * 4, lwb_margin * 2);
        gradientLayer.masksToBounds = YES;
        gradientLayer.cornerRadius = 10.f;
        [self.layer addSublayer:gradientLayer];
        
        _slider = [[OMOVasCustomSlider alloc] initWithFrame:CGRectMake(lwb_margin * 2, _sliderImg.lwb_bottom + lwb_margin * 2, self.lwb_width - lwb_margin * 4, lwb_margin * 2)];
        // 针对值变化添加响应方法
        [_slider setMaximumTrackTintColor:RGB(244, 245, 249)];
        _slider.minimumTrackTintColor = [UIColor clearColor];
        _slider.continuous = NO;//默认YES  如果设置为NO，则每次滑块停止移动后才触发事件
        [_slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        [_slider setThumbImage:[UIImage imageNamed:@"bg_xz_red_2"] forState:UIControlStateNormal];
        [self addSubview:_slider];
    }
    return self;
}

- (UIImageView *)img{
    
    if(_img == nil){
        
        _img = [[UIImageView alloc]init];
        _img.image = [UIImage imageNamed:@"Vas_0123"];
        //        [_img sizeToFit];
        _img.lwb_size = CGSizeMake(self.lwb_height *0.5, self.lwb_height *0.5);
        _img.lwb_centerX = self.lwb_centerX;
        _img.lwb_y = lwb_margin;
    }
    return _img;
}
- (UILabel *)daFenLab{
    
    if(_daFenLab == nil){
        
        _daFenLab = [[UILabel alloc]init];
        _daFenLab.text = @"0分";
        _daFenLab.textColor = WHITECOLORA(1);
        _daFenLab.textAlignment = NSTextAlignmentCenter;
        _daFenLab.font = Font(24);
        _daFenLab.size = CGSizeMake(60, 30);
        _daFenLab.center = _img.center;
        _daFenLab.backgroundColor = [UIColor clearColor];
    }
    return _daFenLab;
}
- (UILabel *)titleLab{
    
    if(_titleLab == nil){
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.text = @"隐约疼痛,无明显感觉";
        _titleLab.textColor = TextColor;
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.font = Font(20);
        _titleLab.size = CGSizeMake(SCREENW - lwb_margin * 4, 50);
        _titleLab.lwb_centerX = self.lwb_centerX;
        _titleLab.lwb_y = _img.lwb_bottom + 20;
        _titleLab.numberOfLines = -1;
    }
    return _titleLab;
}
- (UIImageView *)sliderImg{
    
    if(_sliderImg == nil){
        
        _sliderImg = [[UIImageView alloc]initWithFrame:CGRectMake(50, _titleLab.lwb_bottom + 20, self.lwb_width - 100, 20)];
        _sliderImg.image = [UIImage imageNamed:@"DaTi_Slider@png"];
    }
    return _sliderImg;
}
#pragma mark -------- slider拖拽方法 -------------
- (void)sliderValueChanged:(id)sender {
    
    UISlider *slider = (UISlider *)sender;
    
    CGFloat values = slider.value;
    
    if(values > 0.9){
        
        slider.value = 1.0;
        _img.image = [UIImage imageNamed:@"Vas_10"];
        _titleLab.text = @"患者有渐强烈的疼痛，疼痛难忍，影响食欲，影响睡眠";
    }else if (values > 0.8){
        
        slider.value = 0.9;
        _img.image = [UIImage imageNamed:@"Vas_789"];
        _titleLab.text = @"患者有渐强烈的疼痛，疼痛难忍，影响食欲，影响睡眠";
    }else if (values > 0.7){
        
        slider.value = 0.8;
        _img.image = [UIImage imageNamed:@"Vas_789"];
        _titleLab.text = @"患者有渐强烈的疼痛，疼痛难忍，影响食欲，影响睡眠";
    }else if (values > 0.6){
        
        slider.value = 0.7;
        _img.image = [UIImage imageNamed:@"Vas_789"];
        _titleLab.text = @"患者有渐强烈的疼痛，疼痛难忍，影响食欲，影响睡眠";
    }else if (values > 0.5){
        
        slider.value = 0.6;
        _img.image = [UIImage imageNamed:@"Vas_456"];
        _titleLab.text = @"患者疼痛并影响睡眠，尚能忍受";
    }else if (values > 0.4){
        
        slider.value = 0.5;
        _img.image = [UIImage imageNamed:@"Vas_456"];
        _titleLab.text = @"患者疼痛并影响睡眠，尚能忍受";
    }else if (values > 0.3){
        
        slider.value = 0.4;
        _img.image = [UIImage imageNamed:@"Vas_456"];
        _titleLab.text = @"患者疼痛并影响睡眠，尚能忍受";
    }else if (values > 0.2){
        
        slider.value = 0.3;
        _img.image = [UIImage imageNamed:@"Vas_0123"];
        _titleLab.text = @"有轻微的疼痛，能忍受";
    }else if (values > 0.1){
        
        slider.value = 0.2;
        _img.image = [UIImage imageNamed:@"Vas_0123"];
        _titleLab.text = @"有轻微的疼痛，能忍受";
    }else if (values > 0.0){
        
        slider.value = 0.1;
        _img.image = [UIImage imageNamed:@"Vas_0123"];
        _titleLab.text = @"有轻微的疼痛，能忍受";
    }else{
        
        slider.value = 0.0;
        _img.image = [UIImage imageNamed:@"Vas_0123"];
        _titleLab.text = @"无痛";
    }
    NSInteger i = lrintf(slider.value * 10);
    _daFenLab.text = [NSString stringWithFormat:@"%ld分",i];
//    UIImage *oldImage = self.img.image;
//    UIImage *image = [self md_colorizeImage:oldImage withColor:_colors[i]];
//    self.img.image = image;
    
    if([self.delegate respondsToSelector:@selector(omo_pingGuTiVasFromSlider_Value:TitleText:)]){
        
        [self.delegate omo_pingGuTiVasFromSlider_Value:[NSString stringWithFormat:@"%ld",i] TitleText:_titleLab.text];
    }
}
- (UIImage *)md_colorizeImage:(UIImage *)baseImage withColor:(UIColor *)theColor {
    
    UIGraphicsBeginImageContext(baseImage.size);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, baseImage.size.width, baseImage.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSaveGState(ctx);
    CGContextClipToMask(ctx, area, baseImage.CGImage);
    
    [theColor set];
    CGContextFillRect(ctx, area);
    
    CGContextRestoreGState(ctx);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextDrawImage(ctx, area, baseImage.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
