//
//  UIGestureRecognizer+SummlyScrollerViewAdditions.m
//  Summly
//
//  Created by zzlmilk on 12-12-9.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import "UIGestureRecognizer+SummlyScrollerViewAdditions.h"

@implementation UIGestureRecognizer (SummlyScrollerViewAdditions)

-(void)end{
    
    BOOL currentStatus = self.enabled;
    self.enabled = NO;
    self.enabled = currentStatus;
}
-(BOOL)hasRecognizedValidGesture{
    return (self.state == UIGestureRecognizerStateChanged || self.state == UIGestureRecognizerStateBegan);
}
@end
