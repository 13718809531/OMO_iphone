//
//  OMOStoreModel.m
//  OMO_iphone
//
//  Created by wy on 2018/10/10.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOStoreModel.h"

@implementation OMOStoreModel

+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"store_id" : @"id"};
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"sowing_map":[OMOStoreSowing_mapModel class],@"time":[OMOStoreWeekModel class]};
}

@end

@implementation OMOStoreSowing_mapModel

- (CGFloat)titleHeight{
    
    if(_desc.length > 0){
        
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        
        paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
        
        paraStyle.alignment = NSTextAlignmentLeft;
        
        paraStyle.lineSpacing = 6.f;
        
        paraStyle.hyphenationFactor = 1.0;
        
        paraStyle.firstLineHeadIndent = 0.0;
        
        paraStyle.paragraphSpacingBefore = 0.0;
        
        paraStyle.headIndent = 0;
        
        paraStyle.tailIndent = 0;
        
        NSDictionary *dic = @{NSFontAttributeName:defoultFont, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@(1.f)};
        
        CGSize size = [_desc boundingRectWithSize:CGSizeMake(SCREENW - lwb_margin * 4, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
        
        CGFloat height = size.height + lwb_margin * 2;;
        
        return height;
    }
    
    return 0.f;
}
- (CGFloat)imageHeight{
    
    if(_url.length > 0){
        
        return (SCREENW - lwb_margin * 4) * 0.66;
    }
    return 0.f;
}
@end
