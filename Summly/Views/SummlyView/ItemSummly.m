//
//  ItemSummly.m
//  Summly
//
//  Created by zzlmilk on 12-12-8.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import "ItemSummly.h"
#import <QuartzCore/QuartzCore.h>

@interface ItemSummly() <UIGestureRecognizerDelegate, UIScrollViewDelegate>
{
    
    //gesture
    UITapGestureRecognizer       *_tapGesture;
    UISwipeGestureRecognizer     *_swipGesture;
    UIPanGestureRecognizer       *_panLeftGesture;
    
    
    // Transforming control vars
        CGFloat _lastScale;
    BOOL _inFullSizeMode;  //进度模式
    

}

//Gestures
- (void)tapGesture:(UITapGestureRecognizer *)tapGesture;

// Transformation control

@end

@implementation ItemSummly

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
               
        [self commonInit];
        
        
        bgImageView= [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 100)];
        bgImageView.image = [UIImage imageNamed:@"cell-keyword@2x"];
        [self addSubview:bgImageView];
        
              
                    
        
        titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 45, 300, 20)];
        titleLabel.text = @"titile";
        titleLabel.font = [UIFont systemFontOfSize:18];
        titleLabel.backgroundColor = [UIColor clearColor];
        [bgImageView addSubview:titleLabel];
        
        
        
        describeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 65, 300, 20)];
        describeLabel.text = @"describeLabel";
        describeLabel.font = [UIFont systemFontOfSize:16];
        describeLabel.backgroundColor = [UIColor clearColor];
        [bgImageView addSubview:describeLabel];
        
        
        
      
        
        /*
        layer1 = [[CALayer alloc]init];
        layer1.frame = view.bounds;
        [view.layer insertSublayer:layer1 atIndex:0];
        itemColorRef = layer1.backgroundColor;
        
        layer2 = [[CALayer alloc]init];
        layer2.frame = CGRectMake(0, 0, 0, 100);
        layer2.backgroundColor = itemColorRef;
        [view.layer insertSublayer:layer2 atIndex:0];
        
        */
        
        
                    
    }
    return self;
}

- (void)commonInit{
    
    self.showsHorizontalScrollIndicator =NO;
    self.delegate =self;
    
    
    _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    _tapGesture.delegate = self;
    [self addGestureRecognizer:_tapGesture];
    


    
    self.itemContentSize = CGSizeMake(400, 100);
    self.maxOffset = 60;
    self.contentSize = self.itemContentSize;
    self.index = 0;
    self.canRefish =YES;
    self.canMove  =YES;
    
    
   // self.bgroundColor =[UIColor colorWithRed:0.584 green:0.875 blue:0.200 alpha:1.0];
    
    // Transforming control vars
    

    _lastScale = 1.0;
    
}


-(void)reloadSummly{
    NSLog(@"reload");
    
    //overBgImageView.frame =CGRectMake(-300, 0, 300,100);
    bgImageView.image = [UIImage imageNamed:@"action-cell"];
    
    CALayer *layerProcess = [[CALayer alloc]init];
    
    
    
}


#pragma mark---  gestures
- (void)tapGesture:(UITapGestureRecognizer *)tapGesture{
    if( [self.actionDelegate respondsToSelector:@selector(ItemSummlydidTap:)]){
        [self.actionDelegate ItemSummlydidTap:self];
    }
}



#pragma mark --- UIScrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if( scrollView.contentOffset.x <= -self.maxOffset){
        
        [self reloadSummly];
    }
}

//这个事件只是为了阻住swrollerview往左移动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x > 0) {
        [scrollView setContentOffset:CGPointMake(0, scrollView.contentOffset.y)];
    }
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    return self.canRefish;
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
