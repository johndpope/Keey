//
//  OctavePickerView.m
//  Keey
//
//  Created by Ipalibo Whyte on 05/04/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import "OctavePickerView.h"

@implementation OctavePickerView {
    int selectedMenuOption;
    UIView *octaveButtonContainer;
}

- (void) setupView {
    
    self.background = [[UIView alloc] initWithFrame:self.frame];
    [self addSubview:self.background];
    
    UITapGestureRecognizer *tapRecog = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(overlayDidTap:)];
    tapRecog.numberOfTapsRequired = 1;
    [self.background addGestureRecognizer:tapRecog];
    
    self.dashboardView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width/2-150, self.frame.size.height/2-150, 300, 300)];
    self.dashboardView.layer.cornerRadius = 150;
    self.dashboardView.backgroundColor = [UIColor whiteColor];
    self.dashboardView.clipsToBounds = YES;
    
    UISwipeGestureRecognizer *swipeRightGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    UISwipeGestureRecognizer *swipeLeftGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    swipeRightGesture.direction = UISwipeGestureRecognizerDirectionRight;
    swipeLeftGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.dashboardView addGestureRecognizer:swipeRightGesture];
    [self.dashboardView addGestureRecognizer:swipeLeftGesture];
    [self addSubview:self.dashboardView];
    
    selectedMenuOption = 2;
}

- (void) setupDashboard {
    
    UILabel *octaveLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, self.dashboardView.frame.size.width, 40)];
    octaveLabel.font = [UIFont fontWithName:@"Gotham Rounded" size:20];
    octaveLabel.textColor = [UIColor colorWithRed:0.886 green:0.925 blue:0.937 alpha:1];
    octaveLabel.textAlignment = NSTextAlignmentCenter;
    octaveLabel.text = @"Octave";
    [self.dashboardView addSubview:octaveLabel];
    
    UIView *selectedView = [[UIView alloc] initWithFrame:CGRectMake(self.dashboardView.frame.size.width/2 - 40, 110, 80, 80)];
    [selectedView setBackgroundColor:[UIColor colorWithRed:0.384 green:0.745 blue:0.671 alpha:1]];
    selectedView.layer.cornerRadius = 40;
    [self.dashboardView addSubview:selectedView];
    
    octaveButtonContainer = [[UIView alloc] initWithFrame:CGRectMake(self.dashboardView.frame.size.width/6-50, 0, self.dashboardView.frame.size.width, 60)];
    [self.dashboardView addSubview:octaveButtonContainer];
    
    UIButton *octaveOne = [[UIButton alloc] initWithFrame:CGRectMake(self.dashboardView.frame.size.width/6-30, 120, 60, 60)];
    [octaveOne setTitleColor:[UIColor colorWithRed:0.886 green:0.925 blue:0.937 alpha:1] forState:UIControlStateNormal];
    //[octaveOne addTarget:self action:@selector(handleOctaveTouch:) forControlEvents:UIControlEventTouchUpInside];
    octaveOne.titleLabel.font = [UIFont fontWithName:@"Gotham Rounded" size:25];
    [octaveOne setTitle:@"1" forState:UIControlStateNormal];
    octaveOne.layer.cornerRadius = 30;
    octaveOne.tag = 1;
    [octaveButtonContainer addSubview:octaveOne];
    
    UIButton *octaveTwo = [[UIButton alloc] initWithFrame:CGRectMake(self.dashboardView.frame.size.width/2-30, 120, 60, 60)];
    //[octaveTwo addTarget:self action:@selector(handleOctaveTouch:) forControlEvents:UIControlEventTouchUpInside];
    [octaveTwo setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    octaveTwo.titleLabel.font = [UIFont fontWithName:@"Gotham Rounded" size:25];
    [octaveTwo setTitle:@"2" forState:UIControlStateNormal];
    octaveTwo.layer.cornerRadius = 30;
    octaveTwo.tag = 2;
    [octaveButtonContainer addSubview:octaveTwo];
    
    UIButton *octaveThree = [[UIButton alloc] initWithFrame:CGRectMake(self.dashboardView.frame.size.width/1-80, 120, 60, 60)];
    [octaveThree setTitleColor:[UIColor colorWithRed:0.886 green:0.925 blue:0.937 alpha:1] forState:UIControlStateNormal];
    //[octaveThree addTarget:self action:@selector(handleOctaveTouch:) forControlEvents:UIControlEventTouchUpInside];
    octaveThree.titleLabel.font = [UIFont fontWithName:@"Gotham Rounded" size:25];
    [octaveThree setTitle:@"3" forState:UIControlStateNormal];
    octaveThree.layer.cornerRadius = 30;
    octaveThree.tag = 3;
    [octaveButtonContainer addSubview:octaveThree];
    
    UIButton *deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 220, self.dashboardView.frame.size.width, 50)];
    [deleteButton addTarget:self action:@selector(handleDeleteTouch) forControlEvents:UIControlEventTouchUpInside];
    deleteButton.titleLabel.font = [UIFont fontWithName:@"fontello" size:25];
    [deleteButton setTitle:@"\uE807" forState:UIControlStateNormal];
    [deleteButton setTitleColor:[UIColor colorWithRed:0.886 green:0.925 blue:0.937 alpha:1] forState:UIControlStateNormal];
    [deleteButton setTitleColor:[UIColor colorWithRed:0.216 green:0.227 blue:0.267 alpha:1] forState:UIControlStateHighlighted];
    [self.dashboardView addSubview:deleteButton];
}

- (void) handleOctaveTouch: (UIButton *)octaveIndex {

    [self changeOctave:octaveIndex.tag];

}

- (void) handleDeleteTouch {
    [self.octavePickerDelegate HandleNoteDeleteTouch];
}

- (void) changeOctave: (NSInteger)index {
    [self.octavePickerDelegate HandleNoteOctaveChange:(int)index];
}

- (void) overlayDidTap: (UIGestureRecognizer *)sender {
    
    [self.octavePickerDelegate HandleOctaveOverlayTap:self];
}

- (void) handleSwipe: (UISwipeGestureRecognizer *)sender {
    
    if ( sender.direction == UISwipeGestureRecognizerDirectionLeft){
        
        if (selectedMenuOption < 3) {
            selectedMenuOption++;
        }
        
    } else {
        
        if (selectedMenuOption > 1) {
            selectedMenuOption--;
            
        }
        
    }
    [self selectOctaveIndex:selectedMenuOption];
    
}

- (void) selectOctaveIndex: (int) index {
    
    switch (index) {
            
        case 1:
            [self updateMenu: (self.dashboardView.frame.size.width/1-50)];
            
            break;
        case 2:
            [self updateMenu: (self.dashboardView.frame.size.width/2)];
            
            break;
        case 3:
            [self updateMenu: (self.dashboardView.frame.size.width/6)];
            
            break;
            
        default:
            break;
    }
    
    [self changeOctave:index];
    
}

- (void) updateMenu: (float) positionX {
    
    NSLog(@"POS X IS: %f", positionX);
     POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
     animation.toValue = [NSNumber numberWithFloat: positionX];
     animation.springSpeed = 30;
     animation.springBounciness = 10;
     animation.removedOnCompletion = YES;
     [octaveButtonContainer pop_addAnimation:animation forKey:@"springAnimation"];
    
}

@end
