//
//  PlaylistPatternPortView.m
//  Keey
//
//  Created by Ipalibo Whyte on 02/04/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import "PlaylistPatternPortView.h"

#define SCREEN_WIDTH (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)
#define SCREEN_HEIGHT (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)

@implementation PlaylistPatternPortView

-(void) setUpPorts: (int)totalPorts {
    
    float previousPortPositionX = 100;
    float previousPortPositionY = 0;
    
    for (int port = 0; port < totalPorts; port++) {
        
        UIButton *patternPort = [[UIButton alloc] init];
        patternPort.backgroundColor = [UIColor colorWithRed:0.129 green:0.165 blue:0.184 alpha:1];
        [patternPort setFrame:CGRectMake(previousPortPositionX, previousPortPositionY, 120, 120)];
        [patternPort setTitle:@"hold" forState:UIControlStateHighlighted];
        patternPort.titleLabel.font = [UIFont fontWithName:@"Gotham Rounded" size:25];

        patternPort.layer.cornerRadius = 60;
        
        UILongPressGestureRecognizer *holdGest = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleHoldGest:)];
        [patternPort addGestureRecognizer:holdGest];
        
        patternPort.tag = port;
        
        if ( port % 7 < 3) {
            previousPortPositionX += 200;
            
        } else {
            previousPortPositionX += 200;
        }

        if (port % 7 == 2 ){
            previousPortPositionX = 0;
            previousPortPositionY += 130;
        }
        
        if (port % 6 == 0 && port > 0) {

            previousPortPositionX =  100;
            previousPortPositionY += 130;
            
        }
        
        [self addSubview:patternPort];
    }
    
}

- (void) handleHoldGest: (UIGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        [self.delegate HandlePortHoldGesture:sender];
    }
    
}

@end
