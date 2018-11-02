//
//  OMOPingGuTiChooseView.h
//  OMO_iphone
//
//  Created by wy on 2018/9/28.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OMOPingGuTiModel.h"

@protocol OMOPingGuTiSelectDelegate <NSObject>

- (void)omo_pingGuTiSelectFromArray:(NSArray *)array;

@end

@interface OMOPingGuTiChooseView : UIView

@property (nonatomic , weak) id <OMOPingGuTiSelectDelegate> delegate; /**  */
@property (nonatomic, strong)OMOPingGuTiModel *pingGuTiModel;// 数据

@end
