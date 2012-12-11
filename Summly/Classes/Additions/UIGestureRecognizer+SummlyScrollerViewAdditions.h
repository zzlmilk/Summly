//
//  UIGestureRecognizer+SummlyScrollerViewAdditions.h
//  Summly
//
//  Created by zzlmilk on 12-12-9.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIGestureRecognizer (SummlyScrollerViewAdditions)

- (void)end;
- (BOOL)hasRecognizedValidGesture;
@end
