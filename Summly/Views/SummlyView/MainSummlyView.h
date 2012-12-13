//
//  MainSummlyView.h
//  Summly
//
//  Created by zzlmilk on 12-12-11.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemSummly.h"
@class FrontSummlyView,SummlyScrollView;

@interface MainSummlyView : UIScrollView
{
  

    
}

-(id)initWithFrame:(CGRect)frame summlyScrollView:(SummlyScrollView*)summlyScrollView AndFrontSummlyView:(FrontSummlyView*)frontView;


@property(nonatomic,strong)    SummlyScrollView * summlyScrollView;
@property(nonatomic,strong)      FrontSummlyView *frontView;
@end
