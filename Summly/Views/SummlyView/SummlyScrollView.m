//
//  SummlyScrollView.m
//  Summly
//
//  Created by zzlmilk on 12-12-8.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import "SummlyScrollView.h"
#import "ItemSummly.h"
#import "UIGestureRecognizer+SummlyScrollerViewAdditions.h"
#import "Summly.h"
#define  INVALID_POSITION -1
static const CGFloat kDefaultAnimationDuration = 0.3;
static const UIViewAnimationOptions kDefaultAnimationOptions = UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction;



@interface SummlyScrollView ()<UIGestureRecognizerDelegate>
{
    UILongPressGestureRecognizer *_longPressGesture;    
     NSInteger _sortFuturePosition;
    
    
    
    ItemSummly *_sortMovingItem;
    
    ItemSummly *_transformingItem;
    CGFloat _lastScale;
    BOOL _inFullSizeMode;
    BOOL _inTransformingState;
    
    
}

- (void)longPressGestureUpdated:(UILongPressGestureRecognizer *)longPressGesture;
-(void)itemSummlyDidMoveEndGestureRecongnzier:(UILongPressGestureRecognizer*)gestureRecognizer;
-(void)itemSummlyDidMovedGestureRecongnzier:(UILongPressGestureRecognizer*)gestureRecognizer;




-(NSInteger )itemPositionFromLocation:(CGPoint)point;
-(CGPoint )originForItemAtPosition:(NSInteger)position;


-(CGRect )_defaulItemSize:(NSInteger)index;
@end

@implementation SummlyScrollView

-(CGRect )_defaulItemSize:(NSInteger)index{
    return CGRectMake(self.itemSpacing, self.itemSpacing+index*(self.itemSize.height+self.itemSpacing), self.itemSize.width, self.itemSize.height);
}

-(void)generateItems{
    
    
    ItemSummly * homeItemSummly = [[ItemSummly alloc]initWithFrame:[self _defaulItemSize:0]];
    [self addSubview:homeItemSummly];
    [summlyItems addObject:homeItemSummly];

    
    
//    NSArray *colors = [NSArray arrayWithObjects:[UIColor orangeColor],[UIColor blackColor],[UIColor blueColor],[UIColor brownColor],[UIColor yellowColor], nil];
    for (int i =1; i<5;i++) {
        ItemSummly *item = [[ItemSummly alloc]initWithFrame:[self _defaulItemSize:i]];
        item.index =i;        
        //item.backgroundColor = [colors objectAtIndex:i];
        [self addSubview:item];
        [summlyItems addObject:item];
        self.contentSize = CGSizeMake(self.bounds.size.width,item.frame.size.height+item.frame.origin.y+self.itemSpacing);

    }
    
    for (int i =0 ; i<summlyItems.count; i++) {
        Summly *s = [[Summly alloc]init];
      [(ItemSummly *)[summlyItems objectAtIndex:i] setSummly:s];
    }


}



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
               
        
        self.showsVerticalScrollIndicator =NO;
        // Initialization code
        _longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressGestureUpdated:)];
        _longPressGesture.numberOfTouchesRequired = 1;
        _longPressGesture.delegate = self;
        [self addGestureRecognizer:_longPressGesture];
        
        summlyItems = [[NSMutableArray alloc]init];
        self.itemSize = CGSizeMake(320, 100);
        self.itemSpacing = 10;
        
        [self generateItems];
        
        


    }
    return self;
}

#pragma mark---  gestures

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    BOOL valid = YES;
    BOOL isScrolling = self.isDragging || self.isDecelerating;
    
     if (gestureRecognizer == _longPressGesture)
    {
        valid =  !isScrolling ;
    }
    
    return valid;
}




- (void)longPressGestureUpdated:(UILongPressGestureRecognizer *)gestureRecognizer{
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            [self itemSummlyDidMoveStartGestureRecongnzier:gestureRecognizer];
            
            break;
        case UIGestureRecognizerStateEnded:
            [self itemSummlyDidMoveEndGestureRecongnzier:gestureRecognizer];
            break;
        case UIGestureRecognizerStateFailed:
            NSLog(@"press long failed");
            break;
        case UIGestureRecognizerStateChanged:
            [self itemSummlyDidMovedGestureRecongnzier:gestureRecognizer];
            break;
        default:
            NSLog(@"press long else");
            break;
    }

}





//Private
-(void)itemSummlyDidMoveStartGestureRecongnzier:(UILongPressGestureRecognizer*)gestureRecognizer{
    
    CGPoint location = [gestureRecognizer locationInView:self];
    NSInteger position = [self itemPositionFromLocation:location];

    ItemSummly *item = [summlyItems objectAtIndex:position];
    [self bringSubviewToFront:item];
    
    _sortMovingItem = item;
    
   _sortFuturePosition = position; 
    
    
    CGRect frameInMainView = [self convertRect:_sortMovingItem.frame toView:self];
    [_sortMovingItem removeFromSuperview];
    _sortMovingItem.frame = frameInMainView;
    [self addSubview:_sortMovingItem];
    
    
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         _sortMovingItem.backgroundColor = [UIColor orangeColor];
                         _sortMovingItem.transform = CGAffineTransformScale(self.transform, 1.02,1.02);
                        //_sortMovingItem.layer.shadowOpacity = 0.7;
                     }
                     completion:nil
     ];
}


-(void)itemSummlyDidMovedGestureRecongnzier:(UILongPressGestureRecognizer*)gestureRecognizer{
    
    CGPoint point = [gestureRecognizer locationInView:self];
    int toIndex = [self itemPositionFromLocation:point];
    
    if (toIndex !=-1 || toIndex != _sortFuturePosition) {
        if (_sortMovingItem)
        {
            ItemSummly *itemSummly = [summlyItems objectAtIndex:toIndex];
            
            CGPoint origin = [self originForItemAtPosition:_sortFuturePosition];
                        
            [UIView animateWithDuration:kDefaultAnimationDuration
                                  delay:0
                                options:kDefaultAnimationOptions
                             animations:^{
                                 itemSummly.frame = CGRectMake(origin.x,origin.y, _itemSize.width, _itemSize.height);
                             }
                             completion:^(BOOL finished) {
                                 
                             }
             ];
            
            
           
            [summlyItems exchangeObjectAtIndex:_sortFuturePosition withObjectAtIndex:toIndex];
           _sortFuturePosition = toIndex;
            
        }
            
    }

    
}


-(void)itemSummlyDidMoveEndGestureRecongnzier:(UILongPressGestureRecognizer*)gestureRecognizer{
    
    
    CGRect frameInScroll = [self convertRect:_sortMovingItem.frame toView:self];
    
    [_sortMovingItem removeFromSuperview];
    _sortMovingItem.frame = frameInScroll;
    [self addSubview:_sortMovingItem];
    
        
                
    CGPoint newOrigin = [self originForItemAtPosition:_sortFuturePosition];
    
    CGRect newFrame = CGRectMake(newOrigin.x, newOrigin.y, _itemSize.width, _itemSize.height);
    
    
    [UIView animateWithDuration:kDefaultAnimationDuration
                          delay:0
                        options:0
                     animations:^{
                         _sortMovingItem.transform = CGAffineTransformIdentity;
                        
                         _sortMovingItem.frame = newFrame;
                     }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:0.3
                                               delay:0
                                             options:UIViewAnimationOptionAllowUserInteraction
                                          animations:^{
                                              _sortMovingItem.backgroundColor = [UIColor redColor];
                                              // cell.contentView.layer.shadowOpacity = 0;
                                          }
                                          completion:nil
                          ];
                         

                     }
     ];

    
}

-(CGPoint )originForItemAtPosition:(NSInteger)position{
    
    CGPoint origin = CGPointZero;
    
    
    origin.x = self.itemSpacing;
    origin.y = self.itemSpacing+position*(self.itemSpacing+self.itemSize.height);
    
    
    return origin;

}

-(NSInteger )itemPositionFromLocation:(CGPoint)point{
    
    NSInteger row =  point.y / (self.itemSize.height + self.itemSpacing);
    
    NSInteger index = row;
    
    
    return index;
}



@end
