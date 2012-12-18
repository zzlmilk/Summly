//
//  ItemSummly.m
//  Summly
//
//  Created by zzlmilk on 12-12-8.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import "ItemSummly.h"
#import <QuartzCore/QuartzCore.h>
#import "Topic.h"
#import "SVProgressHUD.h"



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




-(void)setTopic:(Topic *)topic{
    _topic = topic;
    
    [titleLabel setText:_topic.title];
    [describeLabel setText:_topic.subTitle];
    
}

-(void)setItemSummlyType:(ItemSummlyType)itemSummlyType{
    _itemSummlyType= itemSummlyType;
    
    switch (self.itemSummlyType) {
        case home:
        {
            self.canMove = NO;
            bgImageView.image = [UIImage imageNamed:@"cell-cover-page@2x"];
            
        }
            break;
        case add:
        {
            self.canMove = NO;
            bgImageView.image = [UIImage imageNamed:@"action-cell@2x"];
            UIImageView *addImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cell-add-icon@2x"]];
            addImageView.frame =CGRectMake(self.frame.size.width/2-34/2, self.frame.size.height/2-34/2, 34, 34);
            [bgImageView addSubview:addImageView];
        }
            break;
        default:
            break;
    }

}

-(void)_initVoice{
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"sms-received6"
                                                withExtension: @"caf"];
    
    // Store the URL as a CFURLRef instance
    soundFileURLRef = (__bridge CFURLRef) tapSound ;
    
    // Create a system sound object representing the sound file.
    AudioServicesCreateSystemSoundID (
                                      
                                      soundFileURLRef,
                                      &soundFileObject
                                      );
    

}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
              
               
        [self commonInit];
        [self _initVoice];
        
    
        
        
        bgImageView= [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 100)];
        bgImageView.image = [UIImage imageNamed:@"cell-keyword@2x"];
        [self addSubview:bgImageView];
        
        
        titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 45, 300, 20)];
        titleLabel.text = @"titile";
        titleLabel.font = [UIFont systemFontOfSize:18];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        [bgImageView addSubview:titleLabel];
        
        
        
        describeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 65, 300, 20)];
        describeLabel.text = @"describeLabel";
        describeLabel.font = [UIFont systemFontOfSize:16];
        describeLabel.textColor = [UIColor whiteColor];
        describeLabel.backgroundColor = [UIColor clearColor];
        [bgImageView addSubview:describeLabel];
        
        
        
        
       
        

        
        
                    
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
    

    
    // Transforming control vars
    _lastScale = 1.0;
    
}




-(void)reloadSummly{
    NSLog(@"reload");
    
    //add voice
    AudioServicesPlaySystemSound (soundFileObject);
    
    
  //  [SVProgressHUD show];
    
    //此办法有点取巧 以后修改成ProcessView
    CALayer *layer = [[CALayer alloc]init];
    layer.contents = (id)[UIImage imageNamed:@"action-cell"].CGImage;
    layer.frame= CGRectMake(0, 0, 300, 100);
    [bgImageView setClipsToBounds:YES];
    [bgImageView.layer insertSublayer:layer atIndex:0];
    
    
        CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
        animation.toValue=[NSNumber numberWithInt:300];
        animation.duration=1.5f;
        animation.removedOnCompletion=NO;
        animation.fillMode=kCAFillModeForwards;
       [layer addAnimation:animation forKey:nil];
    
    

    
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
