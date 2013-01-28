//
//  TutorialsViewController.h
//  Summly
//
//  Created by Mars on 13-1-12.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    isMaiVC=0,
    isSummyListVC = 1,
    isSetVC =2
} isTutorialEnd;

@interface TutorialsViewController : UIViewController<UIScrollViewDelegate> {
	UIScrollView *scrollView;
	UIPageControl *pageControl;
	
	//id<PagePhotosDataSource> dataSource;
	NSMutableArray *imageViews;
	
	// To be used when scrolls originate from the UIPageControl
    BOOL pageControlUsed;
    int kNumberOfPages;
}

@property (nonatomic, strong) NSMutableArray *imageViews;
@property(nonatomic) isTutorialEnd tutorialEnd;


- (IBAction)changePage:(id)sender;
@end
