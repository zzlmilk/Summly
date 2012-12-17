//
//  DetailScrollViewController.h
//  Summly
//
//  Created by zoe on 12-12-17.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Summly.h"

@interface DetailScrollViewController : UIViewController
{
    
    UIScrollView *scrollView;
    
    UISwipeGestureRecognizer *swipUpGesture;  //up to back 

}

+(id)sharedInstance;
- (void)setScrollOffset:(NSInteger)index;

@property(nonatomic,strong) NSArray *summlyArr;
@property(nonatomic) NSInteger index;
@end
