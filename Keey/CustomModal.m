//
//  CustomModal.m
//  Keey
//
//  Created by Ipalibo Whyte on 22/03/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import "CustomModal.h"
#import <pop/POP.h>

@implementation CustomModal {
    UIButton *barOne;
    UIButton *barTwo;
    
    UIButton *sampleOne;
    UIButton *sampleTwo;
    UIButton *sampleThree;
}

- (void) setupView {
    
    _background = [[UIView alloc] init];
    _background.frame = self.frame;
    //background.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    //_background.backgroundColor = [UIColor colorWithRed:0.333 green:0.467 blue:0.514 alpha:0.2];
    [self addSubview:_background];
    
    UITapGestureRecognizer *tapRecog = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(overLayDidTap:)];
    tapRecog.numberOfTapsRequired = 1;
    [_background addGestureRecognizer:tapRecog];
    
    _dashboardView = [[UIView alloc] init];
    _dashboardView.frame = CGRectMake(self.frame.size.width/2-250, self.frame.size.height/2-200, 500, 400);
    _dashboardView.backgroundColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:1];
    _dashboardView.layer.cornerRadius = 10;
    [self addSubview:_dashboardView];
    
    /* Octave Slider */
    
    UILabel *octaveLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, _dashboardView.frame.size.width, 30)];
    octaveLabel.textColor = [UIColor colorWithRed:0.333 green:0.467 blue:0.514 alpha:1];
    octaveLabel.font = [UIFont fontWithName:@"Gotham Rounded" size:20];
    octaveLabel.textAlignment = NSTextAlignmentCenter;
    octaveLabel.text = @"Octave";
    [_dashboardView addSubview:octaveLabel];
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(_dashboardView.frame.size.width/2-125, 70, 250, 30)];
    slider.continuous = NO;
    [slider addTarget:self action:@selector(handleOctaveChange:) forControlEvents:UIControlEventValueChanged];
    slider.minimumValue = 0;
    slider.maximumValue = 2;
    
    UIImage *image = [[UIImage alloc] init];
    image = [UIImage imageNamed:@"thumb@2x.png"];
    [slider setThumbImage:image forState:UIControlStateNormal];
    
    UIImage *sliderLeftTrackImage = [[UIImage imageNamed: @"bar@2x.png"] stretchableImageWithLeftCapWidth: 4 topCapHeight: 0];
    UIImage *sliderRightTrackImage = [[UIImage imageNamed: @"bar@2x.png"] stretchableImageWithLeftCapWidth: 4 topCapHeight: 0];
    [slider setMinimumTrackImage: sliderLeftTrackImage forState: UIControlStateNormal];
    [slider setMaximumTrackImage: sliderRightTrackImage forState: UIControlStateNormal];
    [_dashboardView addSubview:slider];
    
    /* Bars */
    
    UILabel *barsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 140, _dashboardView.frame.size.width, 30)];
    barsLabel.textColor = [UIColor colorWithRed:0.333 green:0.467 blue:0.514 alpha:1];
    barsLabel.font = [UIFont fontWithName:@"Gotham Rounded" size:20];
    barsLabel.textAlignment = NSTextAlignmentCenter;
    barsLabel.text = @"Bars";
    [_dashboardView addSubview:barsLabel];
    
    barOne = [[UIButton alloc] initWithFrame:CGRectMake(_dashboardView.frame.size.width/2-55, 200, 50, 50)];
    [barOne setTitleColor:[UIColor colorWithRed:0.165 green:0.212 blue:0.231 alpha:1] forState:UIControlStateNormal];
    [barOne addTarget:self action:@selector(handleBarChange:) forControlEvents:UIControlEventTouchUpInside];
    barOne.titleLabel.font = [UIFont fontWithName:@"Gotham Rounded" size:30];
    barOne.layer.cornerRadius = 25;
    [barOne setTitle:@"1" forState:UIControlStateNormal];
    barOne.tag = 1;
    [_dashboardView addSubview:barOne];
    
    barTwo = [[UIButton alloc] initWithFrame:CGRectMake(_dashboardView.frame.size.width/2+5, 200, 50, 50)];
    [barTwo setTitleColor:[UIColor colorWithRed:0.165 green:0.212 blue:0.231 alpha:1] forState:UIControlStateNormal];
    [barTwo addTarget:self action:@selector(handleBarChange:) forControlEvents:UIControlEventTouchUpInside];
    barTwo.titleLabel.font = [UIFont fontWithName:@"Gotham Rounded" size:30];
    barTwo.layer.cornerRadius = 25;
    [barTwo setTitle:@"2" forState:UIControlStateNormal];
    barTwo.tag = 2;
    [_dashboardView addSubview:barTwo];
    
    
    UILabel *chooseSampleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 280, _dashboardView.frame.size.width, 30)];
    chooseSampleLabel.textColor = [UIColor colorWithRed:0.333 green:0.467 blue:0.514 alpha:1];
    chooseSampleLabel.font = [UIFont fontWithName:@"Gotham Rounded" size:20];
    chooseSampleLabel.textAlignment = NSTextAlignmentCenter;
    chooseSampleLabel.text = @"Switch Sample";
    [_dashboardView addSubview:chooseSampleLabel];
    
    sampleOne = [[UIButton alloc] initWithFrame:CGRectMake(_dashboardView.frame.size.width/2-100, 330, 50, 50)];
    [sampleOne setBackgroundColor:[UIColor colorWithRed:0.459 green:0.745 blue:0.894 alpha:1]];
    [sampleOne.layer setBorderColor:[[UIColor colorWithRed:0.459 green:0.745 blue:0.894 alpha:1] CGColor]];
    [sampleOne addTarget:self action:@selector(handleSampleChange:) forControlEvents:UIControlEventTouchUpInside];
    sampleOne.layer.cornerRadius = 25;
    sampleOne.tag = 1;
    [_dashboardView addSubview:sampleOne];
    
    sampleTwo = [[UIButton alloc] initWithFrame:CGRectMake(_dashboardView.frame.size.width/2-10, 350, 15, 15)];
    [sampleTwo addTarget:self action:@selector(handleSampleChange:) forControlEvents:UIControlEventTouchUpInside];
    [sampleTwo.layer setBorderColor:[[UIColor colorWithRed:0.706 green:0.894 blue:0.459 alpha:1] CGColor]];
    [sampleTwo setBackgroundColor:[UIColor clearColor]];
    sampleTwo.layer.borderWidth = 3;
    sampleTwo.layer.cornerRadius = 7.5;
    sampleTwo.tag = 2;
    [_dashboardView addSubview:sampleTwo];
    
    sampleThree = [[UIButton alloc] initWithFrame:CGRectMake(_dashboardView.frame.size.width/2+60, 350, 15, 15)];
    [sampleThree addTarget:self action:@selector(handleSampleChange:) forControlEvents:UIControlEventTouchUpInside];
    [sampleThree.layer setBorderColor:[[UIColor colorWithRed:0.459 green:0.894 blue:0.627 alpha:1] CGColor]];
    [sampleThree setBackgroundColor:[UIColor clearColor]];

    sampleThree.layer.borderWidth = 3;
    sampleThree.layer.cornerRadius = 7.5;
    sampleThree.tag = 3;
    [_dashboardView addSubview:sampleThree];
    
    [barOne sendActionsForControlEvents: UIControlEventTouchUpInside];
    
}

- (void) handleOctaveChange: (id)sender {
    
    UISlider *slider = (UISlider *)sender;
    
    int OctaveroundedVal = slider.value;
    
    slider.value = OctaveroundedVal;
    
    [self.delegate CustomModalHandleOctaveChange:OctaveroundedVal];

}

- (void) handleBarChange: (UIButton*)sender {
    
    switch (sender.tag) {
            
        case 1:
            [self setActiveBarButton:barOne];
            [self resetBarButton:barTwo];
            [self.delegate CustomModalHandleBarChange:1];

            break;
            
        case 2:
            [self setActiveBarButton:barTwo];
            [self resetBarButton:barOne];
            [self.delegate CustomModalHandleBarChange:2];

            break;
            
        default:
            break;
    }
    
}

- (void) handleSampleChange: (id)sender {
    
    UIButton *sampleBtn = (UIButton *)sender;
    
    [self.delegate CustomModalSwitchPreset:sampleBtn.tag];
    [self setActiveSampleButton:sender];
    
}

- (void) resetBarButton: (UIButton*)barBtn {
    
    [barBtn setTitleColor:[UIColor colorWithRed:0.333 green:0.467 blue:0.514 alpha:1] forState:UIControlStateNormal];
    barBtn.titleLabel.font = [UIFont fontWithName:@"Gotham Rounded" size:30];
    
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewBackgroundColor];
    anim.toValue = [UIColor clearColor];
    anim.springSpeed = 40;
    anim.springBounciness = 10;
    anim.removedOnCompletion = YES;
    
    POPSpringAnimation *animframe = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerSize];
    animframe.fromValue = [NSValue valueWithCGSize:CGSizeMake(barBtn.frame.size.width+10, barBtn.frame.size.height+10)];
    animframe.toValue = [NSValue valueWithCGSize:CGSizeMake(0, 0)];
    animframe.springSpeed = 40;
    animframe.springBounciness = 10;
    animframe.removedOnCompletion = YES;
    
    [barBtn pop_addAnimation:animframe forKey:@"springAnimation"];
    [barBtn pop_addAnimation:anim forKey:@"springAnimation"];

}

- (void) setActiveSampleButton: (UIButton *)sampleBtn {
    
    
    [sampleOne setFrame:CGRectMake(_dashboardView.frame.size.width/2-90, 350, 15, 15)];
    [sampleOne setBackgroundColor:[UIColor clearColor]];
    sampleOne.layer.borderWidth = 3;
    sampleOne.layer.cornerRadius = 7.5;
    
    [sampleTwo setFrame:CGRectMake(_dashboardView.frame.size.width/2-10, 350, 15, 15)];
    [sampleTwo setBackgroundColor:[UIColor clearColor]];
    sampleTwo.layer.borderWidth = 3;
    sampleTwo.layer.cornerRadius = 7.5;
    
    [sampleThree setFrame:CGRectMake(_dashboardView.frame.size.width/2+60, 350, 15, 15)];
    [sampleThree setBackgroundColor:[UIColor clearColor]];
    sampleThree.layer.borderWidth = 3;
    sampleThree.layer.cornerRadius = 7.5;
    
    POPSpringAnimation *animframe = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerSize];
            
            animframe.fromValue = [NSValue valueWithCGSize:CGSizeMake(0, 0)];
            animframe.toValue = [NSValue valueWithCGSize:CGSizeMake(50, 50)];
            animframe.springSpeed = 40;
            animframe.springBounciness = 10;
            animframe.removedOnCompletion = YES;
            sampleBtn.layer.cornerRadius = 25;
            sampleBtn.layer.backgroundColor = (sampleBtn.layer.borderColor);
            [sampleBtn.layer pop_addAnimation:animframe forKey:@"springAnimation"];
            

}

- (void) setActiveBarButton: (UIButton*)barBtn {

    [barBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    barBtn.titleLabel.font = [UIFont fontWithName:@"Gotham Rounded" size:20];
    
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewBackgroundColor];
    anim.toValue = [UIColor colorWithRed:0.384 green:0.745 blue:0.671 alpha:1];
    anim.removedOnCompletion = YES;
    
    POPSpringAnimation *animframe = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerSize];
    animframe.fromValue = [NSValue valueWithCGSize:CGSizeMake(0, 0)];
    animframe.toValue = [NSValue valueWithCGSize:barBtn.frame.size];
    animframe.springSpeed = 40;
    animframe.springBounciness = 10;
    animframe.removedOnCompletion = YES;
    
    [barBtn.layer pop_addAnimation:animframe forKey:@"springAnimation"];
    [barBtn pop_addAnimation:anim forKey:@"springAnimation"];
    
}

- (void) overLayDidTap: (UITapGestureRecognizer*)sender {
    [self.delegate CustomModalHandleOverlayTap:self];
}

@end
