//
//  OMOPingGuTiChooseView.m
//  OMO_iphone
//
//  Created by wy on 2018/9/28.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOPingGuTiChooseView.h"
#import "OMOPingGuTiChooseCell.h"
#import "OMOPingGuTiChooseImageCell.h"
/** 单选题 */
#import "OMOPingGuTiRedioCell.h"
/** 单选图片 */
#import "OMOPingGuTiRedioImageCell.h"

@interface OMOPingGuTiChooseView()
<UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)UILabel *titleLab;
@property (nonatomic, strong)UIImageView *titleImg;
@property (nonatomic, strong)NSArray <OMOPingGuTiOptionModel *> *dataSouce;
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)NSMutableArray *selectPingGuTiData;// 选中的题数据

@end

static NSString *OMOPingGuTiChooseCellID = @"OMOPingGuTiChooseCellID";
static NSString *OMOPingGuTiRedioCellID = @"OMOPingGuTiRedioCellID";
static NSString *OMOPingGuTiChooseImageCellID = @"OMOPingGuTiChooseImageCellID";
static NSString *OMOPingGuTiRedioImageCellID = @"OMOPingGuTiRedioImageCellID";

@implementation OMOPingGuTiChooseView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        [self addSubview:self.titleLab];
        [self addSubview:self.titleImg];
        [self addSubview:self.collectionView];
        
        _selectPingGuTiData = [NSMutableArray array];
    }
    return self;
}
- (void)setPingGuTiModel:(OMOPingGuTiModel *)pingGuTiModel{
    
    _pingGuTiModel = pingGuTiModel;
    
    NSString *type;
    
    if([pingGuTiModel.type isEqualToString:@"0"] || [pingGuTiModel.type isEqualToString:@"4"]){
        
        type = @"(单选题)";
    }else if ([pingGuTiModel.type isEqualToString:@"1"] || [pingGuTiModel.type isEqualToString:@"3"]){
        
        type = @"(多选题)";
    }
    
    NSString *text = [NSString stringWithFormat:@"%@ %@",pingGuTiModel.question_name,type];
    
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc]initWithString:text];
    NSRange range = [text rangeOfString:type];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:backColor range:range];
    _titleLab.attributedText = attributeStr;
    
    if(pingGuTiModel.image_url.length > 0){
        
        _titleImg.hidden = NO;
        [_titleImg sd_setImageWithURL:[NSURL URLWithString:pingGuTiModel.image_url] placeholderImage:[UIImage imageNamed:@""]];
    }else{
        
        _titleImg.hidden = YES;
    }
    
    _dataSouce = pingGuTiModel.options;
    
    [_collectionView reloadData];
}
- (UILabel *)titleLab{
    
    if(_titleLab == nil){
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = Font(20);
        _titleLab.textColor = TextColor;
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.numberOfLines = 0;
    }
    return _titleLab;
}
- (UIImageView *)titleImg{
    
    if(_titleImg == nil){
        
        _titleImg = [[UIImageView alloc]init];
    }
    return _titleImg;
}
- (UICollectionView *)collectionView{
    if(_collectionView == nil){
        
        UICollectionViewFlowLayout *collectionLayout = [[UICollectionViewFlowLayout alloc]init];
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(50, 50, SCREENW - 100, self.lwb_height - 100) collectionViewLayout:collectionLayout];
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        //自适应大小
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        
        // 允许多选
        _collectionView.allowsMultipleSelection = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        //        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;// 默认为YES。如果该属性为YES，视图滚动时可以越过边界，越过边界后会被弹回。
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.alwaysBounceHorizontal = YES;
        
        [_collectionView registerClass:[OMOPingGuTiChooseCell class] forCellWithReuseIdentifier:OMOPingGuTiChooseCellID];
        [_collectionView registerClass:[OMOPingGuTiRedioCell class] forCellWithReuseIdentifier:OMOPingGuTiRedioCellID];
        [_collectionView registerClass:[OMOPingGuTiChooseImageCell class] forCellWithReuseIdentifier:OMOPingGuTiChooseImageCellID];
        [_collectionView registerClass:[OMOPingGuTiRedioImageCell class] forCellWithReuseIdentifier:OMOPingGuTiRedioImageCellID];
    }
    return _collectionView;
}

// 分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}
// 行数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _dataSouce.count;
}
// cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if([_pingGuTiModel.type isEqualToString:@"3"]){
        
        
        OMOPingGuTiChooseImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:OMOPingGuTiChooseImageCellID forIndexPath:indexPath];
        
        cell.optionModel = _dataSouce[indexPath.row];
        
        return cell;
    }else if ([_pingGuTiModel.type isEqualToString:@"4"]){
        
        OMOPingGuTiRedioImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:OMOPingGuTiRedioImageCellID forIndexPath:indexPath];
        
        cell.optionModel = _dataSouce[indexPath.row];
        
        return cell;
    }else if([_pingGuTiModel.type isEqualToString:@"0"]){
            
        OMOPingGuTiRedioCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:OMOPingGuTiRedioCellID forIndexPath:indexPath];
        
        cell.optionModel = _dataSouce[indexPath.row];
        
        return cell;
    }else{
        
        OMOPingGuTiChooseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:OMOPingGuTiChooseCellID forIndexPath:indexPath];
        
        cell.optionModel = _dataSouce[indexPath.row];
        
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    OMOPingGuTiOptionModel *optionModel = _dataSouce[indexPath.row];
    
    if([_pingGuTiModel.type isEqualToString:@"0"] || [_pingGuTiModel.type isEqualToString:@"4"]){
        
        if(optionModel.isSelect)return;
        
        for (NSInteger i = 0; i < _dataSouce.count; i ++) {
            
            OMOPingGuTiOptionModel *optionModel = _dataSouce[i];
            
            if(i == indexPath.row){
                
                optionModel.isSelect = YES;
            }else{
                
                optionModel.isSelect = NO;
            }
        }
        NSDictionary *dict = @{@"value":optionModel.value,@"name":optionModel.name};
        
        [_selectPingGuTiData removeAllObjects];
        [_selectPingGuTiData addObject:dict];
        
    }else if([_pingGuTiModel.type isEqualToString:@"1"] || [_pingGuTiModel.type isEqualToString:@"3"]){
        
        if(_pingGuTiModel.contradictOptRules.count > 0){
            
            NSMutableArray *newArray = [NSMutableArray array];
            
            for (NSDictionary *dict in _selectPingGuTiData) {
                
                [newArray addObject:dict[@"value"]];
            }
            [newArray addObject:optionModel.value];
            
            NSArray *allSelectArray = [newArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                if ([obj1 integerValue] > [obj2 integerValue]){
                    
                    return NSOrderedDescending;
                }else{
                    
                    return NSOrderedAscending;
                }
            }];
            
            NSString *newStr = [allSelectArray componentsJoinedByString:@","];
            
            if([_pingGuTiModel.contradictOptRules containsObject:newStr])return;
        }
        BOOL isSelect = optionModel.isSelect;
        optionModel.isSelect = !isSelect;
        
        if(optionModel.isSelect){
            
            NSDictionary *dict = @{@"value":optionModel.value,@"name":optionModel.name};
            [_selectPingGuTiData addObject:dict];
        }else{
            
            NSArray *newArray = [NSArray arrayWithArray:_selectPingGuTiData];
            
            for (NSDictionary *dict in newArray) {
                
                if([dict[@"value"] isEqualToString:optionModel.value]){
                    
                    [_selectPingGuTiData removeObject:dict];
                }
            }
        }
    }
    [self.collectionView reloadData];
    
    if([self.delegate respondsToSelector:@selector(omo_pingGuTiSelectFromArray:)]){
        
        [self.delegate omo_pingGuTiSelectFromArray:_selectPingGuTiData];
    }
}
// iteam大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    OMOPingGuTiOptionModel *optionModel = _dataSouce[indexPath.row];
    
    if([_pingGuTiModel.type isEqualToString:@"0"] || [_pingGuTiModel.type isEqualToString:@"1"]){
        
        return CGSizeMake(collectionView.lwb_width, optionModel.height);
    }else{
        
        return CGSizeMake(collectionView.lwb_width, optionModel.imageHeight + SCREENW * 0.5);
    }
}

// 分区间隔
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake( 0, 0, 0, 0);
}

// 行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return lwb_margin;
}
// 列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    //此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    CGFloat height = [_titleLab getLabelHightOfLineSpacing:4.0 Kern:1.0];
    
    if(height + 30 > 50.f){
        
        height += 30;
    }else{
        
        height = 50;
    }
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(lwb_margin * 2);
        make.top.equalTo(self.mas_top).offset(lwb_margin);
        make.right.equalTo(self.mas_right).offset(-lwb_margin * 2);
        make.height.equalTo(@(height + 30));
    }];
    
    [_titleImg sizeToFit];
    [_titleImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.mas_right).offset(-lwb_margin * 2);
        make.centerY.equalTo(self.titleLab.mas_centerY);
    }];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(lwb_margin * 2);
        make.top.equalTo(self.titleLab.mas_bottom).offset(lwb_margin);
        make.right.equalTo(self.mas_right).offset(-lwb_margin * 2);
        make.bottom.equalTo(self.mas_bottom).offset(-lwb_margin);
    }];
}
@end
