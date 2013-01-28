//
//  AboutViewController.m
//  Summly
//

//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    self.title =@"关于豆豆科技咨询";
    int y = self.view.frame.size.height;
    
//    UIButton *_button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_button setBackgroundImage:[UIImage imageNamed:@"navigation-back-button.png"] forState:UIControlStateNormal];
//    [_button setFrame:CGRectMake(0, 0, 50.0f, 30.0f)];
//    [_button addTarget:self action:@selector(bactToSet) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc]initWithCustomView:_button];
    NSInteger height,labelHeight;
    if (iPhone5==NO) {
        height = y-450;
        labelHeight = y - 260;
    }else{
        height = y-500;
        labelHeight = y - 260-50;

    }
    
    
    //logo
    UIImageView  *logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, height ,396/2,252/2)];
    logoImageView.image = [UIImage imageNamed:@"logo.png"];//加载入图片
    [self.view addSubview:logoImageView];
    
    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, labelHeight, 210, 19)];
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.text = @"网聚通信、科技、IT生活新讯息";
    textLabel.font = [UIFont boldSystemFontOfSize:15];
    textLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:textLabel];
    
    UILabel *text2Label = [[UILabel alloc]initWithFrame:CGRectMake(75, labelHeight+20, 180, 19)];
    text2Label.backgroundColor = [UIColor clearColor];
    text2Label.text = @"轻松、便利、最佳咨讯伙伴";
    text2Label.font = [UIFont boldSystemFontOfSize:15];
    text2Label.textColor = [UIColor whiteColor];
    [self.view addSubview:text2Label];
    

    UIImageView  *eparatedLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, labelHeight,2,30)];
    eparatedLeftImageView.image = [UIImage imageNamed:@"about-eparated@2x.png"];//加载入图片
    [self.view addSubview:eparatedLeftImageView];
    
    UIImageView  *eparatedRightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(290,labelHeight,2,30)];
    eparatedRightImageView.image = [UIImage imageNamed:@"about-eparated@2x.png"];//加载入图片
    [self.view addSubview:eparatedRightImageView];
    
    
    
    UIImageView  *phoneImageView = [[UIImageView alloc] initWithFrame:CGRectMake(13, y - 100,10,10)];
    phoneImageView.image = [UIImage imageNamed:@"phone@2x.png"];//加载入图片
    [self.view addSubview:phoneImageView];
    
    UILabel *phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(33, y - 100, 100, 10)];
    phoneLabel.backgroundColor = [UIColor clearColor];
    phoneLabel.text = @"Hot Line: 4009201168";
    phoneLabel.font = [UIFont systemFontOfSize:10];
    phoneLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:phoneLabel];
    
    
    UIImageView  *emailImageView = [[UIImageView alloc] initWithFrame:CGRectMake(160, y -100,10,10)];
    emailImageView.image = [UIImage imageNamed:@"email@2x.png"];//加载入图片
    [self.view addSubview:emailImageView];
    
    
    UILabel *emailLabel = [[UILabel alloc]initWithFrame:CGRectMake(180, y - 100, 130, 10)];
    emailLabel.backgroundColor = [UIColor clearColor];
    emailLabel.text = @"E-mail:sunliping@emakes.net";
    emailLabel.font = [UIFont systemFontOfSize:10];
    emailLabel.textColor = [UIColor whiteColor];
    [emailLabel sizeToFit];
    [self.view addSubview:emailLabel];
    
}

- (void)bactToSet
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
