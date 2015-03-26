//
//  KeyboardViewModel.m
//  Keey
//
//  Created by Ipalibo Whyte on 12/03/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KeyboardViewModel.h"
#import "MusicSequencerModel.h"
#import "StepState.h"

@implementation KeyboardViewModel {
    
    MusicSequencerModel *musicSeq;
    
}

- (void) createStepStatesWithSections :(int) sectionCount withKeyNoteCount :(int)rowCount {

    _stepSeqStates = [[NSMutableDictionary alloc] init];

    for (int i = 0; i<rowCount; i++) {
        [_stepSeqStates setObject:[self generateSteps:sectionCount] forKey:[NSNumber numberWithInt:i]];
    }
    
}

- (void) setupKeys : (int) steps {
    
    musicSeq = [[MusicSequencerModel alloc] init];
    [musicSeq setUpSequencer];
    [musicSeq setInstrumentPreset:@"LV - Hex"];
        
}

- (void) updateStepSeqForPosition: (int) stepPosition withlength: (int)keyLength withKeyNote: (NSUInteger) keyNote {
    NSLog(@"%d", keyLength);
    NSMutableArray *rowAtNote = [_stepSeqStates objectForKey:[NSNumber numberWithInt:keyNote]];
    StepState *currentStepForNote = [rowAtNote objectAtIndex:stepPosition];
    
    if (currentStepForNote.selected) {
        currentStepForNote.selected = NO;
        currentStepForNote.length = 0;
    } else {
        currentStepForNote.selected = YES;
        currentStepForNote.length = keyLength;
    }
    
    [musicSeq populateMusicTrack:_stepSeqStates];
    //[musicSeq addStepAtPosition:stepPosition withStepLength:keyLength withNoteKey:keyNote];
    
}

- (BOOL) isStateSelectedAt :(int)noteNumber positionInPianoRoll:(int) position {
    
    NSMutableArray *rowAtNote = [_stepSeqStates objectForKey:[NSNumber numberWithInteger:noteNumber]];
    StepState *currentStepForNote = [rowAtNote objectAtIndex:position];
    
    if (currentStepForNote.selected) {
        
        return true;
        
    }
    
    return false;
}

/*
- (void) setLengthForStepAtPosition: (int) stepPosition withStepLength: (int) stepLength forNote: (NSUInteger) keyNote {
    
    //[musicSeq setLengthForStepAtPosition:stepPosition withStepLength:stepLength forNote:noteKey];
    
}
 */

- (NSMutableArray*) generateSteps :(int)count {
    
    NSMutableArray *steps = [[NSMutableArray alloc] init];
    
    for (int i = 0; i<count; i++) {
        StepState *stepState = [[StepState alloc] init];
        stepState.position = i;
        stepState.length = 1;
        [steps addObject:stepState];
    }
    
    return steps;
}

@end
