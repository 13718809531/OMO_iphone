//
//  OMORemoteBookingDetailCell.m
//  OMO_iphone
//
//  Created by wy on 2018/10/22.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMORemoteBookingDetailCell.h"

@interface OMORemoteBookingDetailCell()

@property (nonatomic,strong)UILabel *titleLab;
/**  */
@property (nonatomic, strong)UIImageView *arrowImg;

@end

@implementation OMORemoteBookingDetailCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        [self addSubview:self.titleLab];
        [self addSubview:self.detailLab];
        [self addSubview:self.arrowImg];
        self.backgroundColor = WHITECOLORA(1);
    }
    return self;
}
- (void)setDict:(NSDictionary *)dict{
    
    _dict = dict;
    
    _titleLab.text = dict[@"title"];
    
    NSString *type = dict[@"type"];
    
    if([type isEqualToString:@"1"]){
        
        _arrowImg.image = [UIImage imageNamed:@"Arrow_Right"];
        _arrowImg.hidden = NO;
    }else{
        
        _arrowImg.image = [UIImage imageNamed:@""];
        _arrowImg.hidden = YES;
    }
}
- (void)setDetailText:(NSString *)detailText{
    
    _detailText = detailText;
    
    _detailLab.text = detailText;
    
    [self setSubViewsFrame];
}
- (UILabel *)titleLab{
    
    if(_titleLab == nil){
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = [UIFont systemFontOfSize:13];
        _titleLab.textColor = textColour;
        _titleLab.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLab;
}
- (UILabel *)detailLab{
    
    if(_detailLab == nil){
        
        _detailLab = [[UILabel alloc]init];
        _detailLab.font = [UIFont systemFontOfSize:13];
        _detailLab.textColor = [UIColor colorWithHexString:@"#979797"];
        _detailLab.textAlignment = NSTextAlignmentRight;
    }
    return _detailLab;
}
- (UIImageView *)arrowImg{
    
    if(_arrowImg == nil){
        
        _arrowImg = [[UIImageView alloc]init];
    }
    return _arrowImg;
}
- (void)setSubViewsFrame{
    
    [_detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.titleLab.mas_right).offset(lwb_margin * 2);
        make.right.equalTo(self.mas_right).offset(-lwb_margin * 4);
        make.height.equalTo(self.mas_height);
    }];
    
    [_titleLab sizeToFit];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(lwb_margin * 2);
    }];
    
    [_arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-lwb_margin);
    }];
}



@end
