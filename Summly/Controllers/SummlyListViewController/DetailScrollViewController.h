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
#import "FAFancyMenuViewDataSource.h"
#import "SummlyDetailView.h"


#import "ArticleView.h"
#import "UpScrollView.h"

typedef enum {
   leftOrentation  = 0,
   rightOrentation  = 1,
} FingerSwipOrientation;


@interface DetailScrollViewController : UIViewController<UIScrollViewDelegate,ArticleViewControllerDelegate>
{
    
    UIScrollView *bgScrollView;
    
    
    NSDictionary *userInfo;
    NSArray *statuses;
    NSString *postStatusText;
    NSString *postImageStatusText;
    
  
    UpScrollView *upScrollView;
    NSInteger _indexLeft,_indexRight;
    
    float lastOffsetX;
    
    FingerSwipOrientation orientation;
    float origin;
    BOOL scrollKey;
}

+(id)sharedInstance;

- (void)setScrollOffset:(NSInteger)index;
@property(nonatomic,strong)     UIScrollView *scrollView;
@property(nonatomic,strong) NSArray *summlyArr;
@property(nonatomic) NSInteger index;
@end
