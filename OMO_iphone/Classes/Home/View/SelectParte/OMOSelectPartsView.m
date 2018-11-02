//
//  OMOSelectPartsView.m
//  OMO_iphone
//
//  Created by wy on 2018/9/14.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOSelectPartsView.h"
#import "OMOSelectPartsCell.h"
#import "OMOSelectPartsModel.h"

@interface OMOSelectPartsView()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray <OMOSelectPartsModel *> *partsArray;

@end

static NSString *OMOSelectPartsCellID = @"OMOSelectPartsCellID";

@implementation OMOSelectPartsView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        _partsArray = [NSMutableArray array];
        self.backgroundColor = [UIColor whiteColor];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = lwb_smallMargin;
        
        [self omo_requestDataSouce];
    }
    return self;
}
- (void)omo_requestDataSouce{
    
    __weak typeof(self) weakSelf = self;
    
    [[OMONetworkManager sharedData] postWithURLString:@"40000" parameters:nil success:^(id responseObject) {
        
        if(responseObject){
            
            NSDictionary *dataSouce = (NSDictionary *)responseObject;
            
            NSArray *array = dataSouce[@"cate_list"];
            
            [weakSelf omo_setDataSouceWithArray:array];
        }
    } failure:^(NSError *error) {
        
        [MBProgress hideAllHUD];
    }];
}
- (void)omo_setDataSouceWithArray:(NSArray *)array{
    
    for (NSDictionary *dict in array) {
        
        OMOSelectPartsModel *partsModel = [[OMOSelectPartsModel alloc]init];
        
        if([dict[@"cate_name"] isEqualToString:@"颈部"]){
            
            partsModel.imgName = @"jing";
        }else if ([dict[@"cate_name"] isEqualToString:@"肩部"]){
            
            partsModel.imgName = @"jian";
        }else if ([dict[@"cate_name"] isEqualToString:@"肘部"]){
            
            partsModel.imgName = @"zhou";
        }else if ([dict[@"cate_name"] isEqualToString:@"腕部"]){
            
            partsModel.imgName = @"wan";
        }else if ([dict[@"cate_name"] isEqualToString:@"髋部"]){
            
            partsModel.imgName = @"kuan";
        }else if ([dict[@"cate_name"] isEqualToString:@"膝部"]){
            
            partsModel.imgName = @"xi";
        }else if ([dict[@"cate_name"] isEqualToString:@"踝部"]){
            
            partsModel.imgName = @"luo";
        }else if ([dict[@"cate_name"] isEqualToString:@"腰部"]){
            
            partsModel.imgName = @"yao";
        }else if ([dict[@"cate_name"] isEqualToString:@"背部"]){
            
            partsModel.imgName = @"bei";
        }else if ([dict[@"cate_name"] isEqualToString:@"胸部"]){
            
            partsModel.imgName = @"xiong";
        }
        partsModel.cate_id = dict[@"id"];
        partsModel.cate_name = dict[@"cate_name"];
        partsModel.select = NO;
        
        [_partsArray addObject:partsModel];
    }
    [self addSubview:self.tableView];
}
- (UITableView *)tableView{
    
    if(_tableView == nil){
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.lwb_width, self.lwb_height / 10 * _partsArray.count) style:UITableViewStylePlain];
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.separatorColor = mainBackColor;
        [_tableView registerClass:[OMOSelectPartsCell class] forCellReuseIdentifier:OMOSelectPartsCellID];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        UIBezierPath * maskPath = [UIBezierPath bezierPathWithRoundedRect:_tableView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerTopLeft cornerRadii:CGSizeMake(12.5f, 12.5f)];
        CAShapeLayer * maskLayer = [CAShapeLayer new];
        maskLayer.frame = _tableView.bounds;
        maskLayer.path = maskPath.CGPath;
        _tableView.layer.mask = maskLayer;
    }
    return _tableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _partsArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OMOSelectPartsCell *cell = [tableView dequeueReusableCellWithIdentifier:OMOSelectPartsCellID];
    
    cell.partsModel = _partsArray[indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OMOSelectPartsModel *partsModel = _partsArray[indexPath.row];
    
    if(partsModel.select)return;
    
    for (OMOSelectPartsModel *partsModel in _partsArray) {
        
        partsModel.select = NO;
    }
    partsModel.select = YES;
    
    [OMOIphoneManager sharedData].cate_id = partsModel.cate_id;
    [OMOIphoneManager sharedData].cate_name = partsModel.cate_name;
    
    if(self.seletPaetsblock){
        
        self.seletPaetsblock(partsModel.imgName);
    }
    [tableView reloadData];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return self.lwb_height / 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.lwb_width, 2)];
    lineView.backgroundColor = mainBackColor;
    return lineView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 2.f;
}
@end
