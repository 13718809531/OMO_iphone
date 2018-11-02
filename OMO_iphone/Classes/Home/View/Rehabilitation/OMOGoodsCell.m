//
//  OMOGoodsCell.m
//  OMO_iphone
//
//  Created by wy on 2018/10/13.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOGoodsCell.h"
#import "OMOSelectGoodsNumView.h"

@interface OMOGoodsCell()<OMOSelectGoodsDelegate>

/**  */
@property (nonatomic, strong)UIButton *selectBtn;
/**  */
@property (nonatomic, strong)UIImageView *goodsImg;
/**  */
@property (nonatomic, strong)UILabel *goodsNameLab;
/**  */
@property (nonatomic, strong)UILabel *priceLab;
/**  */
@property (nonatomic, strong)OMOSelectGoodsNumView *goodsNumView;

@end

@implementation OMOGoodsCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        [self addSubview:self.selectBtn];
        [self addSubview:self.goodsImg];
        [self addSubview:self.goodsNameLab];
        [self addSubview:self.priceLab];
        [self addSubview:self.goodsNumView];
    }
    return self;
}
- (UIButton *)selectBtn{
    
    if(_selectBtn == nil){
        
        _selectBtn = [[UIButton alloc]init];
        [_selectBtn setImage:[UIImage imageNamed:@"Risk_Normal"] forState:UIControlStateNormal];
        [_selectBtn setImage:[UIImage imageNamed:@"Risk_Select"] forState:UIControlStateSelected];
    }
    return _selectBtn;
}
- (UIImageView *)goodsImg{
    
    if(_goodsImg == nil){
        
        _goodsImg = [[UIImageView alloc]init];
        _goodsImg.clipsToBounds = YES;
        _goodsImg.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _goodsImg;
}
- (UILabel *)goodsNameLab{
    
    if(_goodsNameLab == nil){
        
        _goodsNameLab = [[UILabel alloc]init];
        _goodsNameLab.textColor = textColour;
        _goodsNameLab.textAlignment = NSTextAlignmentCenter;
        _goodsNameLab.font = bigFont;
    }
    return _goodsNameLab;
}
- (UILabel *)priceLab{
    
    if(_priceLab == nil){
        
        _priceLab = [[UILabel alloc]init];
        _priceLab.textColor = textColour;
        _priceLab.textAlignment = NSTextAlignmentCenter;
        _priceLab.font = bigFont;
    }
    return _priceLab;
}
- (OMOSelectGoodsNumView *)goodsNumView{
    
    if(_goodsNumView == nil){
        
        _goodsNumView = [[OMOSelectGoodsNumView alloc]init];
        _goodsNumView.minNum = 1;
        _goodsNumView.delegate = self;
    }
    return _goodsNumView;
}
#pragma mark --------- 选择商品数量 ---------
- (void)omo_selectGoodsNumberOftext:(NSString *)text{
    
    
}
@end
