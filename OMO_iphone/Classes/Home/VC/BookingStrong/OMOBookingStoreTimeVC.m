//
//  OMOBookingStrongTimeVC.m
//  OMO_iphone
//
//  Created by wy on 2018/10/9.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOBookingStoreTimeVC.h"
#import "OMOBookingStrongWeekCell.h"
#import "OMORemoteBookingDateStateCell.h"

@interface OMOBookingStoreTimeVC()
<
UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout
>

/**  */
@property (nonatomic, strong)NSArray *timeList;

@property(strong,nonatomic)UICollectionView *collectionView;
@property(strong,nonatomic)NSArray <OMOStoreTimeModel *> *dataSouce;
/** 选中的星期 */
@property (nonatomic,copy)NSString *selectWeek;
/** 选中的时间 */
@property (nonatomic,copy)NSString *selectTime;
/** 立即预约 */
@property (nonatomic, strong)UIButton *enterBtn;

@end

static NSString *OMOBookingStrongWeekCellID = @"OMOBookingStrongWeekCellID";
static NSString *OMORemoteBookingDateStateCellID = @"OMORemoteBookingDateStateCellID";

@implementation OMOBookingStoreTimeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatBar];
    [self.bar addLeftButtonWithImage:[UIImage imageNamed:@"App_Back"]];
    [self.bar addTitltLabelWithText:@"预约时间" Font:navTitleFont];
    
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.enterBtn];
}
- (void)setStoreModel:(OMOStoreModel *)storeModel{
    
    _storeModel = storeModel;
    
    for (int i = 0; i < storeModel.time.count; i ++) {
        
        OMOStoreWeekModel *weekModel = storeModel.time[i];
        
        if(i == 0){
            
            weekModel.isSelect = YES;
            _selectWeek = weekModel.time;
            _dataSouce = weekModel.list;
            [_collectionView reloadData];
            return;
        }
    }
}
- (UIButton *)enterBtn{
    
    if(_enterBtn == nil){
        
        _enterBtn = [[UIButton alloc]init];
        _enterBtn.lwb_x = IFFitFloat6(lwb_pblicX);
        _enterBtn.lwb_width = SCREENW - IFFitFloat6(lwb_pblicX) * 2;
        _enterBtn.lwb_height = 40.f;
        _enterBtn.lwb_bottom = SCREENH - IFFitFloat6(30) - Between;
        _enterBtn.backgroundColor = backColor;
        [_enterBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_enterBtn setTitleColor:WHITECOLORA(1) forState:UIControlStateNormal];
        _enterBtn.titleLabel.font = Font(18);
        _enterBtn.layer.masksToBounds = YES;
        _enterBtn.layer.cornerRadius = 20.f;
        [_enterBtn addTarget:self action:@selector(omo_bookingStoreEnterTime) forControlEvents:UIControlEventTouchUpInside];
    }
    return _enterBtn;
}
- (UICollectionView *)collectionView{
    if(_collectionView == nil){
        
        UICollectionViewFlowLayout *collectionLayout = [[UICollectionViewFlowLayout alloc]init];
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(lwb_margin * 2, IphoneY + lwb_margin * 2, SCREENW - lwb_margin * 4, SCREENH - lwb_margin * 4 - Between - IphoneY) collectionViewLayout:collectionLayout];
        
        _collectionView.backgroundColor = WHITECOLORA(1);
        _collectionView.scrollEnabled = NO;
        //自适应大小
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        
        // 允许多选
        _collectionView.allowsMultipleSelection = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = NO;
        _collectionView.bounces = YES;// 默认为YES。如果该属性为YES，视图滚动时可以越过边界，越过边界后会被弹回。
        _collectionView.alwaysBounceVertical = YES;
        //        _collectionView.alwaysBounceHorizontal = YES;
        
        [_collectionView registerClass:[OMOBookingStrongWeekCell class] forCellWithReuseIdentifier:OMOBookingStrongWeekCellID];
        [_collectionView registerClass:[OMORemoteBookingDateStateCell class] forCellWithReuseIdentifier:OMORemoteBookingDateStateCellID];
    }
    return _collectionView;
}

// 分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 2;
}
// 行数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if(section == 0){
        
        return _storeModel.time.count;
    }
    return _dataSouce.count;
}
// cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0){
        
        OMOBookingStrongWeekCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:OMOBookingStrongWeekCellID forIndexPath:indexPath];
        
        cell.weekModel = _storeModel.time[indexPath.row];
        
        return cell;
    }else{
        
        OMORemoteBookingDateStateCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:OMORemoteBookingDateStateCellID forIndexPath:indexPath];
        
        cell.timeModel = _dataSouce[indexPath.row];
        
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0){
        
        OMOStoreWeekModel *selectWeekModel = _storeModel.time[indexPath.row];
        
        if(selectWeekModel.isSelect)return;
        
        for (OMOStoreWeekModel *weekModel in _storeModel.time) {
            
            weekModel.isSelect = NO;
        }
    
        selectWeekModel.isSelect = YES;
        _selectWeek = selectWeekModel.time;
        _dataSouce = selectWeekModel.list;
        _selectTime = nil;
        
        for (OMOStoreTimeModel *timeModel in _dataSouce) {
            
            timeModel.isSelect = NO;
        }
    }else{
        
        OMOStoreTimeModel *selectTimeModel = _dataSouce[indexPath.row];
        
        if(selectTimeModel.isSelect)return;
        
        if(selectTimeModel.status){
            
            for (OMOStoreTimeModel *timeModel in _dataSouce) {
                
                timeModel.isSelect = NO;
            }
            selectTimeModel.isSelect = YES;
            _selectTime = selectTimeModel.time;
        }else{
            
            return;
        }
    }
    [collectionView reloadData];
}
// iteam大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat width = (collectionView.lwb_width - 6 * 2) * 0.2;
    return CGSizeMake(width, width);
}

// 分区间隔
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    if(section == 0){
        
        UIEdgeInsetsMake( 2, 2, 2, 2);
    }
    return UIEdgeInsetsMake( 0, 2, 2, 2);
}

// 行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 2;
}
// 列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 1;
}
#pragma mark ---------- 确定 ----------
- (void)omo_bookingStoreEnterTime{
    
    if(_selectWeek.length > 0 && _selectTime.length > 0){
        
        if(self.selctBookingTime){
            
            NSString *bookingTime = [NSString stringWithFormat:@"%@ %@",self.selectWeek,self.selectTime];
            self.selctBookingTime(bookingTime);
        }
        
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    [MBProgress showInfoMessage:@"请选择您的预约日期"];
}
@end
