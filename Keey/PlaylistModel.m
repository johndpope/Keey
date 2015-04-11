//
//  PlaylistModel.m
//  Keey
//
//  Created by Ipalibo Whyte on 03/04/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import "PlaylistModel.h"

@implementation PlaylistModel

- (void) setUpTimerWithDelay: (int) delay {
    
    _queuedPatterns = [[NSMutableArray alloc] init];
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(playQueuedPattern) userInfo:nil repeats:YES];
    
}

- (void) HandlePatternPortInsert: (KeyBoardStepSequencer *) sender {
    //NSLog(@"name is : %@", sender.instrumentButton.titleLabel.text);
    [sender startMusicPlayer];
}

/*
fix up the way TimeViewPort communicates with this model class.
It should TimeViewPort should always communicate with the controller
MVC BEST PRACTICES */

- (void) playQueuedPattern {

    for (TimeViewPort* portView in _queuedPatterns) {
        
        if (!portView.isPlaying) {
            
            NSLog(@"Should Start");
            [portView.keyBoardSequencer startMusicPlayer];
            
        } else {
            
            NSLog(@"Should Stop");
            [portView.keyBoardSequencer stopMusicPlayer];

        }
            [portView updateTimeViewStyle];

    }
    [_queuedPatterns removeAllObjects];
    
}

- (void) HandleTimeViewPortTouch: (TimeViewPort *)timeView {
    
    NSLog(@"Time view info is %@ ", timeView.titleLabel.text);
    [_queuedPatterns addObject:timeView];
    
}

@end