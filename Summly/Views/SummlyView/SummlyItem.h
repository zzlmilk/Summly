//
//  SummlyItem.h
//  SinaPhotoWall
//
//  Created by zzlmilk on 12-12-3.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol SummlyItemDelegate;
@interface SummlyItem : UIScrollView<UIGestureRecognizerDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate>
{
    UIButton *summlyButton;
    CGPoint point; //long press point
}



@property(nonatomic,strong) UIPanGestureRecognizer *panGesture;

@property (assign, nonatomic) CGFloat maxOffset;
@property (assign, nonatomic) CGFloat concealViewTriggerWidth;
@property (assign, nonatomic) CGFloat quickFlickVelocity;
@property (assign, nonatomic) NSTimeInterval toggleAnimationDuration;

@property(nonatomic)BOOL canMoving;
@property(nonatomic) BOOL isEditing;
@property (nonatomic)NSInteger index;
@property(nonatomic,strong) NSString *unReadCount;
@property (nonatomic,unsafe_unretained)id delegate;

-(id)initWithFrame:(CGRect)frame title:(NSString *)aTitle subTitle:(NSString *)subTitle atIndex:(NSInteger)atIndex;

-(void)enableMoving;
-(void)disableMoving;

@end



@protocol SummlyItemDelegate <NSObject>
//-(void)summlyItemDidSwip:(SummlyItem *)summlyItem;
@required
-(void)summlyItemDidClicked:(SummlyItem*)summlyItem;

-(void)summlyItemDidEnterEditingMode:(SummlyItem*)summlyItem;
-(void)summlyItemDidMoved:(SummlyItem *)summlyItem withLocation:(CGPoint)point moveGestureRecongnzier:
(UILongPressGestureRecognizer*)recognizer;
-(void)summlyItemDidEndMoved:(SummlyItem *)summlyItem withLocation:(CGPoint)point moveGestureRecongnzier:
(UILongPressGestureRecognizer*)recognizer;
@end

