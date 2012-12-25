//
//  DetailScrollViewController.m
//  Summly
//
//  Created by zoe on 12-12-17.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import "DetailScrollViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "WebViewController.h"



@interface DetailScrollViewController ()
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
    _index=self.index;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //上滑返回
    UISwipeGestureRecognizer *swipUpGestureUp = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(back)];
    swipUpGestureUp.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipUpGestureUp];
    
    //下滑wbview
    UISwipeGestureRecognizer *swipUpGestureDown = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(pushToArticleView)];
    swipUpGestureDown.direction = UISwipeGestureRecognizerDirectionDown;
   [self.view addGestureRecognizer:swipUpGestureDown];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    [doubleTap setNumberOfTapsRequired:2];
    [doubleTap setNumberOfTouchesRequired:2];
    [self.view addGestureRecognizer:doubleTap];
    

    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [scrollView setBackgroundColor:[UIColor underPageBackgroundColor]];
    scrollView.userInteractionEnabled=YES;
    scrollView.showsHorizontalScrollIndicator = YES;
    scrollView.pagingEnabled=YES;
    scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, self.view.frame.size.height-10, 0);
    scrollView.delegate=self;
    [self.view addSubview:scrollView];
    
    //生成详情
    [self createDetailView:self.summlyArr];
    
    menu = [[FAFancyMenuView alloc] init];
    faFancyMenuDataSource = [[FAFancyMenuViewDataSource alloc]initWithMeun:menu];
    [self.view addSubview:menu];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.navigationController.navigationBarHidden == NO) {
        [self.navigationController setNavigationBarHidden:YES animated:NO];
    }
}

//生成详情
- (void)createDetailView:(NSArray *)summlys{
    
    for (int i=0; i<3; i++) {
        SummlyDetailView *detailView = [[SummlyDetailView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*i, 0, self.view.frame.size.width, self.view.frame.size.height) summly:[summlys objectAtIndex:i]];
        detailView.tag = i+10;
        [scrollView insertSubview:detailView atIndex:3-i];
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
    
    index =(int)scrollView.contentOffset.x/320;
    
    return index;
}
#pragma mark--
#pragma mark-- 手势方法
//上滑
-(void)back {
    //pop动画
    [self popControllerAnimate];
    [self.navigationController popViewControllerAnimated:NO];
}

//双击
- (void)handleDoubleTap:(UIGestureRecognizer *)gestureRecognizer {

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






#pragma mark--
#pragma mark-- ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)_scrollView{
    self.index=[self calculateIndexFromScrollViewOffSet];

    if (self.index==_index) {
        NSLog(@"_index%d",_index);
        SummlyDetailView *detailView =(SummlyDetailView*)[scrollView viewWithTag:10+self.index];
        detailView.titleLabel.frame = CGRectMake(10+(_scrollView.contentOffset.x-(320*self.index))/2, 183.5-110,scrollView.frame.size.width-20,100 );
        detailView.imageBackView.frame = CGRectMake((_scrollView.contentOffset.x-(320*self.index))/4,0, scrollView.frame.size.width, 183.5);
        
        SummlyDetailView *detailView1 =(SummlyDetailView*)[scrollView viewWithTag:10+1+_index];
        detailView1.titleLabel.frame = CGRectMake(10+(_scrollView.contentOffset.x-(320*_index))/2, 183.5-110,scrollView.frame.size.width-20,100 );
        detailView1.imageBackView.frame = CGRectMake((_scrollView.contentOffset.x-(320*_index))/4,0, scrollView.frame.size.width, 183.5);
    }
   else{
       _index=self.index;
       NSLog(@"else  _index%d",_index);

       SummlyDetailView *detailView =(SummlyDetailView*)[scrollView viewWithTag:10+_index];
       detailView.titleLabel.frame = CGRectMake(10+(_scrollView.contentOffset.x-(320*_index)/2), 183.5-110,300,100);
       detailView.imageBackView.frame = CGRectMake((_scrollView.contentOffset.x-(320*_index))/4,0, scrollView.frame.size.width, 183.5);

       SummlyDetailView *detailView1 =(SummlyDetailView*)[scrollView viewWithTag:10+1+_index];
       detailView1.titleLabel.frame = CGRectMake(10+(_scrollView.contentOffset.x-(320*_index)/2), 183.5-110,scrollView.frame.size.width-20,100 );
       detailView1.imageBackView.frame = CGRectMake((_scrollView.contentOffset.x-(320*_index))/4,0, scrollView.frame.size.width, 183.5);
   
   }

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView{
    if (self.index==_index) {
        NSLog(@"_index%d",_index);
        SummlyDetailView *detailView =(SummlyDetailView*)[scrollView viewWithTag:10+self.index-1];
        [UIView animateWithDuration:0.3f animations:^{
            detailView.titleLabel.frame = CGRectMake(10+(_scrollView.contentOffset.x-(320*self.index))/2, 183.5-110,scrollView.frame.size.width-20,100 );
            detailView.imageBackView.frame = CGRectMake((_scrollView.contentOffset.x-(320*self.index))/4,0, scrollView.frame.size.width, 183.5);

        }];
              
        SummlyDetailView *detailView1 =(SummlyDetailView*)[scrollView viewWithTag:10+_index];
        [UIView animateWithDuration:0.3f animations:^{

        detailView1.titleLabel.frame = CGRectMake(10+(_scrollView.contentOffset.x-(320*_index))/2, 183.5-110,scrollView.frame.size.width-20,100 );
        detailView1.imageBackView.frame = CGRectMake((_scrollView.contentOffset.x-(320*_index))/4,0, scrollView.frame.size.width, 183.5);
        }];

    }
    else{
        _index=self.index;
        NSLog(@"else  _index%d",_index);
        
        SummlyDetailView *detailView =(SummlyDetailView*)[scrollView viewWithTag:10+_index-1];
        [UIView animateWithDuration:0.3f animations:^{
            
        detailView.titleLabel.frame = CGRectMake(10+(_scrollView.contentOffset.x-(320*_index)/2), 183.5-110,300,100);
        detailView.imageBackView.frame = CGRectMake((_scrollView.contentOffset.x-(320*_index))/4,0, scrollView.frame.size.width, 183.5);
                                          
        }];
        
        SummlyDetailView *detailView1 =(SummlyDetailView*)[scrollView viewWithTag:10+_index];
            [UIView animateWithDuration:0.3f animations:^{

        detailView1.titleLabel.frame = CGRectMake(10+(_scrollView.contentOffset.x-(320*_index)/2), 183.5-110,scrollView.frame.size.width-20,100 );
        detailView1.imageBackView.frame = CGRectMake((_scrollView.contentOffset.x-(320*_index))/4,0, scrollView.frame.size.width, 183.5);
            }];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
