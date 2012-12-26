//
//  DDShare.h
//  Summly
//
//  Created by zzlmilk on 12-12-25.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SinaWeibo.h"

@interface DDShare : NSObject<SinaWeiboDelegate>
{

}

@property(nonatomic,strong)    SinaWeibo *sinaWeibo;




//sina
-(void)sinaLogin;

-(void)sinaLoginOut;
@end
