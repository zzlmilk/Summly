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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.topic.title;
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];

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
     
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@", summly.scource,[self timeIntervalFromNow:summly.summlyTime]];
    [cell.detailTextLabel setTextColor:[UIColor colorWithRed:180/255.0f green:180/255.0f blue:180/255.0f alpha:1.0f]];
    cell.detailTextLabel.shadowColor = [UIColor blackColor];
    cell.detailTextLabel.shadowOffset = CGSizeMake(0, 0.8);

    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1tablebackground.png"]];
    cell.backgroundView=imageView;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIImageView *tableSeparator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tableseparator.png"]];
    [tableSeparator setFrame:CGRectMake(0, 90,320, 2)];
    [cell addSubview:tableSeparator];    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 92;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailScrollViewController *detailScrollVC = [[DetailScrollViewController alloc] init];
    detailScrollVC.summlyArr = self.summlysArr;
    [self.navigationController pushViewController:detailScrollVC animated:YES];
    
}

- (NSString *)timeIntervalFromNow:(NSDate *)summlyTime{
    NSString *intervalStr;
    double timeInterval = 0.0f;
    timeInterval = [[NSDate date] timeIntervalSinceDate:summlyTime];
    NSInteger interval = (int)timeInterval/3600;

    if (interval >=24) {
        interval = (int)interval/24;
        intervalStr = [NSString stringWithFormat:@"%d 天前",interval];
        return intervalStr;
    }
    else if(interval <24 && interval>1){
        intervalStr = [NSString stringWithFormat:@"%d 小时前",interval];

        return intervalStr;
    }
    return nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
