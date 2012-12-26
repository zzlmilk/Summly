//
//  DDShare.m
//  Summly
//
//  Created by zzlmilk on 12-12-25.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

//sina
#define kAppKey @"2129179294"
#define kAppSecret @"69e5bc752981df2ca68ec6716980582a"
#define kAppRedirectURI  @"http://a.875.cn"

#import "DDShare.h"



@implementation DDShare
-(id)init{
    if (self = [super init]) {
    
        _sinaWeibo = [[SinaWeibo alloc] initWithAppKey:kAppKey appSecret:kAppSecret appRedirectURI:kAppRedirectURI andDelegate:self];
    }
    
    return self;
}


-(void)sinaLogin{
    [_sinaWeibo logIn];
}

-(void)sinaLoginOut{
    //[sinaWeibo logOut];
}


#pragma mark -- SinaWeiboDelegate



- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo{
    NSLog(@"%@",sinaweibo.accessToken);
}
@end
