//
//  OMORemoteBookingCell.h
//  OMO_iphone
//
//  Created by wy on 2018/10/25.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <UIKit/UIKit.h>
/**  */
#import "OMORemoteBookingModel.h"

/**
 *
 *
 */
@protocol OMOCancelRemoteBookingDelegate <NSObject>

- (void)omo_cancelRemoteBookingWithBookingId:(NSString *)booking_id;
- (void)omo_startRemoteVideoWithID:(NSString *)ID;
@end

@interface OMORemoteBookingCell : UICollectionViewCell

/**  */
@property (nonatomic , weak) id <OMOCancelRemoteBookingDelegate> delegate;
/**  */
@property (nonatomic, strong)OMORemoteBookingModel *model;

@end
