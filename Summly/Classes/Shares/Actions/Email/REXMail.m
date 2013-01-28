//
//  REXMail.m
//  Summly
//
//  Created by zzlmilk on 12-12-21.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import "REXMail.h"

@implementation REXMail

- (id)init{
    if (self=[super init]) {
        

    }

    return self;
}

#pragma mark - 在应用内发送邮件
//激活邮件功能
- (void)sendMailInApp
{
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    if (!mailClass) {
        [self alertWithMessage:@"当前系统版本不支持应用内发送邮件功能"];
        return;
    }
    if (![mailClass canSendMail]) {
        [self alertWithMessage:@"用户没有设置邮件账户"];
        return;
    }
    [self displayMailPicker];
}

//调出邮件发送窗口
- (void)displayMailPicker
{
    MFMailComposeViewController *mailPicker;
    mailPicker = [[MFMailComposeViewController alloc] init];
    mailPicker.mailComposeDelegate = self;
    //设置主题
    [mailPicker setSubject: @"与您一起分享豆豆科技资讯"];
    //添加收件人
//    NSArray *toRecipients = [NSArray arrayWithObject: @"first@example.com"];
//    [mailPicker setToRecipients: toRecipients];
//    //添加抄送
//    NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com", @"third@example.com", nil];
//    [mailPicker setCcRecipients:ccRecipients];
    //添加密送
//    NSArray *bccRecipients = [NSArray arrayWithObjects:@"fourth@example.com", nil];
//    [mailPicker setBccRecipients:bccRecipients];
    
//    // 添加一张图片
//    UIImage *addPic = [UIImage imageNamed: @"Icon@2x.png"];
//    NSData *imageData = UIImagePNGRepresentation(addPic);            // png
//    //关于mimeType：http://www.iana.org/assignments/media-types/index.html
//    [mailPicker addAttachmentData: imageData mimeType: @"" fileName: @"Icon.png"];
    
    //添加一个pdf附件
//    NSString *file = [self fullBundlePathFromRelativePath:@"高质量C++编程指南.pdf"];
//    NSData *pdf = [NSData dataWithContentsOfFile:file];
//    [mailPicker addAttachmentData: pdf mimeType: @"" fileName: @"高质量C++编程指南.pdf"];
    
    NSString *emailBody = @"与您一起分享豆豆科技资讯";
    [mailPicker setMessageBody:emailBody isHTML:NO];
    [self presentModalViewController: mailPicker animated:YES];
}

#pragma mark - 实现 MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    //关闭邮件发送窗口
    [self dismissModalViewControllerAnimated:YES];
    NSString *msg;
    switch (result) {
        case MFMailComposeResultCancelled:
            msg = @"取消编辑邮件";
            break;
        case MFMailComposeResultSaved:
            msg = @"保存邮件成功";
            break;
        case MFMailComposeResultSent:
            msg = @"发送成功";
            break;
        case MFMailComposeResultFailed:
            msg = @"用户保存或者发送邮件失败";
            break;
        default:
            break;
    }
    [self alertWithMessage:msg];
}

- (void)alertWithMessage:(NSString*)msg{

    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alertView show];
}

@end
