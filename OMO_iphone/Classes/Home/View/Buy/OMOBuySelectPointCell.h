//
//  OMOBuySelectPointCell.h
//  OMO_iphone
//
//  Created by wy on 2018/10/17.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
  *
  *
  */
@protocol OMOSwitchPointDeductionDelegate <NSObject>

- (void)OMO_SwitchPointDeductionWithOn:(BOOL)isOn;

@end

@interface OMOBuySelectPointCell : UITableViewCell

/**  */
@property (nonatomic , weak) id <OMOSwitchPointDeductionDelegate> delegate;
/**  */
@property (nonatomic,copy)NSString *title;

@end
