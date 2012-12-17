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

}
@property(nonatomic,strong) NSArray *summlyArr;
@end
