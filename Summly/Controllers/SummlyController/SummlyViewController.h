//
//  SummlyViewController.h
//  SinaPhotoWall
//
//  Created by zzlmilk on 12-12-3.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SummlyItem.h"
#import "CustomerSrollView.h"
#import "ItemSummly.h"

@interface SummlyViewController : UIViewController<SummlyItemDelegate,UIGestureRecognizerDelegate>
{
    
    NSMutableArray *summlyItems;
    SummlyItem * homeSummlyItem;
    SummlyItem * addSummlyItem;    
    BOOL isMoving;
}

@property(nonatomic,strong) CustomerSrollView *scrollView;
-(void)addSummlyItem;

@end
