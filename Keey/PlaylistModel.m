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

- (void) playQueuedPattern {

    for (TimeViewPort* portView in _queuedPatterns) {
        [portView displayTimeMarker];
        [portView.keyBoardSequencer startMusicPlayer];
    }
    [_queuedPatterns removeAllObjects];
}

@end
