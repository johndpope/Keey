//
//  OctavePickerView.m
//  Keey
//
//  Created by Ipalibo Whyte on 05/04/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import "OctavePickerView.h"

@implementation OctavePickerView

- (void) setupView {
    
    self.background = [[UIView alloc] initWithFrame:self.frame];
    [self addSubview:self.background];
    
    UITapGestureRecognizer *tapRecog = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(overlayDidTap:)];
    tapRecog.numberOfTapsRequired = 1;
    [self.background addGestureRecognizer:tapRecog];
    
    self.dashboardView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width/2-150, self.frame.size.height/2-150, 300, 300)];
    self.dashboardView.layer.cornerRadius = 150;
    self.dashboardView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.dashboardView];
    
}

- (void) setupDashboard {
    
    UILabel *octaveLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, self.dashboardView.frame.size.width, 40)];
    octaveLabel.font = [UIFont fontWithName:@"Gotham Rounded" size:20];
    octaveLabel.textColor = [UIColor colorWithRed:0.886 green:0.925 blue:0.937 alpha:1];
    octaveLabel.textAlignment = NSTextAlignmentCenter;
    octaveLabel.text = @"Octave";
    [self.dashboardView addSubview:octaveLabel];
    
    UIButton *octaveOne = [[UIButton alloc] initWithFrame:CGRectMake(self.dashboardView.frame.size.width/6-30, 120, 60, 60)];
    [octaveOne setTitleColor:[UIColor colorWithRed:0.886 green:0.925 blue:0.937 alpha:1] forState:UIControlStateNormal];
    [octaveOne addTarget:self action:@selector(handleOctaveTouch:) forControlEvents:UIControlEventTouchUpInside];
    octaveOne.titleLabel.font = [UIFont fontWithName:@"Gotham Rounded" size:25];
    [octaveOne setTitle:@"1" forState:UIControlStateNormal];
    octaveOne.layer.cornerRadius = 30;
    octaveOne.tag = 1;
    [self.dashboardView addSubview:octaveOne];
    
    UIButton *octaveTwo = [[UIButton alloc] initWithFrame:CGRectMake(self.dashboardView.frame.size.width/2-30, 120, 60, 60)];
    [octaveTwo addTarget:self action:@selector(handleOctaveTouch:) forControlEvents:UIControlEventTouchUpInside];
    [octaveTwo setBackgroundColor:[UIColor colorWithRed:0.384 green:0.745 blue:0.671 alpha:1]];
    [octaveTwo setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    octaveTwo.titleLabel.font = [UIFont fontWithName:@"Gotham Rounded" size:25];
    [octaveTwo setTitle:@"2" forState:UIControlStateNormal];
    octaveTwo.layer.cornerRadius = 30;
    octaveTwo.tag = 2;
    [self.dashboardView addSubview:octaveTwo];
    
    UIButton *octaveThree = [[UIButton alloc] initWithFrame:CGRectMake(self.dashboardView.frame.size.width/1-80, 120, 60, 60)];
    [octaveThree setTitleColor:[UIColor colorWithRed:0.886 green:0.925 blue:0.937 alpha:1] forState:UIControlStateNormal];
    [octaveThree addTarget:self action:@selector(handleOctaveTouch:) forControlEvents:UIControlEventTouchUpInside];
    octaveThree.titleLabel.font = [UIFont fontWithName:@"Gotham Rounded" size:25];
    [octaveThree setTitle:@"3" forState:UIControlStateNormal];
    octaveThree.layer.cornerRadius = 30;
    octaveThree.tag = 3;
    [self.dashboardView addSubview:octaveThree];
    
}

- (void) handleOctaveTouch: (UIButton *)octaveIndex {
    
    switch (octaveIndex.tag) {
            
        case 1:
            [self.octavePickerDelegate HandleNoteOctaveChange:1];
            break;
            
        case 2:
            [self.octavePickerDelegate HandleNoteOctaveChange:2];
            break;
            
        case 3:
            [self.octavePickerDelegate HandleNoteOctaveChange:3];
            break;
            
        default:
            break;
            
    }
    
}

- (void) overlayDidTap: (UIGestureRecognizer *)sender {
    
    [self.octavePickerDelegate HandleOctaveOverlayTap:self];
}

@end
