//
//  DDShare.m
//  Summly
//
//  Created by zzlmilk on 12-12-25.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

//sina
#define kAppKey @"3256272261"
#define kAppSecret @"2f24a0ac64e80a4a7c5fc195222a58b1"
#define kAppRedirectURI  @"https://api.weibo.com/oauth2/default.html"

#import "DDShare.h"



@implementation DDShare
-(id)init{
    if (self = [super init]) {
    
        _sinaWeibo = [[SinaWeibo alloc] initWithAppKey:kAppKey appSecret:kAppSecret appRedirectURI:kAppRedirectURI andDelegate:self];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
        if ([sinaweiboInfo objectForKey:@"AccessTokenKey"] && [sinaweiboInfo objectForKey:@"ExpirationDateKey"] && [sinaweiboInfo objectForKey:@"UserIDKey"])
        {
            _sinaWeibo.accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
            _sinaWeibo.expirationDate = [sinaweiboInfo objectForKey:@"ExpirationDateKey"];
            _sinaWeibo.userID = [sinaweiboInfo objectForKey:@"UserIDKey"];
        }
    }
    
    return self;
}


-(void)sinaLogin{
    [_sinaWeibo logIn];
}

-(void)sinaLoginOut{
    [_sinaWeibo logOut];
}

- (void)shareContentToSinaWeibo:(NSString *)status{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:_sinaWeibo.accessToken forKey:@"access_token"];
    [parameter setValue:status forKey:@"status"];
    
    [_sinaWeibo requestWithURL:@"statuses/update.json" params:parameter httpMethod:@"POST" delegate:self];

}

- (void)removeAuthData
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SinaWeiboAuthData"];
}

- (void)storeAuthData
{
    
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              _sinaWeibo.accessToken, @"AccessTokenKey",
                              _sinaWeibo.expirationDate, @"ExpirationDateKey",
                              _sinaWeibo.userID, @"UserIDKey",
                              _sinaWeibo.refreshToken, @"refresh_token", nil];
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark--- SinaWeiBoRequstDelegate

- (void)request:(SinaWeiboRequest *)request didReceiveResponse:(NSURLResponse *)response{
    

}

- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error{

    NSLog(@"失败error--%@",error.userInfo);
}
- (void)request:(SinaWeiboRequest *)request didReceiveRawData:(NSData *)data{
//    NSString *a = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    NSLog(@"%@",a);
    
}
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result{
    
}



#pragma mark -- SinaWeiboDelegate
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogIn userID = %@ accesstoken = %@ expirationDate = %@ refresh_token = %@", sinaweibo.userID, sinaweibo.accessToken, sinaweibo.expirationDate,sinaweibo.refreshToken);
    
    [self storeAuthData];
    
    [self attentionUs];
}

- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo{

    [self removeAuthData];

}

- (void)attentionUs{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:_sinaWeibo.accessToken forKey:@"access_token"];
    [parameter setValue:@"3205758163" forKey:@"uid"];
    [parameter setValue:@"豆豆科技新闻" forKey:@"screen_name"];
    
    [_sinaWeibo requestWithURL:@"friendships/create.json" params:parameter httpMethod:@"POST" delegate:self];

}

- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error{
    NSLog(@"登录失败%@",error.userInfo);
}

@end
