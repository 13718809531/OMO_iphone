//
//  OMOPayShareSuccessFootView.m
//  OMO_iphone
//
//  Created by wy on 2018/10/19.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOPayShareSuccessFootView.h"
/**  */
#import "OMOPaySuccessCell.h"

@interface OMOPayShareSuccessFootView()<UITableViewDelegate,UITableViewDataSource>

@end

static NSString *OMOPaySuccessCellID = @"OMOPaySuccessCellID";

@implementation OMOPayShareSuccessFootView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    if(self = [super initWithFrame:frame style:style]){
        
        self.backgroundColor = WHITECOLORA(1);
        self.scrollEnabled = NO;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self registerClass:[OMOPaySuccessCell class] forCellReuseIdentifier:OMOPaySuccessCellID];
        self.delegate = self;
        self.dataSource = self;
        self.tableFooterView = [[UIView alloc]init];
    }
    return self;
}
- (void)setDataSouce:(NSArray *)dataSouce{
    
    _dataSouce = dataSouce;
    
    [self reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataSouce.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        
    OMOPaySuccessCell *cell = [tableView dequeueReusableCellWithIdentifier:OMOPaySuccessCellID];
    cell.dict = _dataSouce[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40.f;
}
@end
