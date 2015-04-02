//
//  InstrumentButton.m
//  Keey
//
//  Created by Ipalibo Whyte on 18/02/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import "InstrumentButton.h"
#import <pop/POP.h>

@implementation InstrumentButton

- ( void ) ofType : (enum InstrumentalType) type ofSize : (enum InstrumentalSize) size {
    
    UIImageView *imageView = [[UIImageView alloc] init];
    CGRect newFrame = self.frame;

    switch (type) {
            
        case InstrumentalTypeDrums:
            self.backgroundColor = [UIColor colorWithRed:0.961 green:0.522 blue:0.137 alpha:1];
            [self setTitle:@"Drums" forState:UIControlStateNormal];
            imageView.image = [UIImage imageNamed:@"drumicon.png"];
            _instrumentType = InstrumentalTypeDrums;
            break;
        
        case InstrumentalTypePiano:
            self.backgroundColor = [UIColor colorWithRed:0.392 green:0.439 blue:0.525 alpha:1];
            [self setTitle:@"Piano" forState:UIControlStateNormal];
            imageView.image = [UIImage imageNamed:@"pianoicon.png"];
            _instrumentType = InstrumentalTypePiano;
            break;
            
        case InstrumentalTypeTrumpet:
            self.backgroundColor = [UIColor colorWithRed:0.494 green:0.827 blue:0.129 alpha:1];
            [self setTitle:@"Trumpet" forState:UIControlStateNormal];
            imageView.image = [UIImage imageNamed:@"trumpeticon.png"];
            _instrumentType = InstrumentalTypeTrumpet;
            break;
            
        case InstrumentalTypeGuitar:
            self.backgroundColor = [UIColor colorWithRed:0.314 green:0.89 blue:0.761 alpha:1];
            [self setTitle:@"Guitar" forState:UIControlStateNormal];
            imageView.image = [UIImage imageNamed:@"guitaricon.png"];
            _instrumentType = InstrumentalTypeGuitar;
            break;
        
        case InstrumentalTypeFlute:
            self.backgroundColor = [UIColor colorWithRed:0.157 green:0.753 blue:0.482 alpha:1];
            [self setTitle:@"Flute" forState:UIControlStateNormal];
            imageView.image = [UIImage imageNamed:@"fluteicon.png"];
            _instrumentType = InstrumentalTypeFlute;
            break;

        case InstrumentalTypeSynth:
            self.backgroundColor = [UIColor colorWithRed:0.973 green:0.431 blue:0.529 alpha:1];
            [self setTitle:@"Synth" forState:UIControlStateNormal];
            imageView.image = [UIImage imageNamed:@"synthicon.png"];
            _instrumentType = InstrumentalTypeSynth;
            break;
        
        case InstrumentalTypeVox:
            self.backgroundColor = [UIColor colorWithRed:0.29 green:0.565 blue:0.886 alpha:1];
            [self setTitle:@"Vox fx" forState:UIControlStateNormal];
            imageView.image = [UIImage imageNamed:@"voxicon.png"];
            _instrumentType = InstrumentalTypeVox;
            break;
            
        default:
            break;
    }
    
    switch (size) {
            
        case BigSize:
            newFrame.size.width = 150;
            newFrame.size.height = 150;
            [self setFrame:newFrame];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(25, 0, 0, 0)];
            [imageView setFrame:CGRectMake(self.frame.size.width/2-15, 40, 25, 35)];
            break;
        
        case SmallSize:
            newFrame.size.width = 120;
            newFrame.size.height = 120;
            [self setFrame:newFrame];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(20, 0, 0, 0)];
            [imageView setFrame:CGRectMake(self.frame.size.width/2-12.5, 30, 25, 25)];
            break;
            
        default:
            break;
    }
    
    // General Button Properties
    [self addSubview:imageView];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.titleLabel.font = [UIFont fontWithName:@"Gotham Rounded" size:14];
    self.layer.cornerRadius = self.frame.size.height/2;
    
    UITapGestureRecognizer *buttonTapRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonDidTap)];
    buttonTapRec.cancelsTouchesInView = NO;
    buttonTapRec.numberOfTapsRequired = 1;
    //[self addGestureRecognizer:buttonTapRec];
    
    _instrumentSize = size;
    
}

- (void) buttonDidTap {
    
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewSize];
    POPSpringAnimation *animCorner = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerCornerRadius];

    switch (_instrumentSize) {
            
        case BigSize:
            
            // Animation for actual size
            anim.fromValue = [NSValue valueWithCGSize:CGSizeMake(100, 100)];
            anim.toValue = [NSValue valueWithCGSize:CGSizeMake(150, 150)];
            anim.springSpeed = 30;
            anim.springBounciness = 10;
            anim.removedOnCompletion = YES;
            [self pop_addAnimation:anim forKey:@"springAnimation"];
            
            // animation for corner radius
            animCorner.fromValue = @50;
            animCorner.toValue = @75;
            animCorner.springSpeed = 30;
            animCorner.springBounciness = 10;
            animCorner.removedOnCompletion = YES;
            [self.layer pop_addAnimation:animCorner forKey:@"springAnimation"];
            
            break;
            
        case SmallSize:
            
            // Animation for actual size
            anim.fromValue = [NSValue valueWithCGSize:CGSizeMake(80, 80)];
            anim.toValue = [NSValue valueWithCGSize:CGSizeMake(120, 120)];
            anim.springSpeed = 30;
            anim.springBounciness = 10;
            anim.removedOnCompletion = YES;
            [self pop_addAnimation:anim forKey:@"springAnimation"];
            
            // animation for corner radius
            animCorner.fromValue = @40;
            animCorner.toValue = @60;
            animCorner.springSpeed = 30;
            animCorner.springBounciness = 10;
            animCorner.removedOnCompletion = YES;
            [self.layer pop_addAnimation:animCorner forKey:@"springAnimation"];
            
            break;
            
        default:
            break;
    }
    
}

@end
