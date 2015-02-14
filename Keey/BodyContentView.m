//
//  BodyContentView.m
//  Keey
//
//  Created by Ipalibo Whyte on 28/01/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import "BodyContentView.h"

@implementation BodyContentView

-(void)layoutSubviews {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    self.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    self.backgroundColor = [UIColor colorWithRed:0.145 green:0.169 blue:0.192 alpha:1];
}

@end
