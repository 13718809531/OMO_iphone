//
//  OMOAssessmentResultView.m
//  OMO_iphone
//
//  Created by wy on 2018/10/15.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOAssessmentVideoView"
/**  */
#import "OMOAssessmentVideoCell.h"
/** 康复包阶段 */
#import "OMOKangFuBaoContentAnswerModel.h"
/** 康复包疗法 */
#import "OMOKangFuBaoLevelValueModel.h"
/** 康复包资源介绍 */
#import "OMOKangFuBaoQuestionsModel.h"
/** 资源 */
#import "OMOKangFuBaoResourceModel.h"

@interface OMOAssessmentResultView()<UITableViewDelegate,UITableViewDataSource>

@end

static NSString *OMOAssessmentVideoCellID = @"OMOAssessmentVideoCellID";

@implementation OMOAssessmentResultView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    if(self = [super initWithFrame:frame style:style]){
        
        self.backgroundColor = WHITECOLORA(1);
        self.layer.cornerRadius = lwb_margin;
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        self.delegate = self;
        self.dataSource = self;
        self.scrollEnabled = NO;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        [self registerClass:[OMOAssessmentVideoCell class] forCellReuseIdentifier:OMOAssessmentVideoCellID];
    }
    return self;
}
- (void)setVideos:(NSArray<OMOKangFuBaoVideoModel *> *)videos{
    
    _videos = videos;
    
    [self reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _videos.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 0){
        
        OMOAssessmentVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:OMOAssessmentVideoCellID];
        
        cell.videoModel = _videos[indexPath.row];
        
        return cell;
    }
    OMOAssessmentVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:OMOAssessmentVideoCellID];
    
    cell.videoModel = _videos[indexPath.row];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 0){
        
        return 200.f;
    }
    return 120.f;
}
@end
