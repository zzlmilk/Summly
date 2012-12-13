//
//  MainSummlyView.m
//  Summly
//
//  Created by zzlmilk on 12-12-11.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import "MainSummlyView.h"
#import "FrontSummlyView.h"
#import "SummlyScrollView.h"


@implementation MainSummlyView
- (id)initWithFrame:(CGRect)frame summlyScrollView:(SummlyScrollView *)summlyScrollView AndFrontSummlyView:(FrontSummlyView *)frontView
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.contentSize = CGSizeMake(self.frame.size.width*2, self.frame.size.height);
        self.showsHorizontalScrollIndicator = NO;
        self.pagingEnabled =YES;
        
          
                
        [self addSubview:frontView];
        [self addSubview:summlyScrollView];

        
        [self setContentOffset:CGPointMake(self.frame.size.width, 0) animated:YES];
        
              // Initialization code
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
