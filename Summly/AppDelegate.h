//
//  AppDelegate.h
//  Summly
//
//  Created by zzlmilk on 12-12-3.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>
{
   enum WXScene _scene;
}


@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,strong)UINavigationController *navController;
@end
