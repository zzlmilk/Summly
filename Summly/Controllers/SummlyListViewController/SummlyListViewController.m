//
//  SummlyListViewController.m
//  Summly
//
//  Created by zzlmilk on 12-12-13.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import "SummlyListViewController.h"
#import "Summly.h"
#import "DetailScrollViewController.h"
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

- (void)bactToVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setTitle:(NSString *)title
{
    [super setTitle:title];
    UILabel *titleView = (UILabel *)self.navigationItem.titleView;
    if (!titleView) {
        titleView = [[UILabel alloc] initWithFrame:CGRectZero];
        titleView.backgroundColor = [UIColor clearColor];
        titleView.font = [UIFont systemFontOfSize:19.f];
        titleView.textColor = [UIColor whiteColor];
        self.navigationItem.titleView = titleView;
    }
    
    titleView.text = title;
    [titleView sizeToFit];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.topic.title;
    
    self.view.backgroundColor = [UIColor clearColor];
    
    UIButton *_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setBackgroundImage:[UIImage imageNamed:@"navigation-back-button.png"] forState:UIControlStateNormal];
    [_button setFrame:CGRectMake(0, 0, 50.0f, 30.0f)];
    [_button addTarget:self action:@selector(bactToVC) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc]initWithCustomView:_button];
    
    
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
     
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@", summly.scource,summly.interval];
    [cell.detailTextLabel setTextColor:[UIColor colorWithRed:180/255.0f green:180/255.0f blue:180/255.0f alpha:1.0f]];
    cell.detailTextLabel.shadowColor = [UIColor blackColor];
    cell.detailTextLabel.shadowOffset = CGSizeMake(0, 0.8);

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
    
    DetailScrollViewController *detailScrollVC;
    if (topicId == self.topic.topicId) {
        detailScrollVC = [DetailScrollViewController sharedInstance];
    }
    else{
        detailScrollVC = [[DetailScrollViewController alloc] init];
        detailScrollVC.summlyArr = self.summlysArr;
    }
    topicId = self.topic.topicId;
    
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
