//
//  UILabel+Category.m
//  JXYH
//
//  Created by 刘卫兵 on 2017/12/12.
//  Copyright © 2017年 友惠家(北京)信息科技有限公司. All rights reserved.
//

#import "UILabel+Category.h"

@implementation UILabel (Category)

- (CGFloat)autoLblWidth
{
    NSDictionary *attribute = @{NSFontAttributeName:self.font};
    CGSize size = [self.text boundingRectWithSize:CGSizeMake(MAXFLOAT, self.lwb_height)
                                           options: NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                        attributes:attribute
                                           context:nil].size;
    return size.width;
}
- (CGFloat)autoLblHeight
{
    NSDictionary *attribute = @{NSFontAttributeName:self.font};
    
    CGSize size = [self.text boundingRectWithSize:CGSizeMake(self.lwb_width, MAXFLOAT)
                                          options: NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                       attributes:attribute
                                          context:nil].size;
    return size.height;
}
//给UILabel设置行间距和字间距
- (void)setLabelSpaceOfLineSpacing:(CGFloat)lineSpacing Kern:(CGFloat)kern{
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    
    paraStyle.alignment = NSTextAlignmentLeft;
    
    if(lineSpacing == 0.0){
        
        paraStyle.lineSpacing = 4.f;
    }
    paraStyle.lineSpacing = lineSpacing; //设置行间距
    
    paraStyle.hyphenationFactor = 1.0;
    
    paraStyle.firstLineHeadIndent = 0.0;
    
    paraStyle.paragraphSpacingBefore = 0.0;
    
    paraStyle.headIndent = 0;
    
    paraStyle.tailIndent = 0;
    
    if(kern == 0.0){
        
        kern = 1.f;
    }
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:self.font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@(kern)};
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:self.text attributes:dic];
    
    self.attributedText = attributeStr;
}
//计算UILabel的高度(带有行间距的情况)
- (CGFloat)getLabelHightOfLineSpacing:(CGFloat)lineSpacing Kern:(CGFloat)kern{
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    
    paraStyle.alignment = NSTextAlignmentLeft;
    
    if(lineSpacing == 0.0){
        
        paraStyle.lineSpacing = 6.f;
    }
    paraStyle.lineSpacing = lineSpacing; //设置行间距
    
    paraStyle.hyphenationFactor = 1.0;
    
    paraStyle.firstLineHeadIndent = 0.0;
    
    paraStyle.paragraphSpacingBefore = 0.0;
    
    paraStyle.headIndent = 0;
    
    paraStyle.tailIndent = 0;
    
    if(kern == 0.0){
        
        kern = 1.5f;
    }
    
    NSDictionary *dic = @{NSFontAttributeName:self.font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@(kern)};
    
    CGSize size = [self.text boundingRectWithSize:CGSizeMake(self.lwb_width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    return size.height;
}
//计算UILabel的宽度(带有行间距的情况)
- (CGFloat)getLabelWidthOfLineSpacing:(CGFloat)lineSpacing Kern:(CGFloat)kern{
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    
    paraStyle.alignment = NSTextAlignmentLeft;
    
    if(lineSpacing == 0.0){
        
        paraStyle.lineSpacing = 6.f;
    }
    paraStyle.lineSpacing = lineSpacing; //设置行间距
    
    paraStyle.hyphenationFactor = 1.0;
    
    paraStyle.firstLineHeadIndent = 0.0;
    
    paraStyle.paragraphSpacingBefore = 0.0;
    
    paraStyle.headIndent = 0;
    
    paraStyle.tailIndent = 0;
    
    if(kern == 0.0){
        
        kern = 1.5f;
    }
    
    NSDictionary *dic = @{NSFontAttributeName:self.font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@(kern)};
    
    CGSize size = [self.text boundingRectWithSize:CGSizeMake(MAXFLOAT, self.lwb_height) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    return size.width;
}
@end
