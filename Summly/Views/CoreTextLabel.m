//
//  CoreTextLabel.m
//  core
//
//  Created by lostkid on 13-1-14.
//  Copyright (c) 2013年 邹 露. All rights reserved.
//

#import "CoreTextLabel.h"

#define lastLine 9
#define lineWith 220
@implementation CoreTextLabel
@synthesize characterSpacing = characterSpacing_;
@synthesize linesSpacing = linesSpacing_;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.characterSpacing = 2.0f;
        self.linesSpacing = 6.0f;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{

    //创建AttributeString
    NSString *stringText =[[NSString alloc]initWithString:self.text];
    NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:[stringText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];

    //设置字体及大小
    CTFontRef helveticaBold = CTFontCreateWithName((__bridge CFStringRef)self.font.fontName,self.font.pointSize,NULL);
    [string addAttribute:(id)kCTFontAttributeName value:(__bridge id)helveticaBold range:NSMakeRange(0,[string length])];
    //设置字间距
    if(self.characterSpacing)
    {
        long number = self.characterSpacing;
        CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
        [string addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(0,[string length])];
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
    
//    CTLineBreakMode lineBreakMode = kCTLineBreakByCharWrapping;
        
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
    [string addAttribute:(id)kCTParagraphStyleAttributeName value:(__bridge id)style range:NSMakeRange(0 , [string length])];
 
//    //排版
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)string);
    CGMutablePathRef leftColumnPath = CGPathCreateMutable();
    CGPathAddRect(leftColumnPath, NULL ,CGRectMake(0 , 0 ,self.bounds.size.width , self.bounds.size.height));
    CTFrameRef leftFrame = CTFramesetterCreateFrame(framesetter,CFRangeMake(0, [string length]), leftColumnPath , NULL);
    //翻转坐标系统（文本原来是倒的要翻转下）
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context , CGAffineTransformIdentity);
    CGContextTranslateCTM(context , 0 ,self.bounds.size.height);
    CGContextScaleCTM(context, 1.0 ,-1.0);
    
    CFArrayRef lines = CTFrameGetLines(leftFrame);
    int lineNumber = CFArrayGetCount(lines);
    CGPoint lineOrigins[lineNumber];
    CTFrameGetLineOrigins(leftFrame,CFRangeMake(0,lineNumber), lineOrigins);
    
    for(int lineIndex = 0;lineIndex < lineNumber;lineIndex++){
        if (lineIndex!=lastLine) {
        CGPoint lineOrigin = lineOrigins[lineIndex];
        CTLineRef line = CFArrayGetValueAtIndex(lines,lineIndex);
        CGContextSetTextPosition(context,lineOrigin.x,lineOrigin.y);
        CTLineDraw(line,context);
        }else{
            CGPoint lineOrigin = lineOrigins[lineIndex];
            CTLineRef line = CFArrayGetValueAtIndex(lines,lineIndex);
            CTLineRef line1 = CTLineCreateTruncatedLine(line, lineWith, kCTLineTruncationEnd, NULL);
            CGContextSetTextPosition(context,lineOrigin.x,lineOrigin.y);
            CTLineDraw(line1,context);
            
            NSMutableAttributedString *points = [[NSMutableAttributedString alloc] initWithString:@"......"];
            CTLineRef linePoints = CTLineCreateWithAttributedString((__bridge CFAttributedStringRef)(points));
            CGContextSetTextPosition(context,lineWith-self.characterSpacing,lineOrigin.y+4);
            
            CTLineDraw(linePoints,context);
            
            CFRelease(linePoints);
        }
    }
    
    CGPathRelease(leftColumnPath);
    CFRelease(framesetter);
    CFRelease(helveticaBold);
    //    [string release];
    UIGraphicsPushContext(context);
}

@end
