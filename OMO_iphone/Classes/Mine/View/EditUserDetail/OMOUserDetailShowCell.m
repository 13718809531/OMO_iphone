//
//  OMOUserDetailShowCell.m
//  OMO_iphone
//
//  Created by wy on 2018/9/19.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOUserDetailShowCell.h"

@interface OMOUserDetailShowCell()

@property(strong,nonatomic)UILabel *titleLab;// 标题
@property(strong,nonatomic)UILabel *detailLab;// 详情

@end

@implementation OMOUserDetailShowCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        self.backgroundColor = WHITECOLORA(1);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.titleLab];
        [self addSubview:self.detailLab];
    }
    return self;
}
- (void)setType:(NSString *)type{
    
    _type = type;
    
    if([type isEqualToString:@"nickname"]){
        
        _titleLab.text = @"昵称";
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        if([OMOIphoneManager sharedData].realname.length > 0){
            
            _detailLab.text = [OMOIphoneManager sharedData].realname;
        }else{
            
            _detailLab.text = [OMOIphoneManager sharedData].nickname;
        }
    }else if([type isEqualToString:@"gender"]){
        
        _titleLab.text = @"性别";
        _detailLab.text = [OMOIphoneManager sharedData].gender;
    }else if([type isEqualToString:@"height"]){
        
        _titleLab.text = @"身高";
        NSString *height = [OMOIphoneManager sharedData].height;
        
        if([height integerValue] > 0){
            
            _detailLab.text = [NSString stringWithFormat:@"%@cm",height];
        }else{
            
            _detailLab.text = @"";
        }
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if([type isEqualToString:@"weight"]){
        
        _titleLab.text = @"体重";
        NSString *weight = [OMOIphoneManager sharedData].weight;
        
        if([weight integerValue] > 0){
            
            _detailLab.text = [NSString stringWithFormat:@"%@kg",weight];
        }else{
            
            _detailLab.text = @"";
        }
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if([type isEqualToString:@"birthday"]){
        
        _titleLab.text = @"出生日期";
        _detailLab.text = [OMOIphoneManager sharedData].birthday;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if([type isEqualToString:@"mobile"]){
        
        _titleLab.text = @"手机号";
        _detailLab.text = [OMOIphoneManager sharedData].mobile;
    }
     
    [self setSubViewsFrame];
}
- (void)setSubViewsFrame{
    
    [_titleLab sizeToFit];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(lwb_margin);
    }];

    [_detailLab sizeToFit];
    [_detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.mas_right).offset(-40);
        make.centerY.equalTo(self.mas_centerY);
    }];
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
- (UILabel *)detailLab{
    
    if(_detailLab == nil){
        
        _detailLab = [[UILabel alloc]init];
        _detailLab.textColor = textColour;
        _detailLab.font = bigFont;
        _detailLab.textAlignment = NSTextAlignmentRight;
    }
    return _detailLab;
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
