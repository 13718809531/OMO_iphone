//
//  OMOAssessmentResultView.m
//  OMO_iphone
//
//  Created by wy on 2018/10/15.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOAssessmentVideoView.h"
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
/** 不可点击 */
#import "OMOAssessmentImageCell.h"

@interface OMOAssessmentVideoView()<UITableViewDelegate,UITableViewDataSource>

/**  */
@property (nonatomic, strong)UILabel *headLab;

@end

static NSString *OMOAssessmentVideoCellID = @"OMOAssessmentVideoCellID";
static NSString *OMOAssessmentImageCellID = @"OMOAssessmentImageCellID";

@implementation OMOAssessmentVideoView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    if(self = [super initWithFrame:frame style:style]){
        
        self.backgroundColor = mainBackColor;
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        self.delegate = self;
        self.dataSource = self;
        self.scrollEnabled = NO;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.tableHeaderView = self.headLab;
        [self registerClass:[OMOAssessmentVideoCell class] forCellReuseIdentifier:OMOAssessmentVideoCellID];
        [self registerClass:[OMOAssessmentImageCell class] forCellReuseIdentifier:OMOAssessmentImageCellID];
    }
    return self;
}
- (void)setVideos:(NSArray<OMOKangFuBaoVideoModel *> *)videos{
    
    _videos = videos;
    
    _headLab.text = [NSString stringWithFormat:@"共有%ld个康复训练视频",videos.count];
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
    OMOAssessmentImageCell *cell = [tableView dequeueReusableCellWithIdentifier:OMOAssessmentImageCellID];
    
    cell.videoModel = _videos[indexPath.row];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 0){
        
        return IFFitFloat6(280.f);
    }
    return 120.f;
}
- (UILabel *)headLab{
    
    if(_headLab == nil){
        
        _headLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.lwb_width, 40)];
        _headLab.textColor = textColour;
        _headLab.textAlignment = NSTextAlignmentLeft;
        _headLab.font = BoldFont(18);
    }
    return _headLab;
}
@end
