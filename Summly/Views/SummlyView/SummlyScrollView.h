//
//  SummlyScrollView.h
//  Summly
//
//  Created by zzlmilk on 12-12-8.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SummlyScrollViewSource;
@class ItemSummly;
@class Topic;
@interface SummlyScrollView : UIScrollView
{
    
    id delegate;
    
    ItemSummly * addItemSummly;
}

//@property (nonatomic, weak) id<SummlyScrollViewSource> dataSource;

-(id)initWithFrame:(CGRect)frame delegate:(id)Adelegate;




@property(nonatomic) CGSize itemSize;
@property(nonatomic) NSInteger itemSpacing;

@property(nonatomic,strong)NSMutableArray *summlyItems;    

-(void)generateItems:(NSMutableArray *)topics;

-(void)generateOneItem:(Topic*)topic;

-(void)restUI;
// Actions
-(void)itemSummlyDidMoveStartGestureRecongnzier:(UILongPressGestureRecognizer*)gestureRecognizer;

@end

@protocol SummlyScrollViewSource <NSObject>
// Populating subview items
- (NSInteger)numberOfItemsInSummlyScrollView:(SummlyScrollView *)summlyScrollView;
- (ItemSummly *)SummlyScrollView:(SummlyScrollView *)summlyScrollView itemForItemAtIndex:(NSInteger)index;

@end

