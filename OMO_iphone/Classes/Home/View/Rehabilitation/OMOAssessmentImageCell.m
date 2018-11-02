//
//  OMOAssessmentImageCell.m
//  OMO_iphone
//
//  Created by wy on 2018/10/16.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOAssessmentImageCell.h"

@interface OMOAssessmentImageCell()

/** 背景图 */
@property (nonatomic, strong)UIImageView *backImg;
/**  */
@property (nonatomic, strong)UILabel *videoNameLab;
/**  */
@property (nonatomic, strong)UILabel *videoTimeLab;

@end

@implementation OMOAssessmentImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.backImg];
        [self addSubview:self.videoNameLab];
        [self addSubview:self.videoTimeLab];
    }
    return self;
}
- (void)setVideoModel:(OMOKangFuBaoVideoModel *)videoModel{
    
    _videoModel = videoModel;
    
    [_backImg sd_setImageWithURL:[NSURL URLWithString:videoModel.cover_img] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageRefreshCached];
    
    _videoNameLab.text = videoModel.question_name;
    
    _videoTimeLab.text = videoModel.options_name;
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [_backImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.width.equalTo(@(self.lwb_width / 3));
        make.bottom.equalTo(self.mas_bottom).offset(-lwb_smallMargin);
        make.top.equalTo(self.mas_top).offset(lwb_smallMargin);
    }];
    
    [_videoNameLab sizeToFit];
    [_videoNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backImg.mas_right).offset(lwb_margin);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top).offset(lwb_smallMargin);
    }];
    
    [_videoTimeLab sizeToFit];
    [_videoTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backImg.mas_right).offset(lwb_margin);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.videoNameLab.mas_bottom).offset(lwb_smallMargin);
    }];
}
- (UIImageView *)backImg{
    
    if(_backImg == nil){
        
        _backImg = [[UIImageView alloc]init];
        _backImg.clipsToBounds = YES;
        _backImg.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _backImg;
}
- (UILabel *)videoNameLab{
    
    if(_videoNameLab == nil){
        
        _videoNameLab = [[UILabel alloc]init];
        _videoNameLab.textColor = textColour;
        _videoNameLab.textAlignment = NSTextAlignmentLeft;
        _videoNameLab.font = Font(18);
        _videoNameLab.numberOfLines = 0;
    }
    return _videoNameLab;
}
- (UILabel *)videoTimeLab{
    
    if(_videoTimeLab == nil){
        
        _videoTimeLab = [[UILabel alloc]init];
        _videoTimeLab.textColor = DetailColor;
        _videoTimeLab.textAlignment = NSTextAlignmentLeft;
        _videoTimeLab.font = bigFont;
    }
    return _videoTimeLab;
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
