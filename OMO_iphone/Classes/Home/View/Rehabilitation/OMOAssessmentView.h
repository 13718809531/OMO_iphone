//
//  OMOAssessmentView.h
//  OMO_iphone
//
//  Created by wy on 2018/10/15.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <UIKit/UIKit.h>
/**  */
#import "OMOKangFuBaoModel.h"

typedef void(^SetViewHeight)(CGFloat height);

@interface OMOAssessmentView : UITableView

/**  */
@property (nonatomic, strong)OMOKangFuBaoModel *kangFuBaoModel;
/** 重新设置视图高度 */
@property (nonatomic,copy)SetViewHeight setViewHeight;

@end
