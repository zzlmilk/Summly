//
//  DetailScrollViewController.h
//  Summly
//
//  Created by zoe on 12-12-17.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Summly.h"
#import "FAFancyMenuView.h"

@interface DetailScrollViewController : UIViewController<FAFancyMenuViewDelegate>
{
    
    UIScrollView *scrollView;
    
    UISwipeGestureRecognizer *swipUpGesture;  //up to back 

}
@property(nonatomic,strong) NSArray *summlyArr;
@end
