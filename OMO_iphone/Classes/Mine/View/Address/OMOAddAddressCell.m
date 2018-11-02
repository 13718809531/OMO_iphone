//
//  OMOAddAddressCell.m
//  OMO_iphone
//
//  Created by wy on 2018/10/11.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOAddAddressCell.h"

@interface OMOAddAddressCell()<UITextFieldDelegate>

/**  */
@property (nonatomic, strong)UIView *backView;
/**  */
@property (nonatomic, strong)UILabel *titleLab;

@end

@implementation OMOAddAddressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = mainBackColor;
        [self addSubview:self.backView];
        [self addSubview:self.titleLab];
        [self addSubview:self.detailTfd];
    }
    return self;
}
- (void)setDict:(NSDictionary *)dict{
    
    _dict = dict;
    
    _titleLab.text = dict[@"title"];
    _detailTfd.placeholder = dict[@"placeholder"];
    _detailTfd.text = dict[@"detail"];
    
    if([dict[@"type"] isEqualToString:@"mobile"]){
        
        _detailTfd.keyboardType = UIKeyboardTypeNumberPad;
    }
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mas_top).offset(lwb_smallMargin);
        make.left.mas_equalTo(self.mas_left);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.right.mas_equalTo(self.mas_right);
    }];
    
    [_titleLab sizeToFit];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.backView.mas_centerY);
        make.left.equalTo(self.mas_left).offset(lwb_margin * 2);
    }];
    
    [_detailTfd mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.mas_right).offset(-lwb_margin * 2);
        make.left.equalTo(self.titleLab.mas_right).offset(lwb_margin);
        make.height.mas_equalTo(@30);
        make.centerY.mas_equalTo(self.backView.mas_centerY);
    }];
}
- (UIView *)backView{
    
    if(_backView == nil){
        
        _backView = [[UIView alloc]init];
        _backView.backgroundColor = WHITECOLORA(1);
        [_backView addSubview:self.titleLab];
        [_backView addSubview:self.detailTfd];
    }
    return _backView;
}
- (UILabel *)titleLab{
    
    if(_titleLab == nil){
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.textColor = textColour;
        _titleLab.font = navTitleFont;
        _titleLab.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLab;
}
- (UITextField *)detailTfd{
    
    if(_detailTfd == nil){
        
        _detailTfd = [[UITextField alloc]init];
        _detailTfd.textColor = textColour;
        _detailTfd.textAlignment = NSTextAlignmentLeft;
        [_detailTfd addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _detailTfd;
}
#pragma mark ------- 判断输入位数 -------
- (void)textFieldDidChange:(UITextField *)textField
{
    if([_dict[@"type"] isEqualToString:@"name"]){
        
        if (textField.text.length > 15) {
            
            textField.text = [textField.text substringToIndex:15];
        }
    }
    
    if([_dict[@"type"] isEqualToString:@"mobile"]){
        
        if (textField.text.length > 11) {
            
            textField.text = [textField.text substringToIndex:11];
        }
    }
    
    if([_dict[@"type"] isEqualToString:@"detail"]){
        
        if (textField.text.length > 60) {
            
            textField.text = [textField.text substringToIndex:60];
        }
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
