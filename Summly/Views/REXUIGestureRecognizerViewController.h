//
//  REXUIGestureRecognizerViewController.h
//  SinaPhotoWall
//
//  Created by zzlmilk on 12-12-2.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface REXUIGestureRecognizerViewController : UIViewController
{
    UISwipeGestureRecognizer*       swipeRecognizer;
    UIPinchGestureRecognizer*       pinRecongnizer;
    UIRotationGestureRecognizer*    rotaionRecongnizer;
    UITapGestureRecognizer*         tapRecongnizer;
}


- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer;





@end
