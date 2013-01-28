//
//  FrontSummlyView.h
//  Summly
//
//  Created by zzlmilk on 12-12-11.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//  mars here

#import <UIKit/UIKit.h>
#import "Summly.h"


@protocol FrontSummlyViewDelegate <NSObject>
-(void)backbuttonDidSelect;
-(void)pushToDetailVCDelegate;
@end

@interface FrontSummlyView : UIView

@property(nonatomic,weak)id delegate;
@property(nonatomic,strong) Summly *summly;

@end
