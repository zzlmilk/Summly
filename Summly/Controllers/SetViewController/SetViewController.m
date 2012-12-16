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
    
    

    
    
    listTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 360, 600) style:UITableViewStyleGrouped];
    listTable.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:listTable];
    
    
    
    NSArray *images = @[[UIImage imageNamed:@"petal-twitter.png"],[UIImage imageNamed:@"petal-facebook.png"],[UIImage imageNamed:@"petal-email.png"],[UIImage imageNamed:@"petal-save.png"]];
    self.menu = [[FAFancyMenuView alloc] init];
    self.menu.delegate = self;
    self.menu.buttonImages = images;
    [self.view addSubview:self.menu];
    
}


- (void)fancyMenu:(FAFancyMenuView *)menu didSelectedButtonAtIndex:(NSUInteger)index{
    NSLog(@"%i",index);
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

