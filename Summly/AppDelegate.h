//
//  AppDelegate.h
//  Summly
//
//  Created by zzlmilk on 12-12-3.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kAppKey             @"372135697"
#define kAppSecret          @"32defa6424d3139af1857ad293973448"
#define kAppRedirectURI     @"http://zzlmilk.herokuapp.com"

#ifndef kAppKey
#error
#endif

#ifndef kAppSecret
#error
#endif

#ifndef kAppRedirectURI
#error
#endif

@class SinaWeibo;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    SinaWeibo *sinaweibo;
}
@property (readonly, nonatomic) SinaWeibo *sinaweibo;
@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,strong)UINavigationController *navController;
@end
