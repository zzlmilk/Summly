//
//  FAFancyMenuViewDataSource.m
//  Summly
//
//  Created by zzlmilk on 12-12-21.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//


#import "FAFancyMenuViewDataSource.h"

@implementation FAFancyMenuViewDataSource


-(id)initWithMeun:(FAFancyMenuView *)menu delegate:(id)delegate{
    self = [super init];
    if (self) {
           NSArray *images = @[[UIImage imageNamed:@"sina.png"],[UIImage imageNamed:@"weixin.png"],[UIImage imageNamed:@"send_email.png"],[UIImage imageNamed:@"save.png"]];
        menu.delegate =delegate;
        menu.buttonImages = images;
        
        
        
    }
    return self;
}


//-(void)fancyMenu:(FAFancyMenuView *)menu didSelectedButtonAtIndex:(NSUInteger)index{
//        NSLog(@"%d",index);
//    if (index) {
//        <#statements#>
//    }
//    
//    
//}



/*花瓣按钮回调
 - (void)fancyMenu:(FAFancyMenuView *)menu didSelectedButtonAtIndex:(NSUInteger)index{
 if (index == 0) {
 SinaWeibo *sinaweibo = [self sinaweibo];
 BOOL flag = [sinaweibo isLoggedIn];
 if ( flag == YES ) {
 [self postStatusSina];
 }else{
 SinaWeibo *sinaweibo = [self sinaweibo];
 [sinaweibo logIn];
 }
 }
 }
 
 #pragma mark - SinaWeiboRequest Delegate
 - (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
 {
 if ([request.url hasSuffix:@"users/show.json"])
 {
 //        [userInfo release], userInfo = nil;
 }
 else if ([request.url hasSuffix:@"statuses/user_timeline.json"])
 {
 //        [statuses release], statuses = nil;
 }
 else if ([request.url hasSuffix:@"statuses/update.json"])
 {
 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
 message:[NSString stringWithFormat:@"Post status \"%@\" failed!", postStatusText]
 delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
 [alertView show];
 
 NSLog(@"Post status failed with error : %@", error);
 }
 else if ([request.url hasSuffix:@"statuses/upload.json"])
 {
 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
 message:[NSString stringWithFormat:@"Post image status \"%@\" failed!", postImageStatusText]
 delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
 [alertView show];
 
 NSLog(@"Post image status failed with error : %@", error);
 }
 }
 
 
 - (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
 {
 if ([request.url hasSuffix:@"users/show.json"])
 {
 userInfo = result;
 }
 else if ([request.url hasSuffix:@"statuses/user_timeline.json"])
 {
 statuses = [result objectForKey:@"statuses"];
 }
 else if ([request.url hasSuffix:@"statuses/update.json"])
 {
 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
 message:[NSString stringWithFormat:@"Post status \"%@\" succeed!", [result objectForKey:@"text"]]
 delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
 [alertView show];
 }
 else if ([request.url hasSuffix:@"statuses/upload.json"])
 {
 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
 message:[NSString stringWithFormat:@"Post image status \"%@\" succeed!", [result objectForKey:@"text"]]
 delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
 [alertView show];
 }
 }
 */

@end
