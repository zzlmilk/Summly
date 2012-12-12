//
//  REXViewController.h
//  Rex
//
//  Created by rex on 12-6-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    FrontViewPositionLeft,
    FrontViewPositionRight,
} FrontViewPosition;

@protocol REXRevalControllerDelegate;

@interface REXViewController : UIViewController


@property(nonatomic,strong)UIViewController *frontViewController;
@property(nonatomic,strong)UIViewController *rearViewController;

@property (assign, nonatomic) FrontViewPosition currentFrontViewPosition;
@property (assign, nonatomic) id<REXRevalControllerDelegate> delegate;


@property(assign,nonatomic) CGFloat rearViewRevealWidth;


@property (assign, nonatomic) CGFloat maxRearViewRevealOverdraw;
@property (assign, nonatomic) CGFloat concealViewTriggerWidth;
@property (assign, nonatomic) CGFloat quickFlickVelocity;


@property (assign, nonatomic) NSTimeInterval toggleAnimationDuration;
@property (assign, nonatomic) CGFloat frontViewShadowRadius;


+(id)sharedREXViewController;


-(id)initWIthFrontViewController:(UIViewController*)aFrontViewController rearViewController
                                :(UIViewController*)aRearViewController;


-(void)revealToggle:(id)sender;
-(void)revealToggle:(id)sender animationDuration:(NSTimeInterval)animationDuration;
-(void)revealGesture:(UIPanGestureRecognizer *)recognize;

- (void)setFrontViewController:(UIViewController *)frontViewController;
- (void)setFrontViewController:(UIViewController *)frontViewController animated:(BOOL)animated;

@end



@protocol REXRevalControllerDelegate <NSObject>

@optional


@end
