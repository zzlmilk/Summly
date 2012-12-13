//
//  SummlyViewController.m
//  SinaPhotoWall
//
//  Created by zzlmilk on 12-12-3.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#define kDefaultSummlyRect  CGRectMake(10, 10, 300, 80)
#define kSummlyHeight 80
#define kMaxSummlys  20
#define unValidIndex -1

#import "SummlyViewController.h"

#import "SummlyAPIClient.h"

@interface SummlyViewController ()

@end

@implementation SummlyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        summlyItems = [[NSMutableArray alloc]init];
        
    }
    return self;
}


-(void)pan:(UIPanGestureRecognizer *)gesture{
    NSLog(@"pan");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    _scrollView = [[CustomerSrollView alloc]initWithFrame:self.view.bounds];
    _scrollView.showsHorizontalScrollIndicator =NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.scrollEnabled =NO;
    [self.view addSubview:_scrollView];
    

    
	// Do any additional setup after loading the view.
    homeSummlyItem = [[SummlyItem alloc]initWithFrame:kDefaultSummlyRect title:@"封面" subTitle:@"了解封面" atIndex:0];
    homeSummlyItem.canMoving =NO;
    homeSummlyItem.delegate= self;
    [_scrollView addSubview:homeSummlyItem];
    [summlyItems insertObject:homeSummlyItem atIndex:0];
    
       
    
    
     addSummlyItem = [[SummlyItem alloc]initWithFrame:CGRectMake(10, 100, 300, 80) title:@"Add" subTitle:@"添加新类" atIndex:1];
    addSummlyItem.canMoving =NO;
    addSummlyItem.delegate= self;
    [_scrollView addSubview:addSummlyItem];
    [summlyItems addObject:addSummlyItem];
    
    
        
        [self addSummlyItem];
        [self addSummlyItem];
        [self addSummlyItem];
        [self addSummlyItem];
        [self addSummlyItem];
        [self addSummlyItem];
}


-(void)addSummlyItem{
    CGRect frame = kDefaultSummlyRect;
    int n = [summlyItems count];
    int row = n-1;
    if (n>kMaxSummlys) {
        NSLog(@"不能创建更多");
        }
    else{
    frame.origin.y = frame.origin.y + row*frame.size.height+row*10;
    SummlyItem *summlyItem = [[SummlyItem alloc]initWithFrame:frame title:[NSString stringWithFormat:@"%d",row] subTitle:[NSString stringWithFormat:@"%d",row] atIndex:row];
    summlyItem.delegate =self;

        
        [summlyItems insertObject:summlyItem atIndex:row];
     [_scrollView addSubview:summlyItem];
    summlyItem =nil;
    
         //move the add summly;
    row = [summlyItems count];
    frame.origin.y  = frame.origin.y +frame.size.height+10;
    
     
        
    [_scrollView setContentSize:CGSizeMake(_scrollView.frame.size.width , frame.size.height+frame.origin.y+10)];
        
    [_scrollView scrollRectToVisible:CGRectMake(_scrollView.frame.origin.x, _scrollView.frame.origin.y+row*frame.size.height,_scrollView.frame.size.width, _scrollView.frame.size.height) animated:YES];
    


        
    [UIView animateWithDuration:0.2f animations:^{
        [addSummlyItem setFrame:frame];
    }];
    
    addSummlyItem.index+=1;

        
}    
    
}

#pragma mark-- SummlyItemDelegate

-(void)summlyItemDidClicked:(SummlyItem*)summlyItem{
    if (summlyItem.index == [summlyItems count]-1) {
        [self addSummlyItem];
    }
    else{
        NSLog(@"%@",summlyItem);
    }
    
    
}

-(void)summlyItemDidEnterEditingMode:(SummlyItem*)summlyItem{    
   
        [summlyItem enableMoving];
        isMoving = YES;
}


-(void)summlyItemDidMoved:(SummlyItem *)summlyItem withLocation:(CGPoint)point moveGestureRecongnzier:
(UILongPressGestureRecognizer*)recognizer{
    CGRect frame = summlyItem.frame;
    CGPoint _point = [recognizer locationInView:_scrollView];
    frame.origin.x = _point.x - point.x;
    frame.origin.y = _point.y - point.y;
    summlyItem.frame = frame;
    
    NSInteger toIndex = [self indexOfLocation:_point];        
    NSInteger fromIndex = summlyItem.index;
    if (toIndex != unValidIndex && toIndex != fromIndex) {
        SummlyItem *moveItem = [summlyItems objectAtIndex:toIndex];
        [_scrollView sendSubviewToBack:moveItem];
        [UIView animateWithDuration:0.2 animations:^{
            CGPoint origin = [self orginPointOfIndex:fromIndex];
            moveItem.frame = CGRectMake(origin.x, origin.y, moveItem.frame.size.width, moveItem.frame.size.height);
        }];
        
        [self exchangeItem:fromIndex withposition:toIndex];
        //移动
        
    }

    
}
-(void)summlyItemDidEndMoved:(SummlyItem *)summlyItem withLocation:(CGPoint)point moveGestureRecongnzier:
(UILongPressGestureRecognizer*)recognizer{
    CGPoint _point = [recognizer locationInView:_scrollView];
    NSInteger toIndex = [self indexOfLocation:_point];
    if (toIndex == unValidIndex) {
        toIndex = summlyItem.index;
    }
    CGPoint origin = [self orginPointOfIndex:toIndex];
    [UIView animateWithDuration:0.2 animations:^{
        summlyItem.frame = CGRectMake(origin.x, origin.y, summlyItem.frame.size.width, summlyItem.frame.size.height);
    }];
            [summlyItem disableMoving];

       isMoving = NO;

}



#pragma mark-- private
- (NSInteger)indexOfLocation:(CGPoint)location{
    NSInteger index; //计算summlyItems 的索引 index= row-1
    NSInteger row =  location.y / (kSummlyHeight + 10);
    
    if (row >= kMaxSummlys ) {
        return  unValidIndex;
    }
    
    index = row-1;
    if (index >= [summlyItems count]) {
        return  unValidIndex;
    }
    
    
    if (index==0) {
        index=1;
    }
    
    return index;
}


- (CGPoint)orginPointOfIndex:(NSInteger)index{
    CGPoint point = CGPointZero;
    if (index > [summlyItems count] || index < 0 ) {
        return point;
    }else{
        
        NSInteger row = index+1;
        point.x = 10;
        point.y = (row-1) *kSummlyHeight + row * 10;

        return  point;
    }
}


- (void)exchangeItem:(NSInteger)oldIndex withposition:(NSInteger)newIndex{
    ((SummlyItem *)[summlyItems objectAtIndex:oldIndex]).index = newIndex;
    ((SummlyItem *)[summlyItems objectAtIndex:newIndex]).index = oldIndex;
    [summlyItems exchangeObjectAtIndex:oldIndex withObjectAtIndex:newIndex];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
