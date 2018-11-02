//
//  OMOPingGuTiModel.m
//  OMO_iphone
//
//  Created by wy on 2018/9/28.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOPingGuTiModel.h"

@implementation OMOPingGuTiModel

// 类中的属性匹配特定字符串
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"pingGuTi_id":@"id"};
}
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"options":[OMOPingGuTiOptionModel class]};
}
@end

@implementation OMOPingGuTiOptionModel

- (CGFloat)height{
    
    if(_value.length > 0){
        
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
        
        CGSize size = [_value boundingRectWithSize:CGSizeMake(SCREENW - lwb_margin * 5 - 60, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
        
        CGFloat height = size.height + lwb_margin * 2;;
        
        if(height < 50.f){
            
            return 50.f;
        }
        return height;
    }
    
    return 0.f;
}
- (CGFloat)imageHeight{
    
    if(_value.length > 0){
        
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
        
        CGSize size = [_value boundingRectWithSize:CGSizeMake(SCREENW - lwb_margin * 10, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
        
        CGFloat height = size.height + lwb_margin * 2;
        
        return height;
    }
    
    return 30.f;
}
@end
