//
//  SetViewController.h
//  Summly
//
//  Created by zzlmilk on 12-12-15.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FAFancyMenuView.h"
@interface SetViewController : UIViewController<FAFancyMenuViewDelegate,UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, retain) UITableView *listTable;

@end
