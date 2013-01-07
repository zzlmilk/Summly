//
//  DDWeixing.m
//  Summly
//
//  Created by Mars on 13-1-7.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "DDWeixing.h"
#import "WXApi.h"
@implementation DDWeixing


-(id)init{
    if (self = [super init]) {
        [WXApi registerApp:@"wxd930ea5d5a258f4f"];
    }
    return self;
}

//微信

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return  [WXApi handleOpenURL:url delegate:self];
}


- (void) viewContent:(WXMediaMessage *) msg
{
    //显示微信传过来的内容
    WXAppExtendObject *obj = msg.mediaObject;
    
    NSString *strTitle = [NSString stringWithFormat:@"消息来自微信"];
    NSString *strMsg = [NSString stringWithFormat:@"标题：%@ \n内容：%@ \n附带信息：%@ \n缩略图:%u bytes\n\n", msg.title, msg.description, obj.extInfo, msg.thumbData.length];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)doAuth
{
    SendAuthReq* req = [[SendAuthReq alloc] init];
    req.scope = @"post_timeline";
    req.state = @"xxx";
    
    [WXApi sendReq:req];
}

-(void) changeScene:(NSInteger)scene{
    _scene = scene;
}

-(void) onSentTextMessage:(BOOL) bSent
{
    // 通过微信发送消息后， 返回本App
    NSString *strTitle = [NSString stringWithFormat:@"发送结果"];
    NSString *strMsg = [NSString stringWithFormat:@"发送文本消息结果:%u", bSent];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

-(void) onSentMediaMessage:(BOOL) bSent
{
    // 通过微信发送消息后， 返回本App
    NSString *strTitle = [NSString stringWithFormat:@"发送结果"];
    NSString *strMsg = [NSString stringWithFormat:@"发送媒体消息结果:%u", bSent];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

-(void) onSentAuthRequest:(NSString *) userName accessToken:(NSString *) token expireDate:(NSDate *) expireDate errorMsg:(NSString *) errMsg
{
    
}

-(void) onShowMediaMessage:(WXMediaMessage *) message
{
    // 微信启动， 有消息内容。
    [self viewContent:message];
}

-(void) onRequestAppMessage
{
    // 微信请求App提供内容， 需要app提供内容后使用sendRsp返回
    
    NSLog(@"aiaiai");
    //    RespForWeChatViewController* controller = [[RespForWeChatViewController alloc]autorelease];
    //    controller.delegate = self;
    //    [self.viewController presentModalViewController:controller animated:YES];
    
}

-(void) onReq:(BaseReq*)req
{
    if([req isKindOfClass:[GetMessageFromWXReq class]])
    {
        [self onRequestAppMessage];
    }
    else if([req isKindOfClass:[ShowMessageFromWXReq class]])
    {
        ShowMessageFromWXReq* temp = (ShowMessageFromWXReq*)req;
        [self onShowMediaMessage:temp.message];
    }
    
}

-(void) onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        NSString *strTitle = [NSString stringWithFormat:@"发送结果"];
        NSString *strMsg = [NSString stringWithFormat:@"发送媒体消息结果:%d", resp.errCode];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if([resp isKindOfClass:[SendAuthResp class]])
    {
        NSString *strTitle = [NSString stringWithFormat:@"Auth结果"];
        NSString *strMsg = [NSString stringWithFormat:@"Auth结果:%d", resp.errCode];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void) sendImageContent
{
    //发送内容给微信
    WXMediaMessage *message = [WXMediaMessage message];
    [message setThumbImage:[UIImage imageNamed:@"res1thumb.png"]];
    
    WXImageObject *ext = [WXImageObject object];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"res1" ofType:@"jpg"];
    ext.imageData = [NSData dataWithContentsOfFile:filePath] ;
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = _scene;
    
    [WXApi sendReq:req];
}
@end
