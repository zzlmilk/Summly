//
//  SetViewController.m
//  Summly
//
//  Created by zzlmilk on 12-12-15.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import "SetViewController.h"
#import "Update.h"
#import "AboutViewController.h"
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
    
    shareSina = [[DDShare alloc]init];

    UIButton *_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setBackgroundImage:[UIImage imageNamed:@"navigation-back-button.png"] forState:UIControlStateNormal];
    [_button setFrame:CGRectMake(0, 0, 50.0f, 30.0f)];
    [_button addTarget:self action:@selector(bactToTopic) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc]initWithCustomView:_button];
//    
    NSString *version = [NSString stringWithFormat:@"检查更新：当前版本为%@",Version];
    
    NSArray *accountArray = [NSArray arrayWithObjects:@"新浪微博", @"微信",nil];
    NSArray *shareArray = [NSArray arrayWithObjects:version,@"使用教程：学习使用豆豆阅读的小技巧。", @"关于豆豆新闻",@"关注@豆豆新闻",nil];
//    NSArray *informationArray = [NSArray arrayWithObjects:@"共享应用",@"关注@summly",@"游览该应用", nil];
//    NSArray *aboutArray = [NSArray arrayWithObjects:@"观看教程",@"关于summly", nil];
    
    _countLitsDic = [NSDictionary dictionaryWithObjectsAndKeys:accountArray,@"0", shareArray,@"1",nil];
    
    _keys = [[_countLitsDic allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
    _nameDic = [NSDictionary dictionaryWithObjectsAndKeys:@"账号设置",@"0",@"其他",@"1",nil];
    
    listTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    listTable.backgroundColor = [UIColor whiteColor];
    listTable.dataSource = self;
    listTable.delegate = self;
    listTable.backgroundView = nil;
    [listTable setBackgroundColor:[UIColor clearColor]];
    //[listTable setSeparatorColor:[UIColor clearColor]];
    [listTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:listTable];
    
    
    //添加教程图片
    
    imgTutorials1Button = [UIButton buttonWithType:UIButtonTypeCustom];
    imgTutorials1Button = [[UIButton alloc]initWithFrame:CGRectMake(-1,-45,321,460)];
    [imgTutorials1Button setBackgroundImage:[UIImage imageNamed:@"tutorials1.png"] forState:UIControlStateNormal];
    [imgTutorials1Button addTarget:self action:@selector(checkTutorials:) forControlEvents:UIControlEventTouchDown];
    imgTutorials1Button.hidden = YES;
    imgTutorials1Button.tag = 1;
    [self.view addSubview:imgTutorials1Button];
    
    
    imgTutorials2Button = [UIButton buttonWithType:UIButtonTypeCustom];
    imgTutorials2Button = [[UIButton alloc]initWithFrame:CGRectMake(-1,-45,321,460)];
    [imgTutorials2Button setBackgroundImage:[UIImage imageNamed:@"tutorials2.png"] forState:UIControlStateNormal];
    [imgTutorials2Button addTarget:self action:@selector(checkTutorials:) forControlEvents:UIControlEventTouchDown];
    imgTutorials2Button.hidden = YES;
    imgTutorials2Button.tag = 2;
    [self.view addSubview:imgTutorials2Button];
    
    
    imgTutorials3Button = [UIButton buttonWithType:UIButtonTypeCustom];
    imgTutorials3Button = [[UIButton alloc]initWithFrame:CGRectMake(-1,-45,321,460)];
    [imgTutorials3Button setBackgroundImage:[UIImage imageNamed:@"tutorials3.png"] forState:UIControlStateNormal];
    [imgTutorials3Button addTarget:self action:@selector(checkTutorials:) forControlEvents:UIControlEventTouchDown];
    imgTutorials3Button.hidden = YES;
    imgTutorials3Button.tag = 3;
    [self.view addSubview:imgTutorials3Button];
    
    
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
            switchView = [[UISwitch alloc] initWithFrame:CGRectMake(220, 10, 100, 28)];
            switchView.on = NO;//设置初始为ON的一边
            [switchView addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
            [cell addSubview:switchView];
            
            if (shareSina.sinaWeibo.accessToken!=nil) {
                switchView.on = YES;
            }
            /*
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            WeiboSwitchView = [[UISwitch alloc] initWithFrame:CGRectMake(220, 10, 100, 28)];
            WeiboSwitchView.on = YES;//设置初始为ON的一边
            [WeiboSwitchView addTarget:self action:@selector(WeiboSwitchAction) forControlEvents:UIControlEventValueChanged];
            [cell addSubview:WeiboSwitchView];
             */
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
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
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

- (void)switchAction:(id)sender
{
    UISwitch *sinaSwitch = (UISwitch *)sender;
    if (sinaSwitch.on) {
        
        [shareSina sinaLogin];
        
    }
    else{
        [shareSina sinaLoginOut];
    }

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
    self.currentVersionArr=[[NSDictionary alloc] init];
    [Update getDefaultVersionParameters:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"ios"] ,@"terminal_info", nil] WithBlock:^(NSMutableArray *summlys) {
        self.currentVersionArr=(NSDictionary *)summlys;
        //NSLog(@":currentVersionArr%@",self.currentVersionArr);
        
        NSString *version = [self.currentVersionArr objectForKey:@"versions_info"];
        if ([version isEqualToString:version]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"当前已是最新版本" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }else{
            NSString *url = [self.currentVersionArr objectForKey:@"url"];
            //url = @"http://www.baidu.com";
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",url]]];
        }
        
    }];
}
 

//教程
-(void)Tutorial
{
    imgTutorials1Button.hidden = NO;
}

-(void)checkTutorials :(UIButton *)button
{
    if (button.tag == 1) {
        imgTutorials1Button.hidden = YES;
        imgTutorials2Button.hidden = NO;
        imgTutorials3Button.hidden = YES;
    }else if(button.tag == 2){
        imgTutorials1Button.hidden = YES;
        imgTutorials2Button.hidden = YES;
        imgTutorials3Button.hidden = NO;
    }else if(button.tag == 3){
        imgTutorials1Button.hidden = YES;
        imgTutorials2Button.hidden = YES;
        imgTutorials3Button.hidden = YES;
    }
}


//关于
-(void)About
{
    AboutViewController *aboutViewController = [[AboutViewController alloc]init];
    [self.navigationController pushViewController:aboutViewController animated:YES];
}

//关注@
-(void)Attention
{
    if (shareSina.sinaWeibo.accessToken==nil) {
        [shareSina sinaLogin];
    }
    else{
        [shareSina attentionUs];
    }
    
    [switchView setOn:YES];
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

