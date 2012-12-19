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
#import "ArticleViewController.h"

@interface DetailScrollViewController : UIViewController<FAFancyMenuViewDelegate,UIScrollViewDelegate,ArticleViewControllerDelegate>
{
    
    UIScrollView *scrollView;
    

}

+(id)sharedInstance;
- (void)setScrollOffset:(NSInteger)index;

@property(nonatomic,strong) NSArray *summlyArr;
@property(nonatomic) NSInteger index;
@end
