//
//  SummlyDetailView.h
//  Summly
//
//  Created by zoe on 12-12-17.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import<Foundation/Foundation.h>

#import <UIKit/UIKit.h>
#import "Summly.h"


#import "FAFancyMenuView.h"
#import "FAFancyMenuViewDataSource.h"

#import "DDShare.h"

#import "DDWeixing.h"

@protocol SummlyDetailViewDelegate<NSObject>

-(void)detailViewControllerDidPushToWebViewController;

@end

@interface SummlyDetailView : UIView<FAFancyMenuViewDelegate>
{
    FAFancyMenuViewDataSource *faFancyMenuDataSource;
    NSMutableArray *mutableArr;
    DDShare *sinaShare;
    DDWeixing *weixingShare;
    BOOL isFavorite;
    NSArray *imagesSave,*imagesUnSave;
}

@property(nonatomic,strong) UIView *titleBg;
@property(nonatomic,strong) UIView *acticleView;
@property(nonatomic,strong) UIImageView *imageBackView;
@property(nonatomic,strong) Summly *summly;
@property(nonatomic,strong)  FAFancyMenuView *menu;
@property(nonatomic,weak) UIViewController *controller;
@property(nonatomic) id<SummlyDetailViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame summly:(Summly *)summly;
- (void)dismissDetailViewAnimate:(void (^)())block;
- (void)showDetailViewAnimate;
@end
