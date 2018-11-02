//
//  OMOStoreBookingCell.h
//  OMO_iphone
//
//  Created by wy on 2018/10/25.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <UIKit/UIKit.h>
/**  */
#import "OMOStoreBookingModel.h"

/**
 *
 *
 */
@protocol OMOCancelStoreBookingDelegate <NSObject>

- (void)OMOCancelStoreBookingWithBookingId:(NSString *)booking_id;

@end

@interface OMOStoreBookingCell : UICollectionViewCell

/**  */
@property (nonatomic , weak) id <OMOCancelStoreBookingDelegate> delegate;
/**  */
@property (nonatomic, strong)OMOStoreBookingModel *model;

@end
