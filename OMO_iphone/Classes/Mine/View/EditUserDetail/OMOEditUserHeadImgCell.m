//
//  OMOEditUserHeadImgCell.m
//  OMO_iphone
//
//  Created by wy on 2018/9/19.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOEditUserHeadImgCell.h"
#import <SDWebImage/UIButton+WebCache.h>

@interface OMOEditUserHeadImgCell()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property(strong,nonatomic)UIButton *headImgBtn;// 展示图
@property(strong,nonatomic)UILabel *titleLab;// 标题

@end

@implementation OMOEditUserHeadImgCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        [self addSubview:self.headImgBtn];
        [self addSubview:self.titleLab];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = WHITECOLORA(1);
    }
    return self;
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [_headImgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.mas_right).offset(-40);
        make.centerY.equalTo(self.mas_centerY);
        make.height.equalTo(@(self.lwb_height - lwb_margin * 4));
        make.width.equalTo(@(self.lwb_height - lwb_margin * 4));
    }];
    
    [_titleLab sizeToFit];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(lwb_margin);
        make.centerY.equalTo(self.mas_centerY);
    }];
}
- (UIButton *)headImgBtn{
    
    if(_headImgBtn == nil){
        
        _headImgBtn = [[UIButton alloc]init];
        
        NSString *avatar_url = [OMOIphoneManager sharedData].avatar_url;
        
        UIImage *placeholderImage = [UIImage imageNamed:@"Placeholder_head"];
        UIImage *circleImage = [placeholderImage circleImage];
        if(avatar_url.length > 0){
            
            __weak typeof(self) weakSelf = self;
            
            [_headImgBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:avatar_url] forState:UIControlStateNormal completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                
                if(image){
                    
                    [weakSelf.headImgBtn setBackgroundImage:[image circleImage] forState:UIControlStateNormal];
                }else{
                    
                    [weakSelf.headImgBtn setBackgroundImage:circleImage forState:UIControlStateNormal];
                }
            }];
        }else{
            
            [_headImgBtn setBackgroundImage:circleImage forState:UIControlStateNormal];
        }
    
        [_headImgBtn addTarget:self action:@selector(omo_replaceHeadImage) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headImgBtn;
}
- (UILabel *)titleLab{
    
    if(_titleLab == nil){
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.text = @"更换头像";
        _titleLab.textColor = textColour;
        _titleLab.font = bigFont;
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}

#pragma mark -------- 更换头像 ----------
- (void)omo_replaceHeadImage{
    
    //初始化提示框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //按钮：从相册选择，类型：UIAlertActionStyleDefault
    [alert addAction:[UIAlertAction actionWithTitle:@"从相册选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //初始化UIImagePickerController
        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
        //获取方式1：通过相册（呈现全部相册），UIImagePickerControllerSourceTypePhotoLibrary
        //获取方式2，通过相机，UIImagePickerControllerSourceTypeCamera
        //获取方方式3，通过相册（呈现全部图片），UIImagePickerControllerSourceTypeSavedPhotosAlbum
        PickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;//方式1
        //允许编辑，即放大裁剪
        PickerImage.allowsEditing = YES;
        //自代理
        PickerImage.delegate = self;
        //页面跳转
        [[OMOIphoneManager getCurrentVC] presentViewController:PickerImage animated:YES completion:nil];
    }]];
    //按钮：拍照，类型：UIAlertActionStyleDefault
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //初始化UIImagePickerController
        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
        //获取方式1：通过相册（呈现全部相册），UIImagePickerControllerSourceTypePhotoLibrary
        //获取方式2，通过相机，UIImagePickerControllerSourceTypeCamera
        //获取方方式3，通过相册（呈现全部图片），UIImagePickerControllerSourceTypeSavedPhotosAlbum
        PickerImage.sourceType = UIImagePickerControllerSourceTypeCamera;//方式2
        //允许编辑，即放大裁剪
        PickerImage.allowsEditing = YES;
        //自代理
        PickerImage.delegate = self;
        //页面跳转
        [[OMOIphoneManager getCurrentVC] presentViewController:PickerImage animated:YES completion:nil];
    }]];
    //按钮：取消，类型：UIAlertActionStyleCancel
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [[OMOIphoneManager getCurrentVC] presentViewController:alert animated:YES completion:nil];
}
// PickerImage完成后的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //定义一个newPhoto，用来存放我们选择的图片。
    UIImage *newPhoto = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    //关闭当前界面，即回到主界面去
    [[OMOIphoneManager getCurrentVC] dismissViewControllerAnimated:YES completion:nil];
    
    [self yh_replaceHeadImageWithImage:newPhoto];
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([UIDevice currentDevice].systemVersion.floatValue < 11) {
        return;
    }
    if ([viewController isKindOfClass:NSClassFromString(@"PUPhotoPickerHostViewController")]) {
        [viewController.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.frame.size.width < 42) {
                [viewController.view sendSubviewToBack:obj];
                *stop = YES;
            }
        }];
    }
}
#pragma mark ------- 更换头像 -------
- (void)yh_replaceHeadImageWithImage:(UIImage *)image{
    
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval time = [date timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%0.f", time];//转为字符型 ;
    
    NSString *key = [NSString stringWithFormat:@"%@%@.png",[OMOIphoneManager sharedData].mobile,timeString];
    
    __weak typeof(self) weakSelf = self;
    [[OMONetworkManager sharedData] omo_putImage:image key:key success:^(id result) {
        
        if(result){
            
            NSDictionary *user = (NSDictionary *)result;
            [OMOIphoneManager initWithDictionary:user];
            
            OMOIphoneManager *manager = [OMOIphoneManager sharedData];
            
            NSString *avatar_url = manager.avatar_url;
            [weakSelf.headImgBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:avatar_url] forState:UIControlStateNormal completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                
                if(image){
                    
                    [weakSelf.headImgBtn setBackgroundImage:[image circleImage] forState:UIControlStateNormal];
                }else{
                    
                    [weakSelf.headImgBtn setBackgroundImage:[UIImage imageNamed:@"Placeholder_head"] forState:UIControlStateNormal];
                }
            }];
        }
    } failure:^(NSError *error) {
        
        
    }];
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
