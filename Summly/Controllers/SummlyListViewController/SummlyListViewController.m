//
//  SummlyListViewController.m
//  Summly
//
//  Created by zzlmilk on 12-12-13.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import "SummlyListViewController.h"
#import "Summly.h"

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
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-44) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];

   // NSDictionary *dic = [NSDictionary dictionaryWithObject:self.topic.topicId forKey:@"topic_id"];
    [Summly getSummlysParameters:[NSDictionary dictionaryWithObjectsAndKeys:@"6",@"topic_id", nil] WithBlock:^(NSMutableArray *summlys) {
        
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
    cell.detailTextLabel.text = summly.describe;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
