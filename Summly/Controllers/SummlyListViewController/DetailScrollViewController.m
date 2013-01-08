//
//  DetailScrollViewController.m
//  Summly
//
//  Created by zoe on 12-12-17.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import "DetailScrollViewController.h"
#import <QuartzCore/QuartzCore.h>



@interface DetailScrollViewController ()<UIGestureRecognizerDelegate>
{

    
}

@end

@implementation DetailScrollViewController

static DetailScrollViewController *detailInstance=nil;

+(id)sharedInstance{    
    return detailInstance;
}


- (id)init{
    self = [super init];
    if (self) {
        detailInstance = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.index=[self calculateIndexFromScrollViewOffSet];

//    _index=self.index;
    origin=0;
    
    lastOffsetX=0;
    self.view.backgroundColor = [UIColor whiteColor];
    
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [scrollView setBackgroundColor:[UIColor underPageBackgroundColor]];
    scrollView.userInteractionEnabled=YES;
    scrollView.showsHorizontalScrollIndicator = YES;
    scrollView.pagingEnabled=YES;
    scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, self.view.frame.size.height-10, 0);
    scrollView.delegate=self;
    scrollView.tag=1;
    [self.view addSubview:scrollView];

    
    //生成详情
    [self createDetailView:self.summlyArr];
  
    //上滑返回
    UISwipeGestureRecognizer *swipUpGestureUp = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(back)];
    swipUpGestureUp.direction = UISwipeGestureRecognizerDirectionUp;
    [scrollView addGestureRecognizer:swipUpGestureUp];
    
    //下滑wbview
    UISwipeGestureRecognizer *swipUpGestureDown = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(pushToArticleView)];
    swipUpGestureDown.direction = UISwipeGestureRecognizerDirectionDown;
    [scrollView addGestureRecognizer:swipUpGestureDown];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    [doubleTap setNumberOfTapsRequired:2];
    [scrollView addGestureRecognizer:doubleTap];
    

    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.navigationController.navigationBarHidden == NO) {
        [self.navigationController setNavigationBarHidden:YES animated:NO];
    }
}

//生成详情
- (void)createDetailView:(NSArray *)summlys{

//    upScrollView = [[UpScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width*summlys.count, 183.5) summlys:summlys];
//    upScrollView.pagingEnabled=YES;
//    upScrollView.showsHorizontalScrollIndicator = YES;
////    upScrollView.summlyArrs=summlys;
//    [scrollView addSubview:upScrollView];

    for (int i=0; i<summlys.count; i++) {
        SummlyDetailView *detailView = [[SummlyDetailView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*i, 0, self.view.frame.size.width, self.view.frame.size.height) summly:[summlys objectAtIndex:i]];
        detailView.tag = i+10;
        [scrollView insertSubview:detailView atIndex:summlys.count-i];
        
//        ArticleView *articleView = [[ArticleView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*i, upScrollView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-183.5) summly:[summlys objectAtIndex:i]];
//        [scrollView addSubview:articleView];
    }
    
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width*summlys.count, self.view.frame.size.height);
}

//到达某篇文章
- (void)setScrollOffset:(NSInteger)index{
    [scrollView setContentOffset:CGPointMake(self.view.frame.size.width*index, 0)];
}


//pop动画
- (void)popControllerAnimate{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5f;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    transition.delegate = self;
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
}

- (void)popControllerFadeAnimate{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3f;
    transition.type = @"fade";
    transition.subtype = kCATransitionFade;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
}


//计算第几个详情
- (NSInteger)calculateIndexFromScrollViewOffSet{
    NSInteger index = 0;
    
//    if (scrollView.contentOffset.x<0) {
//        index=-1;
//    }
//    if (orientation==rightOrentation) {
//        index = (int)(scrollView.contentOffset.x+320)/320;
//    }
//    else{
        index =(int)scrollView.contentOffset.x/320;

//    }
    return index;
}

#pragma mark--
#pragma mark-- 手势方法

-(void)followerDismiss{
    
    SummlyDetailView *detailView = (SummlyDetailView*)[scrollView viewWithTag:10+self.index];
    [detailView.menu handleTap:nil];
}

//上滑
-(void)back {
    [self followerDismiss];
    //pop动画
    [self popControllerAnimate];
    [self.navigationController popViewControllerAnimated:NO];
}

//双击
- (void)handleDoubleTap:(UIGestureRecognizer *)gestureRecognizer {
    [self followerDismiss];

    [self pushToArticleDetail];
}

//动画
- (void)pushControllerAnimate{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5f;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromBottom;
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
}


//下滑push文章页
-(void)pushToArticleView{
    [self pushToArticleDetail];
}

//推送到文章页
- (void)pushToArticleDetail{
    [scrollView setBackgroundColor:[UIColor whiteColor]];
    
    SummlyDetailView *detailView = (SummlyDetailView*)[scrollView viewWithTag:10+self.index];
    [detailView dismissDetailViewAnimate:^{
        ArticleViewController *articleVC = [[ArticleViewController alloc] init];
        articleVC.summly =[self.summlyArr objectAtIndex:self.index];
        articleVC.delegate=self;
        [self popControllerFadeAnimate];
        [self.navigationController pushViewController:articleVC animated:NO];
    }];

}



- (void)showDetailViewAnimate{

    SummlyDetailView *detailView = (SummlyDetailView*)[scrollView viewWithTag:10+self.index];
    
    [detailView showDetailViewAnimate];

}


-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}



/*
- (void)scrollViewDidScroll:(UIScrollView *)_scrollView{

    if (_scrollView.tag==1) {
        
    self.index=[self calculateIndexFromScrollViewOffSet];

    if (_scrollView.contentOffset.x>lastOffsetX && _scrollView.dragging==YES) {
        orientation = leftOrentation;
        lastOffsetX = _scrollView.contentOffset.x;
        
        _indexLeft=self.index;
        NSLog(@"左边");
    }
    else if(_scrollView.contentOffset.x<lastOffsetX && _scrollView.dragging==YES){
        orientation = rightOrentation;
        lastOffsetX = _scrollView.contentOffset.x;
        
//        _indexRight = (ceil(_scrollView.contentOffset.x/320.00f));
        _indexRight = self.index+1;
        NSLog(@"右边");
    }
    

    if (_scrollView.decelerating==NO && _scrollView.dragging==YES) {
     
      if (orientation==leftOrentation) {

           if (upScrollView.frame.origin.x<0) {
               [upScrollView setFrame:CGRectMake((_scrollView.contentOffset.x-_indexRight*320)/3,0, upScrollView.frame.size.width, upScrollView.frame.size.height)];
               
               NSLog(@"左左左%f",upScrollView.frame.origin.x);

           }
           else{
             [upScrollView setFrame:CGRectMake((_scrollView.contentOffset.x-_indexLeft*320)/3,0, upScrollView.frame.size.width, upScrollView.frame.size.height)];
               [upScrollView setContentOffset:CGPointMake(_scrollView.contentOffset.x, 0) animated:YES];
               NSLog(@"左左左%f    %f",_scrollView.contentOffset.x,upScrollView.contentOffset.x);

            
            }
     
           if ((int)(upScrollView.frame.origin.x)%320==0) {
               [UIView animateWithDuration:0.3f animations:^{
                   [upScrollView setFrame:CGRectMake(0,0, upScrollView.frame.size.width, upScrollView.frame.size.height)];
               }];
           }

           if (upScrollView.frame.origin.x>=80) {
               [upScrollView setContentOffset:CGPointMake(80, 0) animated:YES];

           }
          
       }
       else{
           if (upScrollView.frame.origin.x<=-20) {
                 [upScrollView setFrame:CGRectMake(-20,0, upScrollView.frame.size.width, upScrollView.frame.size.height)];
               [upScrollView setContentOffset:CGPointMake(-20, 0) animated:YES];
           }

           if (upScrollView.frame.origin.x>0) {
               [upScrollView setFrame:CGRectMake(-(_scrollView.contentOffset.x-_indexLeft*320)/5,0, upScrollView.frame.size.width, upScrollView.frame.size.height)];
               NSLog(@"右upScrollView%f",upScrollView.frame.origin.x);

           }
           else{
               [upScrollView setContentOffset:CGPointMake(-(_indexRight*320-_scrollView.contentOffset.x)/5, 0) animated:YES];

               [upScrollView setFrame:CGRectMake(-(_indexRight*320-_scrollView.contentOffset.x)/5,0, upScrollView.frame.size.width, upScrollView.frame.size.height)];
               [upScrollView setContentOffset:CGPointMake(_scrollView.contentOffset.x, 0) animated:YES];

                    NSLog(@"右右右%f    %f",_scrollView.contentOffset.x,upScrollView.contentOffset.x);

                    NSLog(@"右右右%f,upScrollView%f index%d",_scrollView.contentOffset.x,upScrollView.frame.origin.x,_indexRight);
                
                }
                
            }
        }
    }
//    if (_scrollView.decelerating==YES && _scrollView.dragging==NO) {
//
//        [UIView animateWithDuration:0.3f animations:^{
//            [upScrollView setFrame:CGRectMake(0,0, upScrollView.frame.size.width, upScrollView.frame.size.height)];
//        }];
//    }
    
//    if (_scrollView.decelerating==YES && _scrollView.dragging==YES) {
//
//        [UIView animateWithDuration:0.3f animations:^{
//            [upScrollView setFrame:CGRectMake(0,0, upScrollView.frame.size.width, upScrollView.frame.size.height)];
//        }];
//    }
//    else{
//    
//        NSLog(@"pageScrollView");
//    }
}
*/

- (void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView{
    lastOffsetX=0;
}

#pragma mark--
#pragma mark-- ScrollViewDelegate
/*
- (void)scrollViewDidScroll:(UIScrollView *)_scrollView{
    [self followerDismiss];
    
    self.index=[self calculateIndexFromScrollViewOffSet];

//    if (self.index==_index) {
        SummlyDetailView *detailView =(SummlyDetailView*)[scrollView viewWithTag:10+self.index];
        [UIView animateWithDuration:0.3f animations:^{
            detailView.titleLabel.frame = CGRectMake(10+(_scrollView.contentOffset.x-(320*self.index))/2, 183.5-110,scrollView.frame.size.width-20,100 );
            detailView.imageBackView.frame = CGRectMake((_scrollView.contentOffset.x-(320*self.index))/4,0, scrollView.frame.size.width, 183.5);
        }];
        
        SummlyDetailView *detailView1 =(SummlyDetailView*)[scrollView viewWithTag:10+1+self.index];
        [UIView animateWithDuration:0.3f animations:^{

        detailView1.titleLabel.frame = CGRectMake(10+(_scrollView.contentOffset.x-(320*self.index))/2, 183.5-110,scrollView.frame.size.width-20,100 );
        detailView1.imageBackView.frame = CGRectMake((_scrollView.contentOffset.x-(320*self.index))/4,0, scrollView.frame.size.width, 183.5);
        }];

//    }
//   else{
//       _index=self.index;
//
//       SummlyDetailView *detailView =(SummlyDetailView*)[scrollView viewWithTag:10+_index];
//       [UIView animateWithDuration:0.3f animations:^{
//
//       detailView.titleLabel.frame = CGRectMake(10+(_scrollView.contentOffset.x-(320*_index)/2), 183.5-110,300,100);
//       detailView.imageBackView.frame = CGRectMake((_scrollView.contentOffset.x-(320*_index))/4,0, scrollView.frame.size.width, 183.5);
//                                         }];
//       SummlyDetailView *detailView1 =(SummlyDetailView*)[scrollView viewWithTag:10+1+_index];
//           [UIView animateWithDuration:0.3f animations:^{
//
//       detailView1.titleLabel.frame = CGRectMake(10+(_scrollView.contentOffset.x-(320*_index)/2), 183.5-110,scrollView.frame.size.width-20,100 );
//       detailView1.imageBackView.frame = CGRectMake((_scrollView.contentOffset.x-(320*_index))/4,0, scrollView.frame.size.width, 183.5);
//           }];
//   }

}

- (void)scrollViewDidEndDragging:(UIScrollView *)_scrollView willDecelerate:(BOOL)decelerate{
    NSLog(@"calculate---%d",[self calculateIndexFromScrollViewOffSet]);
//    if (self.index==_index) {
//        NSLog(@"self.index%d,_index%d",self.index,_index );
        SummlyDetailView *detailView =(SummlyDetailView*)[scrollView viewWithTag:10+self.index-1];
        [UIView animateWithDuration:0.3f animations:^{
            detailView.titleLabel.frame = CGRectMake(10+(_scrollView.contentOffset.x-(320*(self.index-1)))/2, 183.5-110,scrollView.frame.size.width-20,100 );
            detailView.imageBackView.frame = CGRectMake(_scrollView.contentOffset.x-(320*(self.index-1))/4,0, scrollView.frame.size.width, 183.5);
            
        }];
        
        SummlyDetailView *detailView1 =(SummlyDetailView*)[scrollView viewWithTag:10+self.index];
        [UIView animateWithDuration:0.3f animations:^{
            
            detailView1.titleLabel.frame = CGRectMake(10+(_scrollView.contentOffset.x-(320*self.index))/2, 183.5-110,scrollView.frame.size.width-20,100 );
            detailView1.imageBackView.frame = CGRectMake((_scrollView.contentOffset.x-(320*self.index))/4,0, scrollView.frame.size.width, 183.5);
        }];
        
//    }
//    else{
//        _index=self.index;
//        NSLog(@"else  _index%d",_index);
//        
//        SummlyDetailView *detailView =(SummlyDetailView*)[scrollView viewWithTag:10+_index-1];
//        [UIView animateWithDuration:0.3f animations:^{
//            
//            detailView.titleLabel.frame = CGRectMake(10+(_scrollView.contentOffset.x-(320*_index)/2), 183.5-110,300,100);
//            detailView.imageBackView.frame = CGRectMake((_scrollView.contentOffset.x-(320*_index))/4,0, scrollView.frame.size.width, 183.5);
//            
//        }];
//        
//        SummlyDetailView *detailView1 =(SummlyDetailView*)[scrollView viewWithTag:10+_index];
//        [UIView animateWithDuration:0.3f animations:^{
//            
//            detailView1.titleLabel.frame = CGRectMake(10+(_scrollView.contentOffset.x-(320*_index)/2), 183.5-110,scrollView.frame.size.width-20,100 );
//            detailView1.imageBackView.frame = CGRectMake((_scrollView.contentOffset.x-(320*_index))/4,0, scrollView.frame.size.width, 183.5);
//        }];
//    }

}

*/

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
