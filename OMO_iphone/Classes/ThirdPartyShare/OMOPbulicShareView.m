//
//  OMOPbulicShareView.m
//  OMO_iphone
//
//  Created by wy on 2018/10/10.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOPbulicShareView.h"
#import "OMOShareCollectionViewCell.h"
#import "OMOShareHeadView.h"
#import "OMOShareFootView.h"
#import "WTShareManager.h"// 分享
#import "WTShareContentItem.h" // 分享模型

@interface OMOPbulicShareView()
<UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout,
UICollectionViewDataSourcePrefetching>

@property (nonatomic,strong)UIButton * backButton;// 背部
@property(strong,nonatomic)UICollectionView *collectionView;// 展示视图
@property(strong,nonatomic)NSArray *array;

@end

static NSString *OMOShareCollectionViewCellID = @"OMOShareCollectionViewCellID";
static NSString *OMOShareHeadViewID = @"OMOShareHeadViewID";
static NSString *YHShareCollectionReusableFootViewID = @"OMOShareFootViewID";

@implementation OMOPbulicShareView

- (instancetype)init{
    
    if(self = [super init]){
        
        NSDictionary *dict1 = @{@"title":@"微信",@"image":@"icon_xq_fx_weixin"};
        NSDictionary *dict2 = @{@"title":@"朋友圈",@"image":@"icon_xq_fx_pingyq"};
        NSDictionary *dict3 = @{@"title":@"生成长图",@"image":@"icon_xq_fx_changtu"};
        
        self.frame = CGRectMake(0, 0, SCREENW, SCREENH);
        self.backgroundColor = [UIColor redColor];
        
        self.array = [NSArray arrayWithObjects:dict1,dict2,dict3, nil];
        
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.backButton];
        [self addSubview:self.collectionView];
    }
    return self;
}
- (void)show
{
    [[OMOIphoneManager getCurrentVC].view addSubview:self];
    
    //动画
    [UIView animateWithDuration:0.25 animations:^{
        
        self.backButton.alpha = 0.5;
        self.collectionView.lwb_bottom = SCREENH;
    }];
}
- (void)dissMiss{
    
    //动画
    [UIView animateWithDuration:0.25 animations:^{
        self.collectionView.lwb_y = SCREENH;
        self.backButton.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
#pragma mark - 懒加载
-(UIButton *)backButton
{
    if (!_backButton) {
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = self.bounds;
        button.backgroundColor = [UIColor clearColor];
        button.alpha = 0.4;
        [button addTarget:self action:@selector(dissMiss) forControlEvents:UIControlEventTouchUpInside];
        _backButton = button;
    }return _backButton;
}
- (UICollectionView *)collectionView{
    if(_collectionView == nil){
        
        UICollectionViewFlowLayout *collectionLayout = [[UICollectionViewFlowLayout alloc]init];
        
        //        collectionLayout.scrollDirection = UICollectionViewScrollPositionCenteredVertically;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, SCREENH, self.lwb_width, IFFitFloat6(280)) collectionViewLayout:collectionLayout];
        
        _collectionView.scrollEnabled = NO;
        //自适应大小
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        
        //        if ([UIDevice currentDevice].systemVersion.floatValue >= 10.0) {
        //
        //            _collectionView.prefetchDataSource = self;
        //
        //            _collectionView.prefetchingEnabled = YES;
        //        }
        
        _collectionView.backgroundColor = WHITECOLORA(1);
        // 允许多选
        _collectionView.allowsMultipleSelection = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;// 默认为YES。如果该属性为YES，视图滚动时可以越过边界，越过边界后会被弹回。
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.alwaysBounceHorizontal = YES;
        //        _collectionView.
        
        // 头部图
        [_collectionView registerClass:[OMOShareHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:OMOShareHeadViewID];
        
        // 尾视图
        [_collectionView registerClass:[OMOShareFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:YHShareCollectionReusableFootViewID];
        //
        // 第一分区cell
        [_collectionView registerClass:[OMOShareCollectionViewCell class] forCellWithReuseIdentifier:OMOShareCollectionViewCellID];
    }
    return _collectionView;
}
- (void)setShareModel:(OMOShareModel *)shareModel{
    
    _shareModel = shareModel;
    [self.collectionView reloadData];
}
// 分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}
// 行数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.array.count;
}
// cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    OMOShareCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:OMOShareCollectionViewCellID forIndexPath:indexPath];
    
    if(cell == nil){
        
        cell = [[OMOShareCollectionViewCell alloc]initWithFrame:CGRectMake(0, 0, collectionView.lwb_width / 4, collectionView.lwb_width / 4)];
    }
    
    cell.dict = self.array[indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    WTShareContentItem *item = [WTShareContentItem shareWTShareContentItem];
    item.title = @"来自........的分享";
    
//    UIImage *thumbImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_shareModel.image]]];
    
    UIImage *thumbImage = [UIImage imageNamed:@"Placeholder_head"];
    NSData *data = [self compressWithImage:thumbImage MaxLength:30];
    item.thumbImage = [UIImage imageWithData:data];
    
//    UIImage *bigImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_shareModel.poster]]];
    
//    item.bigImage = [OMOIphoneManager imageCompressToData:bigImage];
    item.bigImage = thumbImage;
    
    __block BOOL success;
    
    if(indexPath.row == 0){
        
        [WTShareManager wt_shareWithContent:item shareType:WTShareTypeWeiXinSession shareResult:^(NSString *shareResult) {
            
            if([shareResult isEqualToString:@"1"]){
                
                [MBProgress showInfoMessage:@"微信--分享成功"];
                success = YES;
            }else{
                
                [MBProgress showInfoMessage:@"微信--取消分享"];
                success = NO;
            }
            if(self.shareBlock){
                
                self.shareBlock(success);
            }
        }];
    }else if (indexPath.row == 1){
        
        [WTShareManager wt_shareWithContent:item shareType:WTShareTypeWeiXinTimeline shareResult:^(NSString *shareResult) {
            
            if([shareResult isEqualToString:@"1"]){
                
                [MBProgress showInfoMessage:@"朋友圈--分享成功"];
                success = YES;
            }else{
                
                [MBProgress showInfoMessage:@"朋友圈--取消分享"];
                success = NO;
            }
            if(self.shareBlock){
                
                self.shareBlock(success);
            }
        }];
    }else if(indexPath.row == 2){
        
        [self loadImageFinished:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_shareModel.poster]]]];
    }
}

//创建头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    
    if(kind == UICollectionElementKindSectionHeader){
        OMOShareHeadView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
            withReuseIdentifier:OMOShareHeadViewID
            forIndexPath:indexPath];
        
        headView.makePrice = [NSString stringWithFormat:@"%.2f",10.f];
        return headView;
    }else if (kind == UICollectionElementKindSectionFooter){
        
        OMOShareFootView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                                                                         withReuseIdentifier:YHShareCollectionReusableFootViewID
                                                                                                forIndexPath:indexPath];
        
        footView.clooseBlock = ^{
            
            __weak typeof(self) weakSelf = self;
            
            [weakSelf dissMiss];
        };
        return footView;
    }
    return nil;
}
// iteam大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((collectionView.lwb_width - lwb_margin * 2) / 3, (collectionView.lwb_width - lwb_margin * 2) / 3);
}
// 分区头视图高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
        
    return CGSizeMake(collectionView.lwb_width, 108);
}
// 分区尾视图高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    return CGSizeMake(collectionView.lwb_width, 60);
}
// 分区间隔
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake( 0, lwb_margin, 0, lwb_margin);
}

// 行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}
// 列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}
#pragma mark ----------- 生成长图 ---------
- (void)loadImageFinished:(UIImage *)image
{
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
}
#pragma mark ------- 保存到相册 -------------
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    if(error){
        
        [MBProgress showInfomationWithMessage:@"保存失败" duration:1.5];
    }else{
        
        [MBProgress showInfomationWithMessage:@"保存成功" duration:1.5];
    }
}
- (NSData *)compressWithImage:(UIImage *)image  MaxLength:(NSUInteger)maxLength{ // Compress by quality
    
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    //NSLog(@"Before compressing quality, image size = %ld KB",data.length/1024);
    
    if (data.length < maxLength) return data;
    
    CGFloat max = 1;
    CGFloat min = 0;
    
    for (int i = 0; i < 6; ++i) {
        
        compression = (max + min) / 2;
        
        data = UIImageJPEGRepresentation(image, compression);
        
        //NSLog(@"Compression = %.1f", compression);
        //NSLog(@"In compressing quality loop, image size = %ld KB", data.length / 1024);
        
        if (data.length < maxLength * 0.9) {
            
            min = compression;
        } else if (data.length > maxLength) {
            
            max = compression;
            
        } else {
            break;
            
        }
    } //NSLog(@"After compressing quality, image size = %ld KB", data.length / 1024);
    
    if (data.length < maxLength) return data; UIImage *resultImage = [UIImage imageWithData:data];
    // Compress by size
    NSUInteger lastDataLength = 0;
    
    while (data.length > maxLength && data.length != lastDataLength) {
        
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        //NSLog(@"Ratio = %.1f", ratio);
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)), (NSUInteger)(resultImage.size.height * sqrtf(ratio)));
        // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
        //NSLog(@"In compressing size loop, image size = %ld KB", data.length / 1024);
        
    } //NSLog(@"After compressing size loop, image size = %ld KB", data.length / 1024);
    return data;
}
@end
