//
//  DDWeixing.h
//  Summly
//
//  Created by Mars on 13-1-7.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"

@interface DDWeixing : NSObject<WXApiDelegate>
{
    enum WXScene _scene;
}

- (void)sendImageContent;
-(void) sendMusicContent:(NSString *)summlyTitle;

@end
