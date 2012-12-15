//
//  ItemSummly.h
//  Summly
//
//  Created by zzlmilk on 12-12-8.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ItemSummlyActionDelegate;
//@class Summly;
@class Topic;

typedef enum {
    keywordEmpty = 0,
    keywordUnsubscribed=1,
    keyword = 2,
    predefinedUnsubscribed = 3,
    saved = 4,
    home = 5,
    add = 6,
} ItemSummlyType;  //不同的类型有不同的背景图片


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


@property(nonatomic,strong)Topic *topic;

@property(nonatomic)ItemSummlyType  itemSummlyType;

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
