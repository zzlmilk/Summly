//
//  FrontSummlyView.m
//  Summly
//
//  Created by zzlmilk on 12-12-11.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import "FrontSummlyView.h"

@implementation FrontSummlyView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 100, 200)];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"我是封面";
        label.textColor = [UIColor whiteColor];
        [self addSubview:label];
      
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
