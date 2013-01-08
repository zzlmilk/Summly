//
//  SummlyDetailView.m
//  Summly
//
//  Created by zoe on 12-12-17.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import "SummlyDetailView.h"
#import "AFNetworking.h"
#import "BundleHelp.h"

#define MarginDic 10

@implementation SummlyDetailView
@synthesize summly,imageBackView,titleLabel,acticleView;

- (id)initWithFrame:(CGRect)frame summly:(Summly *)_summly
{
    self = [super initWithFrame:frame];
    if (self) {
    
        mutableArr = [NSMutableArray array];

        sinaShare = [[DDShare alloc] init];
        
        weixingShare = [[DDWeixing alloc] init];
        
        self.summly =_summly;
        self.userInteractionEnabled=YES;
             //标题
        imageBackView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, frame.size.width, 183.5)];
        NSString *randomImageName = [NSString stringWithFormat:@"grad%d@2x.png", arc4random() % 10+1];

        if (_summly.imageUrl!=nil) {
            [imageBackView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_summly.imageUrl]] placeholderImage:[UIImage imageNamed:randomImageName]];
        }
        else{
            imageBackView.image = [UIImage imageNamed:randomImageName];
        }
        [imageBackView setContentMode:UIViewContentModeScaleAspectFill];
        imageBackView.clipsToBounds=YES;
        imageBackView.userInteractionEnabled=YES;
        [self addSubview:imageBackView];

        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(MarginDic, imageBackView.frame.size.height-110, frame.size.width-20, 100)];
        titleLabel.userInteractionEnabled=YES;
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setNumberOfLines:0];
//        [titleLabel setFont:[UIFont systemFontOfSize:20]];
        [titleLabel setFont:[UIFont fontWithName:@"Hei SC" size:20]];
        [titleLabel setTextColor:[UIColor whiteColor]];
//        titleLabel.shadowColor = [UIColor blackColor];
//        titleLabel.shadowOffset = CGSizeMake(0, 0.8);
        titleLabel.text = self.summly.title;
        [self addSubview:titleLabel];
        
        //文章
        acticleView = [[UIView alloc] initWithFrame:CGRectMake(0, imageBackView.frame.size.height, frame.size.width, frame.size.height-imageBackView.frame.size.height)];
        [acticleView setBackgroundColor:[UIColor whiteColor]];
        
        UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(MarginDic, 18, 30, 12)];
        [iconImageView setImage:[UIImage imageNamed:@"publisherIcon.png"]];
        iconImageView.userInteractionEnabled=YES;
        [acticleView addSubview:iconImageView];
        
        UILabel *pulisherLabel = [[UILabel alloc] initWithFrame:CGRectMake(iconImageView.frame.size.width+iconImageView.frame.origin.x+MarginDic, 18, 100, 16)];
        pulisherLabel.userInteractionEnabled=YES;
//        [pulisherLabel setFont:[UIFont boldSystemFontOfSize:11]];
        [pulisherLabel setFont:[UIFont fontWithName:@"Heiti SC" size:11]];
        if (self.summly.scource.length==0) {
            pulisherLabel.text = @"雅虎通讯";
        }
        else{
            pulisherLabel.text = self.summly.scource;
        }
        [pulisherLabel setTextColor:[UIColor colorWithRed:128/255.0f green:128/255.0f blue:128/255.0f alpha:1.0f]];
        [pulisherLabel setBackgroundColor:[UIColor clearColor]];
        [pulisherLabel sizeToFit];
        [acticleView addSubview:pulisherLabel];
        
        UILabel *timeIntervalLabel = [[UILabel alloc] initWithFrame:CGRectMake(pulisherLabel.frame.size.width+pulisherLabel.frame.origin.x+MarginDic, pulisherLabel.frame.origin.y-1, 100, 16)];
        timeIntervalLabel.userInteractionEnabled=YES;
        [timeIntervalLabel setFont:[UIFont systemFontOfSize:11]];
        [timeIntervalLabel setTextColor:[UIColor colorWithRed:0/255.0f green:0/255.0f blue:70/255.0f alpha:1.0f]];
        timeIntervalLabel.text=self.summly.time;
        [timeIntervalLabel sizeToFit];
        [timeIntervalLabel setBackgroundColor:[UIColor clearColor]];
        [acticleView addSubview:timeIntervalLabel];
        
        UILabel *articleLabel = [[UILabel alloc] initWithFrame:CGRectMake(MarginDic, iconImageView.frame.size.height+iconImageView.frame.origin.y+MarginDic*3, frame.size.width-MarginDic*2, acticleView.frame.size.height-(iconImageView.frame.size.height+iconImageView.frame.origin.y+MarginDic)-35)];
        articleLabel.userInteractionEnabled=YES;
        [articleLabel setFont:[UIFont fontWithName:@"Heiti SC" size:15]];
        articleLabel.text = self.summly.describe;
        articleLabel.numberOfLines = 0;
        articleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [articleLabel setBackgroundColor:[UIColor clearColor]];
        [articleLabel setTextColor:[UIColor colorWithRed:77/255.0f green:77/255.0f blue:77/255.0f alpha:1.0f]];
        [acticleView addSubview:articleLabel];
        [self addSubview:acticleView];
        
        //花瓣
        _menu = [[FAFancyMenuView alloc] init];
        _menu.userInteractionEnabled=YES;
        faFancyMenuDataSource = [[FAFancyMenuViewDataSource alloc]initWithMeun:_menu delegate:self];
        [self addSubview:_menu];

    }
    return self;
}

//花瓣按钮
-(void)fancyMenu:(FAFancyMenuView *)menu didSelectedButtonAtIndex:(NSUInteger)index{
    NSLog(@"%d",index);
    //新浪分享 内容待定
    if (index==0) {
        if (sinaShare.sinaWeibo.accessToken==nil) {
            [sinaShare sinaLogin];
            [sinaShare shareContentToSinaWeibo:@""];
        }
        else
            [sinaShare shareContentToSinaWeibo:@""];
        
    }
    //微信
    else if (index==1) {
        
        [weixingShare sendMusicContent];
    }
    //收藏
    else if (index==3) {        
        NSArray *getDic;
        
        BOOL isExist = [BundleHelp fileManagerfileExistsAtPath:SUMMLY_NAME];
        
        if (isExist) {
            NSString *filename = [BundleHelp getBundlePath:SUMMLY_NAME];
            getDic = [NSArray arrayWithContentsOfFile:filename];
            [mutableArr addObjectsFromArray:getDic];

            NSLog(@"%@",self.summly.summlyDic);

            [mutableArr addObject:self.summly.summlyDic];
        }
        else
            [mutableArr addObject:self.summly.summlyDic];
                    
        [BundleHelp writeToFile:mutableArr toPath:SUMMLY_NAME];

    }
    //email
    else if(index==2){
        
    
    }
}


- (void)dismissDetailViewAnimate:(void (^)())block{

    [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionTransitionCurlUp animations:^{
        [titleLabel setFrame:CGRectMake(10, -imageBackView.frame.size.height+73.5, 300,100)];

    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2f delay:0 options:UIViewAnimationOptionTransitionCurlUp animations:^{
            [imageBackView setFrame:CGRectMake(0, -imageBackView.frame.size.height,  320, 183.5)];

        } completion:^(BOOL finished) {
            
        }];
    }];


    [UIView animateWithDuration:0.5f animations:^{
        acticleView.alpha=0.0f;
    } completion:^(BOOL finished) {
        block();
    }];
}

-(void)showDetailViewAnimate{
    [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [titleLabel setFrame:CGRectMake(MarginDic,  73.5f, 300, 100)];
        [imageBackView setFrame:CGRectMake(0, 0,  320, 183.5)];
    } completion:^(BOOL finished) {
    }];
    
    
    [UIView animateWithDuration:0.3f animations:^{
        acticleView.alpha=1.0f;
    } completion:^(BOOL finished) {

    }];

}


@end
