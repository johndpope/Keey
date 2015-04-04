//
//  TimeViewPort.h
//  Keey
//
//  Created by Ipalibo Whyte on 03/04/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import "InstrumentButton.h"
#import "KeyBoardStepSequencer.h"

@interface TimeViewPort : InstrumentButton

- (void) displayTimeMarker;

@property KeyBoardStepSequencer *keyBoardSequencer;

@end
