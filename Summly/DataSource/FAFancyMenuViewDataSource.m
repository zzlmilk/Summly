//
//  FAFancyMenuViewDataSource.m
//  Summly
//
//  Created by zzlmilk on 12-12-21.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import "FAFancyMenuViewDataSource.h"

@implementation FAFancyMenuViewDataSource

-(id)initWithMeun:(FAFancyMenuView *)menu{
    self = [super init];
    if (self) {
           NSArray *images = @[[UIImage imageNamed:@"petal-twitter.png"],[UIImage imageNamed:@"petal-facebook.png"],[UIImage imageNamed:@"petal-email.png"],[UIImage imageNamed:@"petal-save.png"]];
        menu.delegate =self;
        menu.buttonImages = images;
        
        
    }
    return self;
}


-(void)fancyMenu:(FAFancyMenuView *)menu didSelectedButtonAtIndex:(NSUInteger)index{
        NSLog(@"%d",index);
}



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
 
 
 

 #pragma mark--
 #pragma mark-- ScrollViewDelegate
 - (void)scrollViewDidScroll:(UIScrollView *)_scrollView{
 
 //    if (!_scrollView.dragging==YES ) {
 //        return;
 //    }
 //    for (int i=1; i<self.summlyArr.count; i++) {
 //        SummlyDetailView *detailView =(SummlyDetailView*)[scrollView viewWithTag:11+i];
 //      //  detailView.titleLabel.frame = CGRectMake(_scrollView.contentOffset.x/5, 183.5-110,scrollView.frame.size.width ,100 );
 //        detailView.imageBackView.frame = CGRectMake((_scrollView.contentOffset.x-i*320)/5,0, scrollView.frame.size.width, 183.5);
 //    }
 //    NSLog(@"contentOffset---%f--- %f",_scrollView.contentOffset.x,_scrollView.contentOffset.x/5);
 self.index=[self calculateIndexFromScrollViewOffSet];
 
 }
 
 - (void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView{
 
 //    for (int i=1; i<self.summlyArr.count; i++) {
 //        SummlyDetailView *detailView =(SummlyDetailView*)[scrollView viewWithTag:10+i];
 //        //  detailView.titleLabel.frame = CGRectMake(_scrollView.contentOffset.x/5, 183.5-110,scrollView.frame.size.width ,100 );
 //        detailView.imageBackView.frame = CGRectMake(0,0, scrollView.frame.size.width, 183.5);
 //    }
 }
 
 - (void)didReceiveMemoryWarning
 {
 [super didReceiveMemoryWarning];
 // Dispose of any resources that can be recreated.
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
