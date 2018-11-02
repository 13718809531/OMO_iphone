//
//  OMORehabilitationDetailBottomView.h
//  OMO_iphone
//
//  Created by wy on 2018/10/10.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <UIKit/UIKit.h>
/**  */
#import "OMOKangFuBaoModel.h"

@protocol OMORehabilitationDelegate <NSObject>
//** 获取or分享 */
- (void)omo_rehabilitationBottomClickOfTag:(NSInteger)tag;

@end

@interface OMORehabilitationBottomView : UIView

/**  */
@property (nonatomic , weak) id <OMORehabilitationDelegate> delegate;

/**  */
@property (nonatomic, strong)OMOKangFuBaoModel *kangFuBaoModel;

@end
