//
//  OMOAssessmentView.m
//  OMO_iphone
//
//  Created by wy on 2018/10/15.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOAssessmentView.h"
/**  */
#import "OMOAssessmentCell.h"

@interface OMOAssessmentView()<UITableViewDelegate,UITableViewDataSource>

@end

static NSString *OMOAssessmentCellID = @"OMOAssessmentCellID";

@implementation OMOAssessmentView

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
        [self registerClass:[OMOAssessmentCell class] forCellReuseIdentifier:OMOAssessmentCellID];
    }
    return self;
}
- (void)setKangFuBaoModel:(OMOKangFuBaoModel *)kangFuBaoModel{
    
    _kangFuBaoModel = kangFuBaoModel;
    
    CGFloat height = 0.f;
    
    if(_kangFuBaoModel.pe_result.title.length > 0){
        
        height += _kangFuBaoModel.pe_result.height;
    }
    
    for (OMOPe_ResultModel *model in _kangFuBaoModel.pe_result.newContent) {
        
        height += model.height;
    }
    
    if(_kangFuBaoModel.pe_advise.title.length > 0){
        
        height += _kangFuBaoModel.pe_advise.height;
    }
    
    for (OMOPe_ResultModel *model in _kangFuBaoModel.pe_advise.newContent) {
        
        height += model.height;
    }
    
    if(self.setViewHeight){
        
        self.setViewHeight(height);
    }
    [self reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    CGFloat count = 0;
    
    if(_kangFuBaoModel.pe_result.newContent.count > 0){
        
        count += 1;
    }
    if(_kangFuBaoModel.pe_advise.newContent.count > 0){
        
        count += 1;
    }
    return count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(section == 0){
        
        if(_kangFuBaoModel.pe_result.newContent.count > 0){
            
            return _kangFuBaoModel.pe_result.newContent.count;
        }
        return _kangFuBaoModel.pe_advise.newContent.count;
    }else{
        
        return _kangFuBaoModel.pe_advise.newContent.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OMOAssessmentCell *cell = [tableView dequeueReusableCellWithIdentifier:OMOAssessmentCellID];
    
    if(indexPath.section == 0){
        
        if(_kangFuBaoModel.pe_result.newContent.count > 0){
            
            cell.model = _kangFuBaoModel.pe_result.newContent[indexPath.row];
        }else{
            
            cell.model = _kangFuBaoModel.pe_advise.newContent[indexPath.row];
        }
    }else{
        
        cell.model = _kangFuBaoModel.pe_advise.newContent[indexPath.row];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OMOPe_ResultModel *model;
    
    if(indexPath.section == 0){
        
        if(_kangFuBaoModel.pe_result.newContent.count > 0){
            
            model = _kangFuBaoModel.pe_result.newContent[indexPath.row];
        }else{
            
            model = _kangFuBaoModel.pe_advise.newContent[indexPath.row];
        }
    }else{
        
        model = _kangFuBaoModel.pe_advise.newContent[indexPath.row];
    }
    return model.height;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headView = [[UIView alloc]init];
    headView.lwb_x = 0;
    headView.lwb_width = tableView.lwb_width;
    headView.lwb_y = 0;
    
    NSString *title = @"";
    
    if(section == 0){
        
        if(_kangFuBaoModel.pe_result.newContent.count > 0){
            
            title = _kangFuBaoModel.pe_result.title;
            headView.lwb_height = _kangFuBaoModel.pe_result.height;
        }else{
            
            title = _kangFuBaoModel.pe_advise.title;
            headView.lwb_height = _kangFuBaoModel.pe_advise.height;
        }
    }else{
        
        title = _kangFuBaoModel.pe_advise.title;
        headView.lwb_height = _kangFuBaoModel.pe_advise.height;
    }
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(lwb_margin * 2, 0, headView.lwb_width - lwb_margin * 3, headView.lwb_height)];
    titleLab.attributedText = [title setLabelSpaceOfLineSpacing:4.f Kern:1.f Font:BoldFont(18)];
    titleLab.textColor = textColour;
    titleLab.textAlignment = NSTextAlignmentLeft;
//    titleLab.font = BoldFont(16);
    titleLab.numberOfLines = 0;
    [headView addSubview:titleLab];
    
    return headView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if(section == 0){
        
        if(_kangFuBaoModel.pe_result.newContent.count > 0){
            
            return _kangFuBaoModel.pe_result.height;
        }else{
            
            return _kangFuBaoModel.pe_advise.height;
        }
    }else{
        
        return _kangFuBaoModel.pe_advise.height;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 20.f;
}
@end
