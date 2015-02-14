//
//  BodyView.m
//  Keey
//
//  Created by Ipalibo Whyte on 28/01/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import "BodyView.h"

@implementation BodyView


- (void)layoutSubviews {
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    self.frame = CGRectMake(0, 100, screenWidth, screenHeight);
    self.backgroundColor = [UIColor whiteColor];
    
}

@end
