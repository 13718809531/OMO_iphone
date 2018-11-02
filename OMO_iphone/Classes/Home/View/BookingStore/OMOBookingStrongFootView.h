//
//  OMOBookingStrongFootView.h
//  OMO_iphone
//
//  Created by wy on 2018/9/28.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DidEndEditing)(NSString *text);

@interface OMOBookingStrongFootView : UICollectionReusableView

/**  */
@property (nonatomic,copy)NSString *desc;
/**  */
@property (nonatomic,copy)DidEndEditing endEditing;

@end
