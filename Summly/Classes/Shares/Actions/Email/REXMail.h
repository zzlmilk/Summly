//
//  REXMail.h
//  Summly
//
//  Created by zzlmilk on 12-12-21.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface REXMail : UIViewController<MFMailComposeViewControllerDelegate>
{
}

- (void)sendMailInApp;

@end
