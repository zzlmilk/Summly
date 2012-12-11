//
//  ItemSummly.h
//  Summly
//
//  Created by zzlmilk on 12-12-8.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ItemSummlyActionDelegate;
@class Summly;
@interface ItemSummly : UIScrollView
{
    UILabel *titleLabel;
    UILabel *describeLabel;
    
    UIImageView *bgImageView;
    UIImageView *overBgImageView;
    
    
    CGColorRef itemColorRef;
    CALayer *layer1;
    CALayer *layer2;
}


@property(nonatomic,strong)Summly *summly;

@property(nonatomic)NSInteger index;
@property(nonatomic)BOOL canRefish;  //是否可拖拉刷新 default Yes
@property(nonatomic)BOOL canMove;    //是否可移动    default Yes


@property (nonatomic, weak) id<ItemSummlyActionDelegate>  actionDelegate;
@property(nonatomic)CGSize itemContentSize;   //default (400,100)
@property(nonatomic)NSInteger maxOffset;


-(void)reloadSummly;

@end

#pragma mark Protocol ItemSummlyActionDelegate
@protocol ItemSummlyActionDelegate <NSObject>

-(void)ItemSummlydidTap:(ItemSummly * )itemSummly;

@end
