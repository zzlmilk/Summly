//
//  TutorialsViewController.m
//  Summly
//
//  Created by Mars on 13-1-12.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "TutorialsViewController.h"
#import "MainViewController.h"


@interface TutorialsViewController ()

@end

@implementation TutorialsViewController
@synthesize imageViews;
int kNumberOfPages = 3;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        

        
    }
    return self;
}


- (void)loadScrollViewWithPage:(int)page {
	//int kNumberOfPages = 3;
	
    if (page < 0) return;
    if (page >= kNumberOfPages) return;
	
    // replace the placeholder if necessary
    UIImageView *view = [imageViews objectAtIndex:page];
    if ((NSNull *)view == [NSNull null]) {
		//UIImage *image = [dataSource imageAtIndex:page];
        
        
        UIImage *image = Nil;
        if (self.view.frame.size.height > 480) {
            NSString *imageName = [NSString stringWithFormat:@"tutorials%d.png",page+1];
            image =  [UIImage imageNamed:imageName];
            NSLog(@"iphone5");
        }else{
            NSString *imageName = [NSString stringWithFormat:@"tutorials%d.png",page+1];
            image =  [UIImage imageNamed:imageName];
            NSLog(@"iphone4");
        }

        
        view = [[UIImageView alloc] initWithImage:image];
        [imageViews replaceObjectAtIndex:page withObject:view];
    }
	
    // add the controller's view to the scroll view
    if (nil == view.superview) {
        CGRect frame = scrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        view.frame = frame;
        [scrollView addSubview:view];
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // We don't want a "feedback loop" between the UIPageControl and the scroll delegate in
    // which a scroll event generated from the user hitting the page control triggers updates from
    // the delegate method. We use a boolean to disable the delegate logic when the page control is used.
    if (pageControlUsed) {
        // do nothing - the scroll was initiated from the page control, not the user dragging
        return;
    }
	
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
	
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
	
    // A possible optimization would be to unload the views+controllers which are no longer visible
}

// At the begin of scroll dragging, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    pageControlUsed = NO;
}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlUsed = NO;
}

- (IBAction)changePage:(id)sender {
    int page = pageControl.currentPage;
	
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
	// update the scroll view to the appropriate page
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
    
	// Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
    pageControlUsed = YES;
}


- (void)viewDidLoad
{
    //self.navigationController.navigationBarHidden = YES;

    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    UIButton *btnleft = [UIButton buttonWithType: UIButtonTypeCustom];
    btnleft.frame = CGRectMake(0, 0, 50, 30);
    [btnleft setTitle:@"" forState:UIControlStateNormal];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithCustomView:btnleft];
    self.navigationItem.leftBarButtonItem = leftBtn;
    [btnleft addTarget:self action:Nil forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *btnright = [UIButton buttonWithType: UIButtonTypeCustom];
    btnright.frame = CGRectMake(260, 8, 50, 30);
    [btnright setTitle:@"BB" forState:UIControlStateNormal];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithCustomView:btnright];
    self.navigationItem.rightBarButtonItem = rightBtn;
    [btnright addTarget:self action:@selector(cellBack) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(260, -20, 50, 50);

    [btn setTitle:@"" forState:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(zoomInAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    //添加视图
    NSString *Isloging = ([[NSUserDefaults standardUserDefaults] objectForKey:@"isloging"])?[[NSUserDefaults standardUserDefaults] objectForKey:@"isloging"]:@"";
    int size =0;
    if([Isloging intValue] ==1)
    {
        size = 20;
    }else{
        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"isloging"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    int pageControlHeight = 10;
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -20+size, self.view.frame.size.width, self.view.frame.size.height - pageControlHeight)];
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - pageControlHeight-20, self.view.frame.size.width, pageControlHeight)];
    
    [self.view addSubview:scrollView];
    [self.view addSubview:pageControl];
    [self.view addSubview:btn];
    


    NSMutableArray *views = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < kNumberOfPages; i++) {
        [views addObject:[NSNull null]];
    }
    self.imageViews = views;
    
    
    // a page is the width of the scroll view
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * kNumberOfPages, scrollView.frame.size.height);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    scrollView.delegate = self;
    
    pageControl.numberOfPages = kNumberOfPages;
    pageControl.currentPage = 0;
    pageControl.backgroundColor = [UIColor blackColor];
    
    // pages are created on demand
    // load the visible page
    // load the page on either side to avoid flashes when the user starts scrolling
    [self loadScrollViewWithPage:0];
    [self loadScrollViewWithPage:1];

	// Do any additional setup after loading the view.
}

-(void)zoomInAction
{
    NSLog(@"button");
    MainViewController *summlyVC = [[MainViewController alloc]init];
    [self.navigationController pushViewController:summlyVC animated:NO];
    
}


-(void)cellBack
{
     [self.navigationController popViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
