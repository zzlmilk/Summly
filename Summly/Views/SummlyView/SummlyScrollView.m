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
#import "Topic.h"

#import "BundleHelp.h"

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
-(void)itemSummlyDidMoveStartGestureRecongnzier:(UILongPressGestureRecognizer*)gestureRecognizer;



-(NSInteger )itemPositionFromLocation:(CGPoint)point;
-(CGPoint )originForItemAtPosition:(NSInteger)position;


-(CGRect )_defaulItemSize:(NSInteger)index;
@end


@implementation SummlyScrollView

-(CGRect )_defaulItemSize:(NSInteger)index{
    return CGRectMake(self.itemSpacing, self.itemSpacing+index*(self.itemSize.height+self.itemSpacing), self.itemSize.width, self.itemSize.height);
}

-(void)generateItems:(NSMutableArray *)topics{
    
    [self.summlyItems removeAllObjects];
        
    Topic *homeTopic = [[Topic alloc]init];
    homeTopic.title = @"封面页   CoverPage";
    homeTopic.subTitle=@"向右扫动刷新所有内容";
    homeTopic.status = 0;
    
    
    
    ItemSummly * homeItemSummly = [[ItemSummly alloc]initWithFrame:[self _defaulItemSize:0]] ;
    homeItemSummly.index = 0;
    homeItemSummly.topic  = homeTopic;
    homeItemSummly.itemSummlyType  = home;
    homeItemSummly.actionDelegate = delegate;
    homeItemSummly.userInteractionEnabled=YES;
    [self addSubview:homeItemSummly];
    [self.summlyItems addObject:homeItemSummly];
    
    for (int i=0;i<  topics.count ;i++) {
        ItemSummly *item = [[ItemSummly alloc]initWithFrame:[self _defaulItemSize:i+1]];
        item.index =i+1;
        item.topic = [topics objectAtIndex:i];
        item.itemSummlyType=approve;
        item.actionDelegate =delegate;
        [self addSubview:item];
        [self.summlyItems addObject:item];
    }
    
    NSArray *summlys = [Summly summlysFaviWithParameters];
    if ([summlys count]>0) {
        Topic *starTopic = [[Topic alloc]init];
        starTopic.title = @"已保存摘要";
        starTopic.subTitle=@"Saved Summary";
        starTopic.status = 0;
        
        ItemSummly *starSummly = [[ItemSummly alloc] initWithFrame:[self _defaulItemSize:self.summlyItems.count]];
        starSummly.index=self.summlyItems.count;
        starSummly.topic  = starTopic;
        starSummly.itemSummlyType=saved;
        starSummly.actionDelegate =delegate;
        [self addSubview:starSummly];
        [self.summlyItems addObject:starSummly];
    }
    
    Topic *addtopic = [[Topic alloc]init];
    addItemSummly = [[ItemSummly alloc]initWithFrame:[self _defaulItemSize:self.summlyItems.count]];
    addItemSummly.index=self.summlyItems.count;
    addItemSummly.itemSummlyType = add;
    addItemSummly.topic  = addtopic;
    addItemSummly.actionDelegate =delegate;
    [self addSubview:addItemSummly];
    [self.summlyItems addObject:addItemSummly];
    
    
    self.contentSize = CGSizeMake(self.bounds.size.width,addItemSummly.frame.size.height+addItemSummly.frame.origin.y+self.itemSpacing);    
}

-(BOOL)isHaveSavedItemSummly{

    NSString *filename = [BundleHelp getBundlePath:SUMMLY_NAME];
    NSArray *arr = [NSArray arrayWithContentsOfFile:filename];

    if (arr.count>0) {
        return YES;
    }
    return NO;
}

-(void)generateOneItem:(Topic *)topic{
     //add item is the last item
    ItemSummly *itemSummly = [[ItemSummly alloc]initWithFrame:[self _defaulItemSize:self.summlyItems.count-1]];
    itemSummly.topic =topic;
    itemSummly.actionDelegate = delegate;
    itemSummly.index = self.summlyItems.count-1;
    [self addSubview:itemSummly];
    [self.summlyItems insertObject:itemSummly atIndex:self.summlyItems.count];
    
    
    //move add item
    addItemSummly.index=1;
    [UIView animateWithDuration:0.2f animations:^{
        [addItemSummly setFrame:[self _defaulItemSize:addItemSummly.index]];
    }];
    
    self.contentSize = CGSizeMake(self.bounds.size.width,addItemSummly.frame.size.height+addItemSummly.frame.origin.y+self.itemSpacing);
    
    
    if (self.contentSize.height - self.bounds.size.height>0) {
        [self setContentOffset:CGPointMake(0, self.contentSize.height - self.bounds.size.height) animated:YES];
    }
    
    /*
     In Your case,[myscroll scrollRectToVisible:myview.frame animated:YES]; will not work because of myview is a sub-view of myscroll. myview.frame will return the CGRect which is only related to the myscroll.
     [self scrollRectToVisible:CGRectMake(self.frame.origin.x, self.frame.origin.y+itemSummly.index * itemSummly.frame.size.height,self.frame.size.width, self.frame.size.height) animated:YES];
     */


}


-(void)removeItem:(Topic *)topic{
    [self.summlyItems removeObject:topic];
    [self restUI];
}

-(void)restUI{
    for (UIView *v in self.subviews) {
        if ([v isKindOfClass:[ItemSummly class]]) {
            [v removeFromSuperview];
        }
    }
    
    [self.summlyItems removeAllObjects];
    [self setContentSize:CGSizeMake(self.bounds.size.width,0)];
}




- (id)initWithFrame:(CGRect)frame delegate:(id)Adelegate
{
    self = [super initWithFrame:frame];
    if (self) {
        delegate = Adelegate;
        
        self.backgroundColor = [UIColor clearColor];
        self.showsVerticalScrollIndicator =NO;
        // Initialization code
        _longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressGestureUpdated:)];
        _longPressGesture.numberOfTouchesRequired = 1;
        _longPressGesture.delegate = self;
        [self addGestureRecognizer:_longPressGesture];
        
        _summlyItems = [[NSMutableArray alloc]init];
        self.itemSize = CGSizeMake(320, 100);
        self.itemSpacing = 10;
        
        
        //[self generateItems];
        
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




//Private
-(void)itemSummlyDidMoveStartGestureRecongnzier:(UILongPressGestureRecognizer*)gestureRecognizer{
    
    CGPoint location = [gestureRecognizer locationInView:self];
    NSInteger position = [self itemPositionFromLocation:location];
    ItemSummly *item = [_summlyItems objectAtIndex:position];
    if (!item.canMove) {
        return;
    }
    
    
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
                         //_sortMovingItem.backgroundColor = [UIColor orangeColor];
                         _sortMovingItem.transform = CGAffineTransformScale(self.transform, 1.02,1.02);
                         //_sortMovingItem.layer.shadowOpacity = 0.7;
                     }
                     completion:nil
     ];
}


-(void)itemSummlyDidMovedGestureRecongnzier:(UILongPressGestureRecognizer*)gestureRecognizer{
    
    CGPoint point = [gestureRecognizer locationInView:self];
    int toIndex = [self itemPositionFromLocation:point];
    ItemSummly *item = [_summlyItems objectAtIndex:toIndex];
    if (!item.canMove) {
        return;
    }
    
    if (toIndex !=-1 || toIndex != _sortFuturePosition) {
        if (_sortMovingItem)
        {
            ItemSummly *itemSummly = [_summlyItems objectAtIndex:toIndex];
            
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
            
            
            NSLog(@"Moving from--%d toIndex--%d",_sortFuturePosition,toIndex);
            if (_sortFuturePosition != toIndex) {
                [self changePlistAccordingToLocationFrom:(_sortFuturePosition-1) to:(toIndex-1)];
            }
            
            [_summlyItems exchangeObjectAtIndex:_sortFuturePosition withObjectAtIndex:toIndex];
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
                                              //  _sortMovingItem.backgroundColor = [UIColor redColor];
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

//交换位置
- (void)changePlistAccordingToLocationFrom:(NSInteger)currentIndex to:(NSInteger)toIndex{
    
    NSDictionary *dic = [BundleHelp getDictionaryFromPlist:Plist];
    NSMutableArray *arr = [NSMutableArray arrayWithArray:[dic objectForKey:@"topics"]];
    
    NSMutableDictionary *dicFrom =  [NSMutableDictionary dictionaryWithDictionary:[[arr objectAtIndex:currentIndex] objectForKey:@"topic"]];
    NSMutableDictionary *dicTo =  [NSMutableDictionary dictionaryWithDictionary:[[arr objectAtIndex:toIndex] objectForKey:@"topic"]];

    [arr removeObjectAtIndex:currentIndex];
    [arr removeObjectAtIndex:toIndex];

    [arr insertObject:[NSDictionary dictionaryWithObject:dicFrom forKey:@"topic"] atIndex:toIndex];
    [arr insertObject:[NSDictionary dictionaryWithObject:dicTo forKey:@"topic"] atIndex:currentIndex];

    NSMutableDictionary *lastDic = [NSMutableDictionary dictionaryWithObject:arr forKey:@"topics"];
    
    NSData *dicData = [NSPropertyListSerialization dataFromPropertyList:lastDic format:NSPropertyListXMLFormat_v1_0 errorDescription:nil];
    [dicData writeToFile:[BundleHelp getBundlePath:Plist] atomically:YES];
}


@end
    