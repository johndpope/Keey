//
//  InstrumentButton.m
//  Keey
//
//  Created by Ipalibo Whyte on 18/02/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import "InstrumentButton.h"

@implementation InstrumentButton

- ( void ) ofType : (enum InstrumentalType) type ofSize : (enum InstrumentalSize) size {
    
    UIImageView *imageView = [[UIImageView alloc] init];
    CGRect newFrame = self.frame;

    switch (type) {
            
        case InstrumentalTypeDrums:
            self.backgroundColor = [UIColor colorWithRed:0.961 green:0.651 blue:0.137 alpha:1];
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
    self.titleLabel.font = [UIFont fontWithName:@"Avenir-Heavy" size:18];
    self.layer.cornerRadius = self.frame.size.height/2;
    
}

@end
