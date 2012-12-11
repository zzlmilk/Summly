//
//  SummlyItem.m
//  SinaPhotoWall
//
//  Created by zzlmilk on 12-12-3.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import "SummlyItem.h"
#import <QuartzCore/QuartzCore.h>
#import "SummlyViewController.h"

#define  kAlpha 0.5f
#define kLeftMargin 10
#define kTopMarin 30
#define kContentSizeWith 350
#define kDefaultSummlyRect  CGRectMake(10, 10, 300, 80)

@interface SummlyItem ()

-(void)panGestureAnimationWithDuration:(NSTimeInterval)duration;
- (void)concealAnimationWithDuration:(NSTimeInterval)duration;

- (CGFloat)calculateOffsetForTranslationInView:(CGFloat)x;
- (void)_handleGestureStateBeganWithRecognizer:(UIPanGestureRecognizer *)recognizer;
- (void)_handleGestureStateChangedWithRecognizer:(UIPanGestureRecognizer *)recognizer;
- (void)_handleGestureStateEndedWithRecognizer:(UIPanGestureRecognizer *)recognizer;

@end

@implementation SummlyItem

-(id)initWithFrame:(CGRect)frame title:(NSString *)aTitle subTitle:(NSString *)aSubTitle atIndex:(NSInteger)atIndex{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.maxOffset = 100;
        self.toggleAnimationDuration=0.3f;
        self.quickFlickVelocity =1300.0f;
        self.concealViewTriggerWidth = 100;
                        
        self.index = atIndex;
        self.isEditing =NO;
        self.canMoving =YES;
        self.userInteractionEnabled = YES;
        
        self.backgroundColor = [UIColor blueColor];
        self.alpha = kAlpha;
        
        
        
        
        /*
        summlyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        summlyButton.clipsToBounds =YES;
        summlyButton.alpha = kAlpha;
        [summlyButton addTarget:self action:@selector(summlyButtonPress) forControlEvents:UIControlEventTouchUpInside];
        [summlyButton setBackgroundColor:[UIColor blueColor]];
        summlyButton.frame =CGRectMake(0, 0, 300, self.bounds.size.height);
        summlyButton.userInteractionEnabled =YES;
        [self addSubview:summlyButton];
         */
        
        
        
        
      
        
        
        UILongPressGestureRecognizer *longPressGesture =[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(pressedLong:)];
        [self addGestureRecognizer:longPressGesture];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(kLeftMargin, kTopMarin, 200, 20)];
        titleLabel.text =aTitle;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.userInteractionEnabled =YES;
        [self addSubview:titleLabel];
        
        UILabel *subTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(kLeftMargin, kTopMarin+20, 200, 20)];
        subTitleLabel.text = aSubTitle;
        subTitleLabel.backgroundColor = [UIColor clearColor];
        subTitleLabel.userInteractionEnabled =YES;
        [self addSubview:subTitleLabel];
        
        
        
        _panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self                                                                                    action:@selector(revealGesture:)];
        _panGesture.delegate =self;
        [self addGestureRecognizer:_panGesture];
        
        
        
        UIPanGestureRecognizer *panGestureRecognizer = nil;
        if ([self respondsToSelector:@selector(panGestureRecognizer)]) {
            panGestureRecognizer = self.panGestureRecognizer;
        }
        
        [panGestureRecognizer setMaximumNumberOfTouches:1];
        [panGestureRecognizer requireGestureRecognizerToFail:_panGesture];
        
        
        
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
        tapGestureRecognizer.numberOfTapsRequired =1;
        [self addGestureRecognizer:tapGestureRecognizer];
        [tapGestureRecognizer requireGestureRecognizerToFail:_panGesture];
        
        //self.userInteractionEnabled =NO;
        
      
        
        }
    return self;
}

-(void)swipnGestureRecognizer:(UISwipeGestureRecognizer*)gestureRecognizer
{
 
    NSLog(@"swipnGestureRecognizer");
}

-(void)tapGesture:(UITapGestureRecognizer*)gestureRecognizer{
    NSLog(@"tap");
    [self   summlyButtonPress];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
       shouldReceiveTouch:(UITouch *)touch {
    
    if ([touch.view isKindOfClass:[UIButton class]]) {
        return NO;
    }
    return YES;
}




#pragma mark--  Private
-(void)panGestureAnimationWithDuration:(NSTimeInterval)duration{
    [UIView animateWithDuration:duration delay:0.2f options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.frame = CGRectMake(self.maxOffset, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        // NSLog(@"finish");
        //异步加载网络 并加上进度    
        [self concealAnimationWithDuration:self.toggleAnimationDuration];
    }];
}


-(void)panGestureAnimationLittleWithDuration:(NSTimeInterval)duration x:(CGFloat)x{
    [UIView animateWithDuration:duration delay:0.0f options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.frame = CGRectMake(x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        
    }];
    
    
    [UIView animateWithDuration:duration delay:0.f options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.frame = CGRectMake(10, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        // NSLog(@"finish");
    }];

}

- (void)concealAnimationWithDuration:(NSTimeInterval)duration {
    //改变summly的颜色
    [UIView animateWithDuration:duration delay:0.0f options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.frame = CGRectMake(10, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        // NSLog(@"finish");
    }];
    

}



//UIPanGestureRecognizer:触摸并拖拽。
-(void)revealGesture:(UIPanGestureRecognizer *)recognize{
    switch ([recognize state]) {
        case UIGestureRecognizerStateBegan:
            [self _handleGestureStateBeganWithRecognizer:recognize];
            break;
        case UIGestureRecognizerStateChanged:
            [self _handleGestureStateChangedWithRecognizer:recognize];
        case UIGestureRecognizerStateEnded:
            [self _handleGestureStateEndedWithRecognizer:recognize];
        default:
            break;
    }
    
}



-(void)_handleGestureStateBeganWithRecognizer:(UIPanGestureRecognizer *)recognizer{
   NSLog(@"gestureStateBegan");

   
}

-(void)_handleGestureStateChangedWithRecognizer:(UIPanGestureRecognizer *)recognizer{
    //往右拖动
    if( [recognizer translationInView:self].x >0.0f){
         float offset = [self calculateOffsetForTranslationInView:[recognizer translationInView:self].x];
         self.frame= CGRectMake(offset, self.frame.origin.y, self.frame.size.width,self.frame.size.height);
    }
    
    
}
-(void)_handleGestureStateEndedWithRecognizer:(UIPanGestureRecognizer *)recognizer{
    
    
    
    if (self.frame.origin.x >=self.concealViewTriggerWidth) {
        [self panGestureAnimationWithDuration:self.toggleAnimationDuration];
    }
    else{
        
        [self panGestureAnimationLittleWithDuration:self.toggleAnimationDuration x:self.frame.origin.x];
        
    }

    
    
    //拖拽速度超过指定的速度 吃饱饭去判断吧
    if (fabs([recognizer velocityInView:self].x) > self.quickFlickVelocity){
        if ([recognizer velocityInView:self].x > 0.0f)//正方向拖拽
		{
           // [self panGestureAnimationWithDuration:self.toggleAnimationDuration];
		}

    }
    else{

           }
}




-(CGFloat)calculateOffsetForTranslationInView:(CGFloat)x{
    
    CGFloat result;
    if (x<self.maxOffset) {
        result =x+10;
    }
    else
	{
		result = self.maxOffset;
	}
    return result;
}



- (void) pressedLong:(UILongPressGestureRecognizer *) gestureRecognizer{
    
    if (self.canMoving ==NO) {
        return;
    }
    
    
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            point = [gestureRecognizer locationInView:self];
            [self.delegate summlyItemDidEnterEditingMode:self];
            break;
        case UIGestureRecognizerStateEnded:
            point =[gestureRecognizer locationInView:self];
            [self.delegate summlyItemDidEndMoved:self withLocation:point moveGestureRecongnzier:gestureRecognizer];
            break;
        case UIGestureRecognizerStateFailed:
            NSLog(@"press long failed");
            break;
        case UIGestureRecognizerStateChanged:
            [self.delegate summlyItemDidMoved:self withLocation:point moveGestureRecongnzier:gestureRecognizer];
            break;
        default:
            NSLog(@"press long else");
            break;
    }
}


-(void)summlyButtonPress{
    [self.delegate summlyItemDidClicked:self];
}



#pragma mark - Custom Methods
-(void)enableMoving{
    
    if (self.canMoving == NO) {
        return;
    }
    
    if (self.isEditing==YES) {
        return;
    }
    self.isEditing =YES;
    
    [summlyButton setEnabled:NO];
    
    
    
   [UIView animateWithDuration:0.2 animations:^{
       self.transform = CGAffineTransformMakeScale(1.05f, 1);
   }];
    
    
}

-(void)disableMoving{   
    [UIView animateWithDuration:0.2 animations:^{
        self.frame = CGRectMake(10, self.frame.origin.y, 300, self.frame.size.height);
      
    }];
    
    [summlyButton setEnabled:YES];
    self.isEditing =NO;
}













/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
