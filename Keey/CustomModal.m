//
//  CustomModal.m
//  Keey
//
//  Created by Ipalibo Whyte on 22/03/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import "CustomModal.h"

@implementation CustomModal {
    UIView *background;
    UIView *dashboardView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void) setupView {
    
    background = [[UIView alloc] init];
    background.frame = self.frame;
    background.backgroundColor = [UIColor colorWithRed:0.333 green:0.467 blue:0.514 alpha:0.4];
    [self addSubview:background];
    
    UITapGestureRecognizer *tapRecog = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(overLayDidTap:)];
    tapRecog.numberOfTapsRequired = 1;
    [background addGestureRecognizer:tapRecog];
    
    dashboardView = [[UIView alloc] init];
    dashboardView.frame = CGRectMake(self.frame.size.width/2-200, self.frame.size.height/2-200, 400, 400);
    dashboardView.backgroundColor = [UIColor whiteColor];
    dashboardView.layer.cornerRadius = 10;
    [self addSubview:dashboardView];
    
    UILabel *octaveLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, dashboardView.frame.size.width, 30)];
    octaveLabel.textColor = [UIColor colorWithRed:0.165 green:0.212 blue:0.231 alpha:1];
    octaveLabel.font = [UIFont fontWithName:@"Avenir" size:20];
    octaveLabel.textAlignment = NSTextAlignmentCenter;
    octaveLabel.text = @"Octave";
    [dashboardView addSubview:octaveLabel];
    
    UILabel *barsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, dashboardView.frame.size.width, 30)];
    barsLabel.textColor = [UIColor colorWithRed:0.165 green:0.212 blue:0.231 alpha:1];
    barsLabel.font = [UIFont fontWithName:@"Avenir" size:20];
    barsLabel.textAlignment = NSTextAlignmentCenter;
    barsLabel.text = @"Bars";
    [dashboardView addSubview:barsLabel];
    
    UILabel *chooseSampleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 280, dashboardView.frame.size.width, 30)];
    chooseSampleLabel.textColor = [UIColor colorWithRed:0.165 green:0.212 blue:0.231 alpha:1];
    chooseSampleLabel.font = [UIFont fontWithName:@"Avenir" size:20];
    chooseSampleLabel.textAlignment = NSTextAlignmentCenter;
    chooseSampleLabel.text = @"Choose a sample";
    [dashboardView addSubview:chooseSampleLabel];
}

- (void) overLayDidTap: (UITapGestureRecognizer*)sender {
    [self.delegate CustomModalViewDelegateMethod:self];
}

@end
