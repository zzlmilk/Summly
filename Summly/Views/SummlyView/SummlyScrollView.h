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

@interface SummlyScrollView : UIScrollView
{
    NSMutableArray *summlyItems;
   
    
}

//@property (nonatomic, weak) id<SummlyScrollViewSource> dataSource;


@property(nonatomic) CGSize itemSize;
@property(nonatomic) NSInteger itemSpacing;



// Actions


@end

@protocol SummlyScrollViewSource <NSObject>
// Populating subview items
- (NSInteger)numberOfItemsInSummlyScrollView:(SummlyScrollView *)summlyScrollView;
- (ItemSummly *)SummlyScrollView:(SummlyScrollView *)summlyScrollView itemForItemAtIndex:(NSInteger)index;

@end

