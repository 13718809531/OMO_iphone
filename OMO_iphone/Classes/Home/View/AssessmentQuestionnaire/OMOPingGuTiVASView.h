//
//  OMOPingGuTiVASView.h
//  OMO_iphone
//
//  Created by wy on 2018/9/28.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OMOPingGuTiVasDelegate <NSObject>

- (void)omo_pingGuTiVasFromSlider_Value:(NSString *)slider_Value TitleText:(NSString *)tetx;

@end

@interface OMOPingGuTiVASView : UIView

@property (nonatomic , weak) id <OMOPingGuTiVasDelegate> delegate; /** vas题 */

@end
