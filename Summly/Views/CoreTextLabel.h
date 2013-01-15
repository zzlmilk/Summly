//
//  CoreTextLabel.h
//  core
//
//  Created by lostkid on 13-1-14.
//  Copyright (c) 2013年 邹 露. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface CoreTextLabel : UILabel{
    @private
    CGFloat characterSpacing_;       //字间距
    @private
    long linesSpacing_;   //行间距
}


@property(nonatomic,assign) CGFloat characterSpacing;
@property(nonatomic,assign)long linesSpacing;

@end
