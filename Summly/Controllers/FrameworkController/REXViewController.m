//
//  REXViewController.m
//  Rex
//
//  Created by rex on 12-6-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "REXViewController.h"
#import "RevalViewController.h"
#import "Helper.h"
#import "MainFrontViewController.h"
#import "QuestionViewController.h"

@interface REXViewController()

//private Properties
@property(strong ,nonatomic)UIView *frontView;
@property(strong,nonatomic)UIView *rearView;


-(void)_loadDefaultConfiguration;

- (CGFloat)calculateOffsetForTranslationInView:(CGFloat)x;
-(void)revealAnimationWithDuration:(NSTimeInterval)duration;
- (void)concealAnimationWithDuration:(NSTimeInterval)duration;
//- (void)_concealAnimationWithDuration:(NSTimeInterval)duration resigningCompletelyFromRearViewPresentationMode:(BOOL)resigning;

- (void)_handleRevealGestureStateBeganWithRecognizer:(UIPanGestureRecognizer *)recognizer;
- (void)_handleRevealGestureStateChangedWithRecognizer:(UIPanGestureRecognizer *)recognizer;
- (void)_handleRevealGestureStateEndedWithRecognizer:(UIPanGestureRecognizer *)recognizer;

- (void)addFrontViewControllerToHierarchy:(UIViewController *)frontViewController;
- (void)addRearViewControllerToHierarchy:(UIViewController *)rearViewController;

@end

@implementation REXViewController
@synthesize frontViewController=_frontViewController;
@synthesize rearViewController= _rearViewController;
@synthesize frontView=_frontView;
@synthesize rearView=_rearView;
@synthesize delegate=_delegate;


@synthesize toggleAnimationDuration=_toggleAnimationDuration;//NSTimeInterval
@synthesize currentFrontViewPosition=_currentFrontViewPosition;
@synthesize maxRearViewRevealOverdraw =_maxRearViewRevealOverdraw;
@synthesize concealViewTriggerWidth=_concealViewTriggerWidth;
@synthesize quickFlickVelocity=_quickFlickVelocity;
@synthesize frontViewShadowRadius=_frontViewShadowRadius;
@synthesize rearViewRevealWidth=_rearViewRevealWidth;


static REXViewController* _sharedInstance = nil;

+(id)sharedREXViewController{
    @synchronized(self) {
        if (_sharedInstance == nil) {
            _sharedInstance = [[self alloc] init];
        }
    }
    return _sharedInstance;
}

-(id)initWIthFrontViewController:(UIViewController *)aFrontViewController rearViewController:(UIViewController *)aRearViewController{
    self = [super init];
    if (self!=nil) {
        _frontViewController =aFrontViewController;
        _rearViewController =aRearViewController;
        
        [self _loadDefaultConfiguration];
       
    }
    _sharedInstance = self;
    return self;
}


-(void)_loadDefaultConfiguration{
    self.rearViewRevealWidth = 260;
    self.toggleAnimationDuration=0.25f;
    self.maxRearViewRevealOverdraw =60.0f;
    self.quickFlickVelocity =1300.0f;
    self.concealViewTriggerWidth = 60.0f;
    self.frontViewShadowRadius=2.5f;
}


- (void)setFrontViewController:(UIViewController *)frontViewController{
    [self setFrontViewController:frontViewController animated:NO];
}
-(void)setFrontViewController:(UIViewController *)frontViewController animated:(BOOL)animated{
    
    if (frontViewController!=nil && frontViewController == _frontViewController ) {
        [self revealToggle:self];
    }
}
/*切換*/
-(void)revealToggle:(id)sender{
    [self revealToggle:sender animationDuration:self.toggleAnimationDuration];
    
    if ([_rearViewController isKindOfClass:[RevalViewController class]]) {
        RevalViewController * revealVC=(RevalViewController*)_rearViewController;
        [[revealVC textKeyword] resignFirstResponder];
        [revealVC textKeyword].text=nil;
        
        revealVC.hView.hidden = YES;
    }
}

-(void)revealToggle:(id)sender animationDuration:(NSTimeInterval)animationDuration{
    if (self.currentFrontViewPosition==FrontViewPositionLeft) {
        
        //如果FrontView当前位置在左边，那么将显示后方隐藏的revealVC reveal[riˈvi:l] 显示，揭露
        [self revealAnimationWithDuration:animationDuration];
        self.currentFrontViewPosition = FrontViewPositionRight;
          
    }
    else if(self.currentFrontViewPosition==FrontViewPositionRight){
        
        //如果当前已经显示隐藏的revealVC，那么将隐藏它 conceal  [kənˈsi:l] 隐藏 遮住
        [self concealAnimationWithDuration:animationDuration];
        self.currentFrontViewPosition = FrontViewPositionLeft;
    }
    else {
        
    }
}

//UIPanGestureRecognizer:触摸并拖拽。
-(void)revealGesture:(UIPanGestureRecognizer *)recognize{
    switch ([recognize state]) {
        case UIGestureRecognizerStateBegan:
            [self _handleRevealGestureStateBeganWithRecognizer:recognize];
            break;
        case UIGestureRecognizerStateChanged:
            [self _handleRevealGestureStateChangedWithRecognizer:recognize];
        case UIGestureRecognizerStateEnded:
            [self _handleRevealGestureStateEndedWithRecognizer:recognize];
        default:
            break;
    }
    
}

-(void)_handleRevealGestureStateBeganWithRecognizer:(UIPanGestureRecognizer *)recognizer{
    NSLog(@"gestureStateBegan");
}

-(void)_handleRevealGestureStateChangedWithRecognizer:(UIPanGestureRecognizer *)recognizer{
    //当前面的VC位于初始位置时
    if (self.currentFrontViewPosition==FrontViewPositionLeft) {
        if ([recognizer translationInView:self.view].x <0.0f) {
            self.frontView.frame = CGRectMake(0.0f, 0.0f, self.frontView.frame.size.width, self.frontView.frame.size.height);
        }
        else {//正方向拖拽
            float offset = [self calculateOffsetForTranslationInView:[recognizer translationInView:self.view].x];
            self.frontView.frame= CGRectMake(offset, 0, self.frontView.frame.size.width,self.frontView.frame.size.height);
        }
    }
    else {//当前面的VC位于右边(revalVC当前显示状态)时
        if ([recognizer translationInView:self.view].x > 0.0f)//正方向拖拽
		{
			float offset = [self calculateOffsetForTranslationInView:([recognizer translationInView:self.view].x+self.rearViewRevealWidth)];
			self.frontView.frame = CGRectMake(offset, 0.0f, self.frontView.frame.size.width, self.frontView.frame.size.height);
		}
        //反方向拖拽，但是仍然位于屏幕内
		else if ([recognizer translationInView:self.view].x > -self.rearViewRevealWidth)
		{
			self.frontView.frame = CGRectMake([recognizer translationInView:self.view].x+self.rearViewRevealWidth, 0.0f, self.frontView.frame.size.width, self.frontView.frame.size.height);
		}
		else//反方向拖拽，触摸点超出了左边屏幕
		{
			self.frontView.frame = CGRectMake(0.0f, 0.0f, self.frontView.frame.size.width, self.frontView.frame.size.height);
		}
    }
}
-(void)_handleRevealGestureStateEndedWithRecognizer:(UIPanGestureRecognizer *)recognizer{
    //拖拽速度超过指定的速度
    if (fabs([recognizer velocityInView:self.view].x) > self.quickFlickVelocity){
        if ([recognizer velocityInView:self.view].x > 0.0f)//正方向拖拽
		{
			[self revealAnimationWithDuration:self.toggleAnimationDuration];
		}
		else
		{
			[self _concealAnimationWithDuration:self.toggleAnimationDuration resigningCompletelyFromRearViewPresentationMode:NO];
		}
    }
    else {
        float dynamicTriggerLevel = (FrontViewPositionLeft == self.currentFrontViewPosition) ? self.rearViewRevealWidth : self.concealViewTriggerWidth;
		
		if (self.frontView.frame.origin.x >= dynamicTriggerLevel && self.frontView.frame.origin.x != self.rearViewRevealWidth)
		{
			[self revealAnimationWithDuration:self.toggleAnimationDuration];
		}
		else
		{
            NSLog(@"concel");
            [self concealAnimationWithDuration:self.toggleAnimationDuration];
		}
        
    }
    
    
    // Now adjust the current state enum.
	if (self.frontView.frame.origin.x == 0.0f)
	{
		self.currentFrontViewPosition = FrontViewPositionLeft;
	}
	else
	{
		self.currentFrontViewPosition = FrontViewPositionRight;
	}
    

    
}
-(void)revealAnimationWithDuration:(NSTimeInterval)duration{
    
    [UIView animateWithDuration:duration delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionAllowUserInteraction animations:^{
        self.frontView.frame = CGRectMake(self.rearViewRevealWidth, 0.0f, self.frontView.frame.size.width, self.frontView.frame.size.height);
        
    } completion:^(BOOL finished) {
       // NSLog(@"finish");
    }];
}

-(void)concealAnimationWithDuration:(NSTimeInterval)duration{
    [UIView animateWithDuration:duration delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionAllowUserInteraction animations:^{
        self.frontView.frame = CGRectMake(0, 0.0f, self.frontView.frame.size.width, self.frontView.frame.size.height);
    } completion:^(BOOL finished) {
        // NSLog(@"finish");
    }];
    
}
-(void)_concealAnimationWithDuration:(NSTimeInterval)duration resigningCompletelyFromRearViewPresentationMode:(BOOL)resigning{
    [UIView animateWithDuration:duration delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionAllowUserInteraction animations:^{
        self.frontView.frame = CGRectMake(0, 0.0f, self.frontView.frame.size.width, self.frontView.frame.size.height);
    } completion:^(BOOL finished) {
       // NSLog(@"finish");
    }];
    
}

-(void)addFrontViewControllerToHierarchy:(UIViewController *)frontViewController{
    [self addChildViewController:frontViewController];
    frontViewController.view.frame = CGRectMake(0, 0, self.frontView.frame.size.width, self.frontView.frame.size.height);
    [self.frontView  addSubview:frontViewController.view];
    
}

-(void)addRearViewControllerToHierarchy:(UIViewController *)rearViewController{
    [self addChildViewController:rearViewController];
    rearViewController.view.frame = CGRectMake(0, 0, self.rearView.frame.size.width, self.rearView.frame.size.height);
    [self.rearView addSubview:rearViewController.view];
}

//
//-(void)loadView{
//    //[super loadView];
//    // [_frontViewController loadView];
//    //self.view=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
//}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.frontView = [[UIView alloc]initWithFrame:self.view.bounds];
    self.rearView = [[UIView alloc]initWithFrame:self.view.bounds];
    
    self.frontView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.rearView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    
    
    [self.view addSubview:self.rearView];
    [self.view addSubview:self.frontView];
    
    
    [self addRearViewControllerToHierarchy:_rearViewController];
    [self addFrontViewControllerToHierarchy:_frontViewController];
    
    [_frontViewController viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [_frontViewController viewWillAppear:animated];
    [_rearViewController viewWillAppear:animated];
}



-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [_frontViewController viewWillAppear:animated];
    
}



-(CGFloat)calculateOffsetForTranslationInView:(CGFloat)x{
    CGFloat result;
    
    if (x <= self.rearViewRevealWidth)
	{
        
		result = x;
	}
	else if (x <= self.rearViewRevealWidth+(M_PI*self.maxRearViewRevealOverdraw/2.0f))
	{
        
		result = self.maxRearViewRevealOverdraw*sin((x-self.rearViewRevealWidth)/self.maxRearViewRevealOverdraw)+self.rearViewRevealWidth;
	}
	else
	{
        
		result = self.rearViewRevealWidth+self.maxRearViewRevealOverdraw;
	}
    return result;
}



@end
