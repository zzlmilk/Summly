//
//  SummlyListViewController.h
//  Summly
//
//  Created by zzlmilk on 12-12-13.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Topic.h"
@interface SummlyListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger topicId;
}
@property(nonatomic,strong)Topic *topic;
@property(nonatomic,strong) NSMutableArray *summlysArr;
@end
