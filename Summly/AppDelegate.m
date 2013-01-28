//
//  AppDelegate.m
//  Summly
//
//  Created by zzlmilk on 12-12-3.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "DBConnection.h"
#import "BundleHelp.h"
#import "TutorialsViewController.h"

@implementation AppDelegate

static AppDelegate *instance=nil;

+(id)sharedInstance{
    
    return instance;
}


-(UIImageView*)_randomBackground{
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:self.window.bounds];
    NSString *randomImageName = [NSString stringWithFormat:@"cover_%d.jpg", arc4random()%5+1];
    bgImageView.image = [UIImage imageNamed:randomImageName];
    return bgImageView;
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor clearColor];
   
    UIImageView *listBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"manageBg.png"]];
    [listBg setFrame:CGRectMake(0, -44, self.window.frame.size.width, self.window.frame.size.height)];
    [self.window addSubview:listBg];

    [self.window addSubview:[self _randomBackground]];

    [DBConnection createEditableCopyOfDatabaseIfNeeded:NO];
    [DBConnection getSharedDatabase];
       

//    MainViewController *summlyVC = [[MainViewController alloc]init];
//    _navController = [[UINavigationController alloc]initWithRootViewController:summlyVC];
    

    NSString *Isloging = ([[NSUserDefaults standardUserDefaults] objectForKey:@"isloging"])?[[NSUserDefaults standardUserDefaults] objectForKey:@"isloging"]:@"";
    
    NSLog(@"Isloging:%@",Isloging);
    
    if ([Isloging intValue]!=1) {
        TutorialsViewController *summlyVC = [[TutorialsViewController alloc]init];
        _navController = [[UINavigationController alloc]initWithRootViewController:summlyVC];
        
    }else{
        MainViewController *mainVC = [[MainViewController alloc]init];
        _navController = [[UINavigationController alloc]initWithRootViewController:mainVC];
        _navController.delegate=mainVC;
    }
        
    [self.window setRootViewController:_navController];
    
    [self.window makeKeyAndVisible];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];//隐藏状态栏

    

    return YES;
}




- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
 
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
