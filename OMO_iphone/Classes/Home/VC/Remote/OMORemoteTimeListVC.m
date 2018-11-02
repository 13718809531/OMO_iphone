//
//  OMORemoteTimeListVC.m
//  OMO_iphone
//
//  Created by wy on 2018/10/24.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMORemoteTimeListVC.h"
#import "OMORemoteWeekModel.h"
#import "OMORemoteWeekCell.h"
#import "OMORemoteTimeModel.h"
#import "OMORemoteTimeCell.h"

@interface OMORemoteTimeListVC()
<
UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout
>

@property(strong,nonatomic)NSMutableArray *dateMarr;
@property(strong,nonatomic)UICollectionView *collectionView;
@property(strong,nonatomic)NSArray <OMORemoteTimeModel *> *dataSouce;
/** 选中的星期 */
@property (nonatomic,copy)NSString *selectWeek;
/** 选中的时间 */
@property (nonatomic,copy)NSString *selectTime;
/** 立即预约 */
@property (nonatomic, strong)UIButton *enterBtn;
/** 是否为首次预约 */
@property (nonatomic,copy)NSString *is_first;
/** 支付金额 */
@property (nonatomic,copy)NSString *last_price;

@end

static NSString *OMORemoteWeekCellID = @"OMORemoteWeekCellID";
static NSString *OMORemoteTimeCellID = @"OMORemoteTimeCellID";

@implementation OMORemoteTimeListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatBar];
    [self.bar addLeftButtonWithImage:[UIImage imageNamed:@"App_Back"]];
    [self.bar addTitltLabelWithText:@"预约时间" Font:navTitleFont];
    
    [self omo_remoteVideoToHelpWithIndex:0];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.enterBtn];
}
- (NSMutableArray *)dateMarr{
    
    if(_dateMarr == nil){
        
        _dateMarr = [NSMutableArray array];
        
        NSDate *nowDate = [NSDate date];
        NSDateFormatter *dateFmt = [[NSDateFormatter alloc]init];
        //    设置东8区
        [dateFmt setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8*3600]];
        [dateFmt setDateFormat:@"yyyy-MM-dd"];
        NSString *nowDateStr = [dateFmt stringFromDate:nowDate];
        NSArray *dateArr = [nowDateStr componentsSeparatedByString:@"-"];
        NSString *year = dateArr[0];
        NSString *meth = dateArr[1];
        NSString *day = dateArr[2];
        
        int d = [day intValue] - 1;
        
        for (int i = 0; i < 100; i ++) {
            
            d ++ ;
            
            if([year intValue] % 4 == 0){
                
                if([meth intValue] == 2){
                    
                    if(d == 30){
                        
                        d = 0;
                        meth = [NSString stringWithFormat:@"%d",[meth intValue] + 1];
                        continue;
                    }
                }
            }else{
                
                if([meth intValue] == 2){
                    
                    if(d == 29){
                        
                        d = 0;
                        meth = [NSString stringWithFormat:@"%d",[meth intValue] + 1];
                        continue;
                    }
                }else if ([meth intValue] == 1 || [meth intValue] == 3 || [meth intValue] == 5 || [meth intValue] == 7 || [meth intValue] == 8 || [meth intValue] == 10 || [meth intValue] == 12){
                    
                    if([meth intValue] == 12){
                        
                        if(d == 32){
                            
                            d = 0;
                            meth = @"1";
                            year = [NSString stringWithFormat:@"%d",[year intValue] + 1];
                            continue;
                        }
                    }else{
                        
                        if(d == 32){
                            
                            d = 0;
                            meth = [NSString stringWithFormat:@"%d",[meth intValue] + 1];
                            continue;
                        }
                    }
                }else{
                    
                    if(d == 31){
                        
                        d = 0;
                        meth = [NSString stringWithFormat:@"%d",[meth intValue] + 1];
                        continue;
                    }
                }
            }
            NSString *dateSS = [NSString stringWithFormat:@"%@-%@-%d",year,meth,d];
            
            OMORemoteWeekModel *dateModel = [[OMORemoteWeekModel alloc]init];
            dateModel.dateStr = dateSS;
            
            if(i == 0){
                
                dateModel.isSelect = YES;
            }
            if([dateModel.weekStr containsString:@"六"] || [dateModel.weekStr containsString:@"日"])continue;
            
            [_dateMarr addObject:dateModel];
            
            if(_dateMarr.count == 5)break;
        }
    }
    return _dateMarr;
}
- (void)omo_remoteVideoToHelpWithIndex:(NSInteger)index{
    
    NSMutableDictionary *parmars = [NSMutableDictionary dictionary];
    
    OMORemoteWeekModel *dateModel = self.dateMarr[index];
    _selectWeek = dateModel.dateStr;
    NSInteger num = dateModel.weekIndex;
    
    parmars[@"week"] = [NSString stringWithFormat:@"%ld",num];
    
    __weak typeof(self) weakSelf = self;
    
    [[OMONetworkManager sharedData]postWithURLString:@"41011" parameters:parmars success:^(id responseObject) {
        
        if(responseObject){
            
            NSDictionary *dataSouce = (NSDictionary *)responseObject;
            
            weakSelf.is_first = dataSouce[@"is_first"];
            weakSelf.last_price = dataSouce[@"last_price"];
            
            weakSelf.dataSouce = [OMORemoteTimeModel mj_objectArrayWithKeyValuesArray:dataSouce[@"time"]];
            
            [self.collectionView reloadData];
        }
    } failure:^(NSError *error) {
        
        [MBProgress hideAllHUD];
    }];
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
        
        [_collectionView registerClass:[OMORemoteWeekCell class] forCellWithReuseIdentifier:OMORemoteWeekCellID];
        [_collectionView registerClass:[OMORemoteTimeCell class] forCellWithReuseIdentifier:OMORemoteTimeCellID];
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
        
        return _dateMarr.count;
    }
    return _dataSouce.count;
}
// cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0){
        
        OMORemoteWeekCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:OMORemoteWeekCellID forIndexPath:indexPath];
        
        cell.weekModel = _dateMarr[indexPath.row];
        
        return cell;
    }else{
        
        OMORemoteTimeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:OMORemoteTimeCellID forIndexPath:indexPath];
        
        cell.timeModel = _dataSouce[indexPath.row];
        
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0){
        
        OMORemoteWeekModel *weekModel = _dateMarr[indexPath.row];
        
        if(weekModel.isSelect)return;
        
        for (OMORemoteWeekModel *allWeekModel in _dateMarr) {
            
            allWeekModel.isSelect = NO;
        }
        weekModel.isSelect = YES;
        _selectWeek = weekModel.weekStr;
        _selectTime = @"";
        [self omo_remoteVideoToHelpWithIndex:indexPath.row];
        
        [collectionView reloadData];
    }else{
        
        OMORemoteTimeModel *timeModel = _dataSouce[indexPath.row];
        
        if(timeModel.isSelect)return;
        
        if(timeModel.status){
            
            for (OMORemoteTimeModel *allTimeModel in _dataSouce) {
                
                allTimeModel.isSelect = NO;
            }
            timeModel.isSelect = YES;
            _selectTime = timeModel.time;
        }else{
            
            return;
        }
        NSIndexSet *set = [NSIndexSet indexSetWithIndex:indexPath.section];
        [collectionView reloadSections:set];
    }
}
// iteam大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat width = (collectionView.lwb_width - 2 * 4) * 0.2;
    return CGSizeMake(width, width);
}

// 分区间隔
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    if(section == 0){
        
        UIEdgeInsetsMake( 0, 0, 0, 0);
    }
    return UIEdgeInsetsMake( 2, 0, 2, 0);
}

// 行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 2;
}
// 列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 2;
}
#pragma mark ---------- 确定 ----------
- (void)omo_bookingStoreEnterTime{
    
    if(_selectWeek.length > 0 && _selectTime.length > 0){
        
        if(self.selectTimeBlock){
            
            NSString *bookingTime = [NSString stringWithFormat:@"%@ %@",self.selectWeek,self.selectTime];
            self.selectTimeBlock(bookingTime,_last_price);
        }
        
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    [MBProgress showInfoMessage:@"请选择您的预约日期"];
}
@end
