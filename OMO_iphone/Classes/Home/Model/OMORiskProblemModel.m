//
//  OMORiskProblemModel.m
//  OMO_iphone
//
//  Created by wy on 2018/9/21.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMORiskProblemModel.h"

@implementation OMORiskProblemModel

- (CGFloat)height{
    
    if(_title.length > 0){
        
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        
        paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
        
        paraStyle.alignment = NSTextAlignmentLeft;
            
        paraStyle.lineSpacing = 6.f;
        
        paraStyle.hyphenationFactor = 1.0;
        
        paraStyle.firstLineHeadIndent = 0.0;
        
        paraStyle.paragraphSpacingBefore = 0.0;
        
        paraStyle.headIndent = 0;
        
        paraStyle.tailIndent = 0;
        
        NSDictionary *dic = @{NSFontAttributeName:bigFont, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@(1.f)};
        
        CGSize size = [_title boundingRectWithSize:CGSizeMake(SCREENW - lwb_margin * 6 - 60, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
        
        CGFloat height = size.height + lwb_margin * 2;;
        
        if(height < 50.f){
            
            return 50.f;
        }
        return height;
    }
    
    return 50.f;
}

@end
