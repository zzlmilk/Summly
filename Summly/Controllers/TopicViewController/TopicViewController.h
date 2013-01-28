//
//  TopicViewController.h
//  Summly
//
//  Created by zzlmilk on 12-12-13.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "ItemSummly.h"


@interface TopicViewController : BaseViewController<ItemSummlyActionDelegate>{
    UIScrollView *scrollView;
    
    UIButton *imgTutorials1Button;
    UIButton *imgTutorials2Button;
    UIButton *imgTutorials3Button;
}

+(id)sharedInstance;

@property(nonatomic,strong) NSArray *topicsArr;

@end
