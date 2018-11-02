//
//  OMOMineShowCell.m
//  OMO_iphone
//
//  Created by wy on 2018/9/18.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOMineShowCell.h"

@interface OMOMineShowCell()

@property(strong,nonatomic)UIImageView *headImg;// 展示图
@property(strong,nonatomic)UILabel *titleLab;// 标题
@property(strong,nonatomic)UILabel *messgeLab;// 详情

@end

@implementation OMOMineShowCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        self.backgroundColor = WHITECOLORA(1);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self addSubview:self.headImg];
        [self addSubview:self.titleLab];
        [self addSubview:self.messgeLab];
    }
    return self;
}
- (void)setDataSouce:(NSDictionary *)dataSouce{
    
    _dataSouce = dataSouce;
    
    _headImg.image = [UIImage imageNamed:dataSouce[@"image"]];
    
    _titleLab.text = dataSouce[@"title"];
    
    [self setSubViewsFrame];
}
- (void)setSubViewsFrame{
    
    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(lwb_margin * 2);
        make.centerY.equalTo(self.mas_centerY);
        make.width.mas_equalTo(self.lwb_height * 0.5);
        make.height.mas_equalTo(self.lwb_height * 0.5);
    }];
    
    [_titleLab sizeToFit];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.headImg.mas_right).offset(lwb_margin);
    }];
    
    CGFloat width = [_messgeLab autoLblWidth];
    [_messgeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(width + lwb_margin * 2);
        make.height.mas_equalTo(self.lwb_height * 0.5);
        make.right.equalTo(self.mas_right).offset(-self.lwb_height);
        make.centerY.equalTo(self.mas_centerY);
    }];
}
- (UIImageView *)headImg{
    
    if(_headImg == nil){
        
        _headImg = [[UIImageView alloc]init];
        _headImg.contentMode = UIViewContentModeScaleToFill;
        
        __weak typeof(self) weakSelf = self;
        [_headImg sd_setImageWithURL:[NSURL URLWithString:[OMOIphoneManager sharedData].avatar_url] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
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
        _titleLab.text = [OMOIphoneManager sharedData].nickname;
        _titleLab.textColor = textColour;
        _titleLab.font = bigFont;
        _titleLab.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLab;
}
- (UILabel *)messgeLab{
    
    if(_messgeLab == nil){
        
        _messgeLab = [[UILabel alloc]init];
        _messgeLab.text = @"3";
        _messgeLab.backgroundColor = backColor;
        _messgeLab.layer.masksToBounds = YES;
        _messgeLab.layer.cornerRadius = self.lwb_height * 0.25;
        _messgeLab.textColor = WHITECOLORA(1);
        _messgeLab.font = defoultFont;
        _messgeLab.textAlignment = NSTextAlignmentCenter;
    }
    return _messgeLab;
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
