//
//  OMOMineHeadCell.m
//  OMO_iphone
//
//  Created by wy on 2018/9/17.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOMineHeadCell.h"

@interface OMOMineHeadCell()

@property(strong,nonatomic)UIImageView *headImg;// 展示图
@property(strong,nonatomic)UILabel *titleLab;// 标题
@property(strong,nonatomic)UILabel *editDetailLab;// 详情

@end

@implementation OMOMineHeadCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        self.backgroundColor = WHITECOLORA(1);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.headImg];
        [self addSubview:self.titleLab];
        [self addSubview:self.editDetailLab];
    }
    return self;
}
- (void)setDict:(NSDictionary *)dict{
    
    _dict = dict;
    
    __weak typeof(self) weakSelf = self;
    [_headImg sd_setImageWithURL:[NSURL URLWithString:dict[@"image"]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        if(image){
            
            weakSelf.headImg.image = [image circleImage];
        }else{
            
            UIImage *holderImage = [UIImage imageNamed:@"Placeholder_head"];
            weakSelf.headImg.image = [holderImage circleImage];
        }
    }];
    
    if([OMOIphoneManager sharedData].user_id.length > 0){
        
        _titleLab.text = [OMOIphoneManager sharedData].nickname;
    }else{
        
        _titleLab.text = @"";
    }
    _editDetailLab.text = dict[@"title"];
    
    [self setSubViwsFrame];
}
- (void)setSubViwsFrame{
    
    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(Between + lwb_margin * 2 + 20);
        make.width.mas_equalTo(100.f);
        make.height.mas_equalTo(100.f);
    }];

    [_titleLab sizeToFit];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {

        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.headImg.mas_bottom).offset(lwb_margin);
    }];

    [_editDetailLab sizeToFit];
    [_editDetailLab mas_makeConstraints:^(MASConstraintMaker *make) {

        make.bottom.equalTo(self.mas_bottom).offset(-lwb_margin * 2);
        make.centerX.equalTo(self.mas_centerX);
    }];
}
- (UIImageView *)headImg{
    
    if(_headImg == nil){
        
        _headImg = [[UIImageView alloc]init];
        _headImg.contentMode = UIViewContentModeScaleToFill;
    }
    return _headImg;
}
- (UILabel *)titleLab{
    
    if(_titleLab == nil){
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.textColor = textColour;
        _titleLab.font = bigFont;
        _titleLab.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLab;
}
- (UILabel *)editDetailLab{
    
    if(_editDetailLab == nil){
        
        _editDetailLab = [[UILabel alloc]init];
        _editDetailLab.textColor = DetailColor;
        _editDetailLab.font = bigFont;
        _editDetailLab.textAlignment = NSTextAlignmentCenter;
    }
    return _editDetailLab;
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
