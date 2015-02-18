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
            _instrumentType = InstrumentalTypePiano;
            break;
            
        case InstrumentalTypeTrumpet:
            self.backgroundColor = [UIColor colorWithRed:0.494 green:0.827 blue:0.129 alpha:1];
            [self setTitle:@"Trumpet" forState:UIControlStateNormal];
            _instrumentType = InstrumentalTypeTrumpet;
            break;
            
        case InstrumentalTypeBrass:
            self.backgroundColor = [UIColor colorWithRed:0.314 green:0.89 blue:0.761 alpha:1];
            [self setTitle:@"Brass" forState:UIControlStateNormal];
            _instrumentType = InstrumentalTypeBrass;
            break;
            
        default:
            break;
    }
    
    switch (size) {
            
        case BigSize:
            newFrame.size.width = 150;
            newFrame.size.height = 150;
            [self setFrame:newFrame];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(20, 0, 0, 0)];
            [imageView setFrame:CGRectMake(self.frame.size.width/2-20, 35, 40, 40)];
            break;
        
        case SmallSize:
            newFrame.size.width = 120;
            newFrame.size.height = 120;
            [self setFrame:newFrame];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(35, 0, 0, 0)];
            [imageView setFrame:CGRectMake(self.frame.size.width/2-20, 30, 40, 40)];
            break;
            
        default:
            break;
    }
    
    // General Button Properties
    [self addSubview:imageView];
    self.titleLabel.font = [UIFont fontWithName:@"Avenir-Heavy" size:18];
    self.layer.cornerRadius = self.frame.size.height/2;
}

@end
