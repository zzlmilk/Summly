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
            self.canRefish=NO;
            
            UIImageView *verticalLine = [[UIImageView alloc] initWithFrame:CGRectMake(98.5, 13, 1, 100)];
            [verticalLine setImage:[UIImage imageNamed:@"verticalLine.png"]];
            [bgImageView addSubview:verticalLine];
            
            bgImageView.image = [UIImage imageNamed:@"cl_1.png"];
            
            iconImageView.image=[UIImage imageNamed:@""];
        }
            break;
        case add:
        {
            self.canMove = NO;
            
            iconImageView.image=[UIImage imageNamed:@""];
            doudouImageView.image=[UIImage imageNamed:@""];
            
            bgImageView.image = [UIImage imageNamed:@"action-cell"];
            UIImageView *addImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cell-add.png"]];
            addImageView.frame =CGRectMake(self.frame.size.width/2-34, self.frame.size.height/2-34/2, 34, 34);
            [bgImageView addSubview:addImageView];
        }
            break;
        case manage:{
            self.canMove = NO;
//            self.canRefish=NO;
          
            iconImageView.image=[UIImage imageNamed:@""];

            doudouImageView.image=[UIImage imageNamed:@""];
            
            titleLabel.frame=CGRectMake(50, 33, 300, 20);
            describeLabel.frame=CGRectMake(titleLabel.frame.origin.x, 55, 300, 20);
            
            selectImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 37, 23, 24)];
            [bgImageView addSubview:selectImageView];
            
//            UIImageView *jiantou = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jiantou.png"]];
//            [jiantou setFrame:CGRectMake(250, 45, 6.5, 11)];
//            [bgImageView addSubview:jiantou];
        }
            break;
        case manageAdd:{
            self.canMove = NO;
//            self.canRefish=NO;

            iconImageView.image=[UIImage imageNamed:@""];
            doudouImageView.image=[UIImage imageNamed:@""];
            
            titleLabel.text=nil;
            describeLabel.text=nil;
            
            bgImageView.image = [UIImage imageNamed:@"action-cell"];
            UIImageView *addImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cell-add-icon.png"]];
                        addImageView.userInteractionEnabled =YES;
            addImageView.frame =CGRectMake(20, 31, 36, 36);
            [bgImageView addSubview:addImageView];
            
            UILabel *defineLabel = [[UILabel alloc] initWithFrame:CGRectMake(addImageView.frame.size.width+addImageView.frame.origin.x+LeftMargin, 39, 160, 20)];
            [defineLabel setFont:[UIFont systemFontOfSize:16]];
            [defineLabel setText:@"点击查看使用教程"];
            [defineLabel setBackgroundColor:[UIColor clearColor]];
            [defineLabel setTextColor:[UIColor colorWithRed:172/255.0f green:172/255.0f blue:172/255.0f alpha:1.0f]];
            [bgImageView addSubview:defineLabel];

        }
        break;
        case saved:{
            self.canMove=NO;
            bgImageView.image = [UIImage imageNamed:@"cl_7.png"];

            iconImageView.image = [UIImage imageNamed:@"icon_4"];
        }
        break;
        case approve:{
        
            if (self.topic.topicId>4) {
                iconImageView.image = [UIImage imageNamed:@"icon_2.png"];
            }
            bgImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d_selected_%d.png",self.topic.topicId,0]];

        }
        break;
        default:
        break;
    }

}

- (void)changeBackView:(BOOL)isSelected{
    
    if (isSelected==YES) {
        bgImageView.image =[UIImage imageNamed:[NSString stringWithFormat:@"%d_selected_%d.png",self.topic.topicId,0]];
        titleLabel.textColor = [UIColor whiteColor];
        describeLabel.textColor = [UIColor whiteColor];
        [selectImageView setImage:[UIImage imageNamed:@"check-box-checked.png"]];

    }
    else{
        bgImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d_unselected_%d.png",self.topic.topicId,0]];
        titleLabel.textColor = [UIColor colorWithRed:172/255.0f green:172/255.0f blue:172/255.0f alpha:1.0f];
        describeLabel.textColor=titleLabel.textColor;
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
        randomInt = arc4random()%2;
               
        [self commonInit];
        [self _initVoice];
        
        self.userInteractionEnabled=YES;
        bgImageView= [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 100)];
        bgImageView.userInteractionEnabled=YES;
        bgImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d_selected_%d.png",self.topic.topicId,randomInt]];
        [self addSubview:bgImageView];
        
        doudouImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 45, 26, 26)];
        [doudouImageView setImage:[UIImage imageNamed:@"doudou.png"]];
        [bgImageView addSubview:doudouImageView];
        
        
        titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10+doudouImageView.frame.size.width+doudouImageView.frame.origin.x, 45, 300, 20)];
        titleLabel.text = @"titile";
        titleLabel.font = [UIFont fontWithName:@"Heiti SC" size:16];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        [bgImageView addSubview:titleLabel];        
        
        describeLabel = [[UILabel alloc]initWithFrame:CGRectMake(titleLabel.frame.origin.x, 65, 300, 20)];
        describeLabel.text = @"describeLabel";
        describeLabel.font = [UIFont fontWithName:@"Heiti SC" size:12];
        describeLabel.textColor = [UIColor whiteColor];
        describeLabel.backgroundColor = [UIColor clearColor];
        describeLabel.alpha=0.85f;
        [bgImageView addSubview:describeLabel];
        
        
        iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(264, 38, 20, 20)];
        iconImageView.contentMode=UIViewContentModeScaleAspectFit;
        iconImageView.image = [UIImage imageNamed:@"icon_3.png"];
        [bgImageView addSubview:iconImageView];
        
    
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

//算弧度
-(double)radians:(double)degrees
{
    return degrees * M_PI/180;
}


- (void)changeImage{
    if (_itemSummlyType==saved) {
        iconImageView.image = [UIImage imageNamed:@"icon_4.png"];
    }
    else
        if (self.topic.topicId>4) {
            iconImageView.image = [UIImage imageNamed:@"icon_2.png"];
        }else
            iconImageView.image = [UIImage imageNamed:@"icon_3.png"];
}

//刷新
-(void)reloadSummly{
    NSLog(@"reload");
    
    iconImageView.image = [UIImage imageNamed:@"load.png"];
            
    [UIView beginAnimations:@"rotate" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1.5f];
    [UIView setAnimationRepeatCount:1];
    iconImageView.layer.anchorPoint = CGPointMake(0.5,0.5);
    iconImageView.transform = CGAffineTransformMakeRotation([self radians:-180]);
    [UIView commitAnimations];    
    
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
    
    
    
    [self performSelector:@selector(changeImage) withObject:nil afterDelay:1.5f];

    
}


#pragma mark---  gestures
- (void)tapGesture:(UITapGestureRecognizer *)tapGesture{
    
    if( [self.actionDelegate respondsToSelector:@selector(ItemSummlydidTap:)]){
         [self.actionDelegate ItemSummlydidTap:self];
    }
}



#pragma mark --- UIScrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (_itemSummlyType==approve || _itemSummlyType==saved) {
        if( scrollView.contentOffset.x <= -self.maxOffset){
            [self reloadSummly];

        }
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
    if (_itemSummlyType==home || _itemSummlyType==add) {

        if ([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
            return YES;
        }
        else
            return NO;
    }
    else
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
