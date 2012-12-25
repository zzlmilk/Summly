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
    
    
    
    NSArray *accountArray = [NSArray arrayWithObjects:@"新浪微博", @"微信",nil];
    NSArray *shareArray = [NSArray arrayWithObjects:@"检查更新：当前版本为1.1",@"使用教程：学习使用豆豆阅读的小技巧。", @"关于豆豆新闻",@"关注@豆豆新闻",nil];
//    NSArray *informationArray = [NSArray arrayWithObjects:@"共享应用",@"关注@summly",@"游览该应用", nil];
//    NSArray *aboutArray = [NSArray arrayWithObjects:@"观看教程",@"关于summly", nil];
    
    _countLitsDic = [NSDictionary dictionaryWithObjectsAndKeys:accountArray,@"0", shareArray,@"1",nil];
    
    _keys = [[_countLitsDic allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
    _nameDic = [NSDictionary dictionaryWithObjectsAndKeys:@"账号设置",@"0",@"其他",@"1",nil];
    
    listTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height-30) style:UITableViewStyleGrouped];
    listTable.backgroundColor = [UIColor whiteColor];
    listTable.dataSource = self;
    listTable.delegate = self;
    listTable.backgroundView = nil;
    [listTable setBackgroundColor:[UIColor clearColor]];
    //[listTable setSeparatorColor:[UIColor clearColor]];
    [listTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:listTable];
    
    
    
    //    NSArray *images = @[[UIImage imageNamed:@"petal-twitter.png"],[UIImage imageNamed:@"petal-facebook.png"],[UIImage imageNamed:@"petal-email.png"],[UIImage imageNamed:@"petal-save.png"]];
    //    self.menu = [[FAFancyMenuView alloc] init];
    //    self.menu.delegate = self;
    //    self.menu.buttonImages = images;
    //    [self.view addSubview:self.menu];
    //
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
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            WeiboSwitchView = [[UISwitch alloc] initWithFrame:CGRectMake(220, 10, 100, 28)];
            WeiboSwitchView.on = YES;//设置初始为ON的一边
            [WeiboSwitchView addTarget:self action:@selector(WeiboSwitchAction) forControlEvents:UIControlEventValueChanged];
            [cell addSubview:WeiboSwitchView];
        }
        else if(seciton ==0 && row == 1)
        {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            WeixingSwitchView = [[UISwitch alloc] initWithFrame:CGRectMake(220, 10, 100, 28)];
            WeixingSwitchView.on = YES;//设置初始为ON的一边
            [WeixingSwitchView addTarget:self action:@selector(WeixingSwitchAction) forControlEvents:UIControlEventValueChanged];
            [cell addSubview:WeixingSwitchView];
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
//    NSLog(@"key:%@",key);
//    NSLog(@"heard:%@",[_nameDic objectForKey:key]);
    [myView addSubview:titleLabel];
    return myView;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    首先是用indexPath获取当前行的内容
    NSInteger row = [indexPath row];
    NSInteger section = [indexPath section];
    
//    NSString *key = [_keys objectAtIndex:section];
//    NSArray *nameSection = [_countLitsDic objectForKey:key];
    
//    NSString *sting = [nameSection objectAtIndex:row];
//    NSLog(@"%@",sting);
    
    if (section == 1 ) {
        switch (row) {
            case 0:  [self DetectionUpdates];  break;
            case 1:  [self Tutorial];          break;
            case 2:  [self About];             break;
            case 3:  [self Attention];         break;
            default: NSLog(@"setting Error");  break;
        }
    }

    
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//微博绑定开关
- (void)WeiboSwitchAction
{
    if (WeiboSwitchView.on) {
        NSLog(@"login");
    }else{
        NSLog(@"logout");
    }
}

//微信绑定开关
- (void)WeixingSwitchAction
{
    if (WeixingSwitchView.on) {
        NSLog(@"login");
    }else{
        NSLog(@"logout");
    }
}

//检测更新
-(void)DetectionUpdates
{

}


//教程
-(void)Tutorial
{
    
}

//关于
-(void)About
{
    
}

//关注@
-(void)Attention
{

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

