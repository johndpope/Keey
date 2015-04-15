//
//  PlaylistModel.h
//  Keey
//
//  Created by Ipalibo Whyte on 03/04/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KeyBoardStepSequencer.h"
#import "TimeViewPort.h"

@interface PlaylistModel : NSObject

- (void) HandlePatternPortInsert: (KeyBoardStepSequencer *) sender;
- (void) setUpTimerWithDelay: (int) delay;
- (void) addToPlayingQueue: (TimeViewPort *)timeView ;

@property NSMutableArray *queuedPatterns;

@end
