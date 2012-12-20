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

#define LeftMargin 20

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
@synthesize isSelect;


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
            bgImageView.image = [UIImage imageNamed:@"cell-cover-page"];
            
        }
            break;
        case add:
        {
            self.canMove = NO;
            bgImageView.image = [UIImage imageNamed:@"action-cell"];
            UIImageView *addImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cell-add-icon@2x"]];
            addImageView.frame =CGRectMake(self.frame.size.width/2-34, self.frame.size.height/2-34/2, 34, 34);
            [bgImageView addSubview:addImageView];
        }
            break;
        case manage:{
            self.canMove = NO;
//            self.canRefish=NO;
            
            titleLabel.frame=CGRectMake(50, 39, 300, 20);
            describeLabel.text=nil;
                        
            selectImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 37, 23, 24)];
            [bgImageView addSubview:selectImageView];
            [self changeBackView:self.isSelect];
        }
            break;
        case manageAdd:{
            self.canMove = NO;
//            self.canRefish=NO;

            
            titleLabel.text=nil;
            describeLabel.text=nil;
            bgImageView.image = [UIImage imageNamed:@"action-cell"];
            bgImageView.userInteractionEnabled =YES;
            UIImageView *addImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cell-add-icon.png"]];
                        addImageView.userInteractionEnabled =YES;
            addImageView.frame =CGRectMake(20, 32, 34, 34);
            [bgImageView addSubview:addImageView];
            
            UILabel *defineLabel = [[UILabel alloc] initWithFrame:CGRectMake(addImageView.frame.size.width+addImageView.frame.origin.x+LeftMargin, 39, 160, 20)];
            [defineLabel setFont:[UIFont systemFontOfSize:16]];
            [defineLabel setText:@"点击这里创建新话题"];
            [defineLabel setBackgroundColor:[UIColor clearColor]];
            [defineLabel setTextColor:[UIColor colorWithRed:98/255.0f green:98/255.0f blue:98/255.0f alpha:1.0f]];
            [bgImageView addSubview:defineLabel];

        }
        break;
        case saved:{
            bgImageView.image = [UIImage imageNamed:@"cell-saved"];

        }
        default:
        break;
    }

}

- (void)changeBackView:(BOOL)isSelected{
    
    if (isSelected==YES) {
        bgImageView.image = [UIImage imageNamed:@"cell-keyword"];
        [selectImageView setImage:[UIImage imageNamed:@"check-box-checked.png"]];

    }
    else{
        bgImageView.image = [UIImage imageNamed:@"action-cell"];
        [selectImageView setImage:[UIImage imageNamed:@"check-box.png"]];
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
        
    
        
        self.userInteractionEnabled=YES;
        bgImageView= [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 100)];
        bgImageView.userInteractionEnabled=YES;
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
    self.isSelect=YES;

    
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
    if (_itemSummlyType!=manage) {
        if (scrollView.contentOffset.x > 0) {
            [scrollView setContentOffset:CGPointMake(0, scrollView.contentOffset.y)];
        }
    }
    else{
        
        if (scrollView.contentOffset.x < 0) {
            [scrollView setContentOffset:CGPointMake(0, scrollView.contentOffset.y)];
        }

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
