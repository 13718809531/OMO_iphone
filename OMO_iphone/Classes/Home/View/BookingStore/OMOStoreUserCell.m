//
//  OMOStoreUserCell.m
//  OMO_iphone
//
//  Created by wy on 2018/10/10.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOStoreUserCell.h"

@interface OMOStoreUserCell()

/** 服务经理 */
@property (nonatomic, strong)UILabel *storeUserNameLab;
/** 服务电话 */
@property (nonatomic, strong)UILabel *storeMobileLab;
/** 头像 */
@property (nonatomic, strong)UIImageView *storeUserHeadImg;
/** m描述 */
@property (nonatomic, strong)UILabel *descLab;

@end

@implementation OMOStoreUserCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = WHITECOLORA(1);
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENW, lwb_smallMargin)];
        lineView.backgroundColor = mainBackColor;
        [self addSubview:lineView];
        
        [self addSubview:self.storeUserNameLab];
        [self addSubview:self.storeMobileLab];
        [self addSubview:self.descLab];
    }
    return self;
}
- (void)setContacts:(NSString *)contacts{
    
    _contacts = contacts;
    
    _storeUserNameLab.text = [NSString stringWithFormat:@"服务经理:%@",contacts];
}
- (void)setMobile:(NSString *)mobile{
    
    _mobile = mobile;
    
    _storeMobileLab.text = [NSString stringWithFormat:@"联系电话:%@",mobile];
    
    [self setSubViewsFrame];
}
- (void)setSubViewsFrame{
    
    [_storeUserHeadImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(lwb_margin * 2);
        make.right.equalTo(self.mas_right).offset(-lwb_margin * 2);
        make.width.mas_equalTo(self.lwb_height - lwb_margin * 4);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-lwb_margin * 2);
    }];
    
    [_storeUserNameLab sizeToFit];
    [_storeUserNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(lwb_margin * 2);
        make.top.equalTo(self.mas_top).offset(lwb_margin * 2);
    }];
    
    [_storeMobileLab sizeToFit];
    [_storeMobileLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.storeUserNameLab.mas_bottom).offset(lwb_margin);
        make.left.equalTo(self.mas_left).offset(lwb_margin * 2);
    }];
    
    [_descLab sizeToFit];
    [_descLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-lwb_margin);
        make.left.equalTo(self.mas_left).offset(lwb_margin * 2);
    }];
}
- (UILabel *)storeUserNameLab{
    
    if(_storeUserNameLab == nil){
        
        _storeUserNameLab = [[UILabel alloc]init];
        _storeUserNameLab.font = Font(18);
        _storeUserNameLab.textColor = DetailColor;
        _storeUserNameLab.textAlignment = NSTextAlignmentLeft;
    }
    return _storeUserNameLab;
}
- (UILabel *)storeMobileLab{
    
    if(_storeMobileLab == nil){
        
        _storeMobileLab = [[UILabel alloc]init];
        _storeMobileLab.font = Font(18);
        _storeMobileLab.textColor = DetailColor;
        _storeMobileLab.textAlignment = NSTextAlignmentLeft;
    }
    return _storeMobileLab;
}
- (UILabel *)descLab{
    
    if(_descLab == nil){
        
        _descLab = [[UILabel alloc]init];
        _descLab.font = BoldFont(18);
        _descLab.textColor = textColour;
        _descLab.text = @"描述";
        _descLab.textAlignment = NSTextAlignmentLeft;
    }
    return _descLab;
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
