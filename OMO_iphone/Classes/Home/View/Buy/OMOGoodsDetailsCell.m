//
//  OMOGoodsDetailsCell.m
//  OMO_iphone
//
//  Created by wy on 2018/10/9.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOGoodsDetailsCell.h"
#import "OMOSelectGoodsNumView.h"

@interface OMOGoodsDetailsCell()<OMOSelectGoodsDelegate>

/**  */
@property (nonatomic, strong)UIButton *selectBtn;
/**  */
@property (nonatomic, strong)UILabel *goodsNameLab;
/**  */
@property (nonatomic, strong)UILabel *priceLab;
/**  */
@property (nonatomic, strong)OMOSelectGoodsNumView *goodsNumView;

@end

@implementation OMOGoodsDetailsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = mainBackColor;
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENW, 2)];
        lineView.backgroundColor = WHITECOLORA(1);
        [self addSubview:lineView];
        
        [self addSubview:self.selectBtn];
        [self addSubview:self.goodsNameLab];
        [self addSubview:self.priceLab];
        [self addSubview:self.goodsNumView];
    }
    return self;
}
- (void)setItemModel:(OMOKangFuBaoMtItemModel *)itemModel{
    
    _itemModel = itemModel;
    
    _goodsNameLab.text = itemModel.name;
    
    _priceLab.text = [NSString stringWithFormat:@"¥%@",itemModel.unit_price];
    
    _selectBtn.selected = itemModel.isSelect;
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.left.equalTo(self.mas_left).offset(lwb_margin * 2);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    CGFloat width = (self.lwb_width - lwb_margin * 9) / 3;
    [_goodsNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(width, self.lwb_height * 0.5));
        make.left.equalTo(self.selectBtn.mas_right).offset(lwb_smallMargin);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(width, self.lwb_height * 0.5));
        make.left.equalTo(self.goodsNameLab.mas_right).offset(lwb_smallMargin);
        make.centerY.equalTo(self.mas_centerY);
    }];
}
- (UIButton *)selectBtn{
    
    if(_selectBtn == nil){
        
        _selectBtn = [[UIButton alloc]init];
        [_selectBtn setImage:[UIImage imageNamed:@"Pay_Normal"] forState:UIControlStateNormal];
        [_selectBtn setImage:[UIImage imageNamed:@"Pay_Select"] forState:UIControlStateSelected];
        [_selectBtn addTarget:self action:@selector(omo_goodsSelect:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
}
- (UILabel *)goodsNameLab{
    
    if(_goodsNameLab == nil){
        
        _goodsNameLab = [[UILabel alloc]init];
        _goodsNameLab.textColor = textColour;
        _goodsNameLab.textAlignment = NSTextAlignmentLeft;
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
        
        _goodsNumView = [[OMOSelectGoodsNumView alloc]initWithFrame:CGRectMake(SCREENW - 120, 15, 100, 30)];
        _goodsNumView.delegate = self;
        _goodsNumView.minNum = 1;
        _goodsNumView.maxNum = 999999999;
    }
    return _goodsNumView;
}
#pragma mark ------ 商品选中 ----------
- (void)omo_goodsSelect:(UIButton *)sender{
    
    BOOL isSelect = sender.selected;
    sender.selected = !isSelect;
    
    if([self.delegate respondsToSelector:@selector(omo_goodsBuyWithGoodsId:Select:)]){
        
        [self.delegate omo_goodsBuyWithGoodsId:_itemModel.item_id Select:sender.selected];
    }
}
#pragma mark ------- 商品个数变化 --------
- (void)omo_selectGoodsNumberOftext:(NSString *)text{
    
    if([self.delegate respondsToSelector:@selector(omo_goodsBuyWithGoodsId:GoodsNum:)]){
        
        [self.delegate omo_goodsBuyWithGoodsId:_itemModel.item_id GoodsNum:text.integerValue];
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
