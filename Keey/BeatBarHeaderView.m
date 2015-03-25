//
//  BeatBarHeaderView.m
//  Keey
//
//  Created by Ipalibo Whyte on 25/03/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import "BeatBarHeaderView.h"

@implementation BeatBarHeaderView

- (void) setUpViewWithCount: (int)barsCount withSpacing: (int)spacing {
    
    int horizontalSpace = 0;
    
    for (int i = 0; i<4; i++) {
        
        UIView *barIndicator = [[UIView alloc] init];
        barIndicator.frame = CGRectMake(horizontalSpace, 0, (35*4) + (20*3)+6, 3);
        
        if (i%2 == 0) {
            
            barIndicator.backgroundColor = [UIColor colorWithRed:0.333 green:0.467 blue:0.514 alpha:1];
            
        } else {
            
            barIndicator.backgroundColor = [UIColor colorWithRed:0.333 green:0.467 blue:0.514 alpha:0.48];
            
        }
        horizontalSpace += spacing;
        [self addSubview:barIndicator];
        
    }
    
}

@end
