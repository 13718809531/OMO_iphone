//
//  OMOBookingStrongCell.h
//  OMO_iphone
//
//  Created by wy on 2018/9/28.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OMOBookingStoreCell : UICollectionViewCell

/**  */
@property (nonatomic, strong)NSDictionary *dict;
/**  */
@property (nonatomic,copy)NSString *detailText;
/** 采集信息 */
@property (nonatomic, strong)UILabel *detailLab;

@end
