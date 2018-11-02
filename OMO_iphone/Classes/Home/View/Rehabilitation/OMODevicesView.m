//
//  OMODevicesView.m
//  OMO_iphone
//
//  Created by wy on 2018/10/15.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMODevicesView.h"
/**  */
#import "OMOAssistiveDevicesVC.h"

@interface OMODevicesView()<UIScrollViewDelegate>

/**  */
@property (nonatomic, strong)UIScrollView *scrollView;
/**  */
@property (nonatomic, strong)UILabel *titleLab;
/**  */
@property (nonatomic, strong)UIButton *edingBtn;

@end

@implementation OMODevicesView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        self.backgroundColor = WHITECOLORA(1);
        self.layer.cornerRadius = lwb_margin;
        
        [self addSubview:self.titleLab];
        [self addSubview:self.edingBtn];
        [self addSubview:self.scrollView];
    }
    return self;
}

- (void)setItems:(NSArray<OMOKangFuBaoMtItemModel *> *)items{
    
    _items = items;
        
    CGFloat btnX = lwb_margin;
    CGFloat btnY = lwb_margin;
    
    for (int i = 0; i < items.count; i ++) {
        
        OMOKangFuBaoMtItemModel *itemModel = [items objectAtIndex:i];
        
        UIButton *typeBtn = [[UIButton alloc] init];
        
        typeBtn.tag = 1000 + i;
        
        [typeBtn setTitle:itemModel.name forState:UIControlStateNormal];
        
        typeBtn.titleLabel.font = defoultFont;
        
        typeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [typeBtn setTitleColor:textColour forState:UIControlStateNormal];
        
        CGFloat width = [typeBtn.currentTitle sizeWithAttributes:@{NSFontAttributeName:typeBtn.titleLabel.font}].width;
        
        CGFloat btnWidth = 0;
        
        if(width + 28 <= 49){
            
            btnWidth = 49;
        }else{
            
            btnWidth = width + 28;
        }
        [typeBtn setFrame:CGRectMake(btnX, btnY, btnWidth, 25)];
        
//        typeBtn.layer.masksToBounds = YES;
//        typeBtn.layer.cornerRadius = 25 / 2;
        
        btnX = btnX + btnWidth + 15;
        
        [self.scrollView addSubview:typeBtn];
    }
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(lwb_margin * 2);
        make.right.equalTo(self.mas_right).offset(-lwb_margin * 4);
        make.height.equalTo(@(self.lwb_height * 0.5));
        make.top.equalTo(self.mas_top).offset(lwb_smallMargin);
    }];
    
    [_edingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.right.equalTo(self.mas_right).offset(-lwb_margin);
        make.centerY.equalTo(self.titleLab.mas_centerY);
    }];
}
#pragma mark 页面视图
- (UIScrollView *)scrollView{
    
    if(_scrollView == nil){
        //     给本页面加载一个滚动视图
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.lwb_height * 0.5, self.lwb_width, self.lwb_height * 0.5)];
        
        _scrollView.backgroundColor = WHITECOLORA(1);
        // 自动分页
        //    scroll.pagingEnabled = YES;
        
        // 隐藏滚动条
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        
        _scrollView.delegate = self;
    }
    return _scrollView;
}
- (UILabel *)titleLab{
    
    if(_titleLab == nil){
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.text = @"康复辅具";
        _titleLab.textColor = textColour;
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.font = BoldFont(18);
    }
    return _titleLab;
}
- (UIButton *)edingBtn{
    
    if(_edingBtn == nil){
        
        _edingBtn = [[UIButton alloc]init];
        [_edingBtn setImage:[UIImage imageNamed:@"Arrow_Right"] forState:UIControlStateNormal];
        [_edingBtn addTarget:self action:@selector(omo_checkDeviceList) forControlEvents:UIControlEventTouchUpInside];
    }
    return _edingBtn;
}
- (void)omo_checkDeviceList{
    
    OMOAssistiveDevicesVC *assistiveDevicesVC = [[OMOAssistiveDevicesVC alloc]init];
    assistiveDevicesVC.items = _items;
    [[OMOIphoneManager getCurrentVC].navigationController pushViewController:assistiveDevicesVC animated:YES];
}
@end
