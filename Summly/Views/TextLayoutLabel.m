//
//  TextLayoutLabel.m
//  UIlabel
//
//  Created by lostkid on 13-1-12.
//  Copyright (c) 2013年 邹 露. All rights reserved.
//

#import "TextLayoutLabel.h"
#import<CoreText/CoreText.h>

@implementation TextLayoutLabel
@synthesize characterSpacing = characterSpacing_;
@synthesize linesSpacing = linesSpacing_;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.characterSpacing = 2.0f;
        self.linesSpacing = 6.0f;
    }
    return self;
}

-(void)setCharacterSpacing:(CGFloat)characterSpacing //外部调用设置字间距
{
    characterSpacing_ = characterSpacing;
    [self setNeedsDisplay];
}

-(void)setLinesSpacing:(long)linesSpacing  //外部调用设置行间距
{
    linesSpacing_ = linesSpacing;
    [self setNeedsDisplay];
}

-(void) drawTextInRect:(CGRect)requestedRect
{
//    CTFramesetterSuggestFrameSizeWithConstraints
    //创建AttributeString
    NSMutableAttributedString *string =[[NSMutableAttributedString alloc]initWithString:self.text];
    //设置字体及大小
    CTFontRef helveticaBold = CTFontCreateWithName((CFStringRef)self.font.fontName,self.font.pointSize,NULL);    
    [string addAttribute:(id)kCTFontAttributeName value:(id)helveticaBold range:NSMakeRange(0,[string length])];
    //设置字间距
    if(self.characterSpacing)
    {
        long number = self.characterSpacing;
        CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
        [string addAttribute:(id)kCTKernAttributeName value:(id)num range:NSMakeRange(0,[string length])];
        CFRelease(num);
    }
    //设置字体颜色
    [string addAttribute:(id)kCTForegroundColorAttributeName value:(id)(self.textColor.CGColor) range:NSMakeRange(0,[string length])];
    //创建文本对齐方式
    CTTextAlignment alignment = kCTLeftTextAlignment;
    if(self.textAlignment == UITextAlignmentCenter)
    {
        alignment = kCTCenterTextAlignment;
    }
    if(self.textAlignment == UITextAlignmentRight)
    {
        alignment = kCTRightTextAlignment;
    }
    CTParagraphStyleSetting alignmentStyle;
    alignmentStyle.spec = kCTParagraphStyleSpecifierAlignment;
    alignmentStyle.valueSize = sizeof(alignment);
    alignmentStyle.value = &alignment;
    //设置文本行间距
    CGFloat lineSpace = self.linesSpacing;
    CTParagraphStyleSetting lineSpaceStyle;
    lineSpaceStyle.spec = kCTParagraphStyleSpecifierLineSpacingAdjustment;
    lineSpaceStyle.valueSize = sizeof(lineSpace);
    lineSpaceStyle.value =&lineSpace;
    //设置文本段间距
    CGFloat paragraphSpacing = 0;
    CTParagraphStyleSetting paragraphSpaceStyle;
    paragraphSpaceStyle.spec = kCTParagraphStyleSpecifierParagraphSpacing;
    paragraphSpaceStyle.valueSize = sizeof(CGFloat);
    paragraphSpaceStyle.value = &paragraphSpacing;
    
    //创建设置数组
    CTParagraphStyleSetting settings[ ] ={alignmentStyle,lineSpaceStyle,paragraphSpaceStyle};
    CTParagraphStyleRef style = CTParagraphStyleCreate(settings ,3);
    //给文本添加设置
    [string addAttribute:(id)kCTParagraphStyleAttributeName value:(id)style range:NSMakeRange(0 , [string length])];
    //排版
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)string);
    CGMutablePathRef leftColumnPath = CGPathCreateMutable();
    CGPathAddRect(leftColumnPath, NULL ,CGRectMake(0 , 0 ,self.bounds.size.width , self.bounds.size.height));
    CTFrameRef leftFrame = CTFramesetterCreateFrame(framesetter,CFRangeMake(0, 0), leftColumnPath , NULL);
    //翻转坐标系统（文本原来是倒的要翻转下）
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context , CGAffineTransformIdentity);
    CGContextTranslateCTM(context , 0 ,self.bounds.size.height);
    CGContextScaleCTM(context, 1.0 ,-1.0);
    //画出文本
    CTFrameDraw(leftFrame,context);
    //释放
    CGPathRelease(leftColumnPath);
    CFRelease(framesetter);
    CFRelease(helveticaBold);
    [string release];
    UIGraphicsPushContext(context);
    
}
@end
