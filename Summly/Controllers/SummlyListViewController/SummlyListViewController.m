//
//  SummlyListViewController.m
//  Summly
//
//  Created by zzlmilk on 12-12-13.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//
//

#import "SummlyListViewController.h"
#import "Summly.h"
#import <QuartzCore/QuartzCore.h>




@interface SummlyListViewController ()

@end

@implementation SummlyListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
           }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.topic.title;
    
    self.view.backgroundColor = [UIColor clearColor];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-44) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor=[UIColor clearColor];
    tableView.backgroundView=nil;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];


    
    [Summly getSummlysParameters:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",self.topic.topicId] ,@"topic_id", nil] WithBlock:^(NSMutableArray *summlys) {
        
        
        self.summlysArr=summlys;
        [tableView reloadData];
        

        //生成detailView
        detailScrollVC = [[DetailScrollViewController alloc] init];
        detailScrollVC.summlyArr = self.summlysArr;
    }];

  

      
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.navigationController.navigationBar.isHidden==YES) {
        [self.navigationController setNavigationBarHidden:NO animated:NO];
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.summlysArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *SYJCell = @"SummlyCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SYJCell];
    
    if (cell ==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SYJCell];
    }
    
    Summly *summly = [self.summlysArr objectAtIndex:indexPath.row];
    cell.textLabel.text = summly.title;
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    [cell.textLabel setFont:[UIFont fontWithName:@"Heiti SC" size:15]];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@", summly.scource,summly.interval];
    [cell.detailTextLabel setTextColor:[UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:0.85f]];
    [cell.detailTextLabel setFont:[UIFont fontWithName:@"Heiti SC" size:10]];
<<<<<<< HEAD
    
//    cell.detailTextLabel.shadowColor = [UIColor blackColor];
//    cell.detailTextLabel.shadowOffset = CGSizeMake(0, 0.8);
=======

>>>>>>> b5c5ee2d1f2ceb92793d7b841c177f9c08566223

    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tablebackground.png"]];
    cell.selectedBackgroundView=imageView;
    
    
    UIImageView *tableSeparator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tableseparator.png"]];
    [tableSeparator setFrame:CGRectMake(0, 90,320, 2)];
    [cell addSubview:tableSeparator];    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 92;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    DetailScrollViewController *detailScrollVC;
//    if (topicId == self.topic.topicId) {
//        detailScrollVC = [DetailScrollViewController sharedInstance];
//    }
//    else{
//        detailScrollVC = [[DetailScrollViewController alloc] init];
//        detailScrollVC.summlyArr = self.summlysArr;
//    }
//    topicId = self.topic.topicId;

//    detailScrollVC.index = indexPath.row;
    
    [detailScrollVC setScrollOffset:indexPath.row];
    //controller推入动画
    [self pushControllerAnimate];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self.navigationController pushViewController:detailScrollVC animated:NO];
}




- (void)pushControllerAnimate{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5f;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromBottom;
    transition.delegate = self;
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [self.navigationController.view.layer addAnimation:transition forKey:nil];

    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
