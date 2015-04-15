//
//  TimeViewPort.h
//  Keey
//
//  Created by Ipalibo Whyte on 03/04/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import "InstrumentButton.h"
#import "KeyBoardStepSequencer.h"

@class TimeViewPort;
@protocol TimeViewPortDelegate <NSObject>

- (void) HandleTimeViewPortTouch: (TimeViewPort *)timeView;
- (void) HandleTimeViewPortDoubleTouch: (TimeViewPort *)timeView;

@end
@interface TimeViewPort : InstrumentButton

- (void) displayTimeMarker;
- (void) updateTimeViewStyle;

@property KeyBoardStepSequencer *keyBoardSequencer;
@property BOOL isPlaying;

@property (nonatomic, weak) id <TimeViewPortDelegate> delegate; //define MyClassDelegate as delegate


@end
