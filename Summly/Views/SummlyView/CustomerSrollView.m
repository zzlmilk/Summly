//
//  CustomerSrollView.m
//  Summly
//
//  Created by zzlmilk on 12-12-8.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import "CustomerSrollView.h"

@implementation CustomerSrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


/*
- (void)addGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
	// workaround for bug: pinch recognizer gets added during rotation,
	//  causes contentOffset to be set to (0,0) on pinch
	if ([gestureRecognizer isKindOfClass:[UIPinchGestureRecognizer class]])
	{
        NSLog(@" set addGestureRecognizer is no");
		gestureRecognizer.enabled = NO;
	}
    
	[super addGestureRecognizer:gestureRecognizer];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
