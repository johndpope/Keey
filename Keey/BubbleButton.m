//
//  BubbleButton.m
//  Keey
//
//  Created by Ipalibo Whyte on 03/02/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import "BubbleButton.h"

@implementation BubbleButton


- (instancetype) init {
    
    return self;
}

- (void) setSize:(NSString*)size {
    
    if ([size isEqualToString:@"small"]) {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, 60, 60);
    }

    else if ([size isEqualToString:@"medium"]) {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, 100, 100);
    }
    
    else if ([size isEqualToString:@"large"]) {
        self.frame = CGRectMake(0, 0, 150, 150);
    }
    
    self.layer.cornerRadius = self.frame.size.height/2;
}

- (void) setLabelTitle :(NSString*)title{
    [self setTitle:title forState:UIControlStateNormal];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:20];
}

@end
