//
//  OMOBuyPlanBottomView.h
//  OMO_iphone
//
//  Created by wy on 2018/10/20.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *
 *
 */
@protocol OMOPlanOrderDelegate <NSObject>

- (void)omo_planCancelOrPayWithType:(NSInteger)type;

@end

@interface OMOBuyPlanBottomView : UIView

/**  */
@property (nonatomic , weak) id <OMOPlanOrderDelegate> delegate;

@end
