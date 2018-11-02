//
//  OMOKangFuBaoModel.m
//  OMO_iphone
//
//  Created by wy on 2018/10/13.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOKangFuBaoModel.h"

@implementation OMOKangFuBaoModel

// 类中的属性匹配特定字符串
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"kangFuBao_id":@"id",@"descriptionName":@"description"};
}
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"contentAnswer":[OMOKangFuBaoContentAnswerModel class],@"mt_item":[OMOKangFuBaoMtItemModel class]};
}
- (NSArray<OMOKangFuBaoVideoModel *> *)videos{
    
    NSMutableArray *videos = [NSMutableArray array];
    
    for (OMOKangFuBaoContentAnswerModel *contentAnswer in _contentAnswer) {
        
        for (OMOKangFuBaoLevelValueModel *levelValue in contentAnswer.levelValue) {
            
            for (OMOKangFuBaoQuestionsModel *questionModel in levelValue.questions) {
                
                if([questionModel.resource.type isEqualToString:@"1"] && questionModel.resource.url.length > 0){
                    
                    OMOKangFuBaoVideoModel *videoModel = [[OMOKangFuBaoVideoModel alloc]init];
                    videoModel.video_id = questionModel.resource.resource_id;
                    videoModel.type = questionModel.resource.type;
                    videoModel.question_name = questionModel.question_name;
                    OMOKangFuBaoOptionsModel *optionsModel = questionModel.options[0];
                    videoModel.options_name = optionsModel.name;
                    videoModel.url = questionModel.resource.url;
                    videoModel.attentions = questionModel.resource.attentions;
                    videoModel.content = questionModel.resource.content;
                    
                    [videos addObject:videoModel];
                }
            }
        }
    }
    return [NSArray arrayWithArray:videos];
}
@end

@implementation OMOKangFuBaoPe_PlanModel

@end

@implementation OMOKangFuBaoPe_ResultModel

- (CGFloat)height{
    
    CGFloat height = 0.f;
    
    if(_title.length > 0){
        
        height = [_title getLabelHightOfWidth:SCREENW - lwb_margin * 5 LineSpacing:4.f Kern:1.f Font:BoldFont(18)];
        
        if(height + lwb_margin * 3 < 50){
            
            height = 50;
        }else{
            
            height += lwb_margin * 3;
        }
        return height;
    }
    return height;
}
- (NSArray *)newContent{
    
    if(_content.count > 0){
        
        NSMutableArray *array = [NSMutableArray array];
        
        for (NSString *str in _content) {
            
            OMOPe_ResultModel *model = [[OMOPe_ResultModel alloc]init];
            model.title = str;
            
            CGFloat height = [_title getLabelHightOfWidth:SCREENW - lwb_margin * 5 LineSpacing:4.f Kern:1.f Font:defoultFont];
            
            if(height + lwb_margin * 2 < 40){
                
                height = 40;
            }else{
                
                height += lwb_margin * 2;
            }
            model.height = height;
            
            [array addObject:model];
        }
        return [NSArray arrayWithArray:array];
    }
    return nil;
}
@end

@implementation OMOPe_ResultModel

@end
