//
//  SetViewController.m
//  Summly
//
//  Created by zzlmilk on 12-12-15.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import "SetViewController.h"

@interface SetViewController ()
@property (nonatomic, strong) FAFancyMenuView *menu;
@end

@implementation SetViewController
@synthesize listTable;

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
    self.title =@"设置";
	// Do any additional setup after loading the view.
    
    UIButton *_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setBackgroundImage:[UIImage imageNamed:@"navigation-back-button.png"] forState:UIControlStateNormal];
    [_button setFrame:CGRectMake(0, 0, 50.0f, 30.0f)];
    [_button addTarget:self action:@selector(bactToTopic) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc]initWithCustomView:_button];
    
    
    
    NSArray *accountArray = [NSArray arrayWithObjects:@"Sina Weibo", nil];
    NSArray *shareArray = [NSArray arrayWithObjects:@"共享个性化设置", nil];
    NSArray *informationArray = [NSArray arrayWithObjects:@"共享应用",@"关注@summly",@"游览该应用", nil];
    NSArray *aboutArray = [NSArray arrayWithObjects:@"观看教程",@"关于summly", nil];
    
    _countLitsDic = [NSDictionary dictionaryWithObjectsAndKeys:accountArray,@"0", shareArray,@"1", informationArray,@"2",aboutArray,@"3",nil];
    
    _keys = [[_countLitsDic allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
    _nameDic = [NSDictionary dictionaryWithObjectsAndKeys:@"账户",@"0", @"",@"1", @"传递消息",@"2",@"",@"3",nil];
    
    listTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    listTable.backgroundColor = [UIColor whiteColor];
    listTable.dataSource = self;
    listTable.delegate = self;
    listTable.backgroundView = nil;
    [listTable setBackgroundColor:[UIColor clearColor]];
    //[listTable setSeparatorColor:[UIColor clearColor]];
    [listTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:listTable];
}


- (void)fancyMenu:(FAFancyMenuView *)menu didSelectedButtonAtIndex:(NSUInteger)index{
    NSLog(@"%i",index);
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    NSString *key = [_keys objectAtIndex:section];
    NSString *sting =  [_nameDic objectForKey:key];
    
    int nub = [sting isEqualToString:@""]?15:30;
    return nub;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [_keys count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *key = [_keys objectAtIndex:section];
    NSArray *nameSection = [_countLitsDic objectForKey:key];
    return [nameSection count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *SecionsTableIdentifier = @"SecionsTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SecionsTableIdentifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SecionsTableIdentifier];
        NSUInteger seciton = [indexPath section];
        NSUInteger row = [indexPath row];
        
        NSString *key = [_keys objectAtIndex:seciton];
        NSArray *nameSection = [_countLitsDic objectForKey:key];
        
        if (seciton ==0 && row == 0) {
            //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectMake(220, 10, 100, 28)];
            switchView.on = NO;//设置初始为ON的一边
            [switchView addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
            [cell addSubview:switchView];
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        cell.textLabel.text = [nameSection objectAtIndex:row];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.backgroundView = nil;
        cell.backgroundColor = [UIColor clearColor];
    }

    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    NSString *key = [_keys objectAtIndex:section];
    
    //return [_nameDic objectForKey:key];
    
    UIView* myView = [[UIView alloc] init];
    //myView.backgroundColor = [UIColor colorWithRed:0.10 green:0.68 blue:0.94 alpha:0.7];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 22)];
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:16];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text=[_nameDic objectForKey:key];
    [myView addSubview:titleLabel];
    return myView;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    首先是用indexPath获取当前行的内容
    NSInteger row = [indexPath row];
    NSInteger section = [indexPath section];
    
    NSString *key = [_keys objectAtIndex:section];
    NSArray *nameSection = [_countLitsDic objectForKey:key];
    
    NSString *sting = [nameSection objectAtIndex:row];
    NSLog(@"%@",sting);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)switchAction:(id)sender
{
    UISwitch *sinaSwitch = (UISwitch *)sender;
    if (sinaSwitch.on) {
        
    }
    else{
        
    }
}


- (void)bactToTopic
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

