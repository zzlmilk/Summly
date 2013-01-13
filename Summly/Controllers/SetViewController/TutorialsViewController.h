//
//  TutorialsViewController.h
//  Summly
//
//  Created by Mars on 13-1-12.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TutorialsViewController : UIViewController<UIScrollViewDelegate> {
	UIScrollView *scrollView;
	UIPageControl *pageControl;
	
	//id<PagePhotosDataSource> dataSource;
	NSMutableArray *imageViews;
	
	// To be used when scrolls originate from the UIPageControl
    BOOL pageControlUsed;
}

@property (nonatomic, strong) NSMutableArray *imageViews;


- (IBAction)changePage:(id)sender;
@end
