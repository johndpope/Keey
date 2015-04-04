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
    int totalBars;
    
}

- (void) createStepStatesWithSections: (int) sectionCount withKeyNoteCount: (int)rowCount {

    _stepSeqStates = [[NSMutableDictionary alloc] init];

    for (int i = 0; i<rowCount; i++) {
        [_stepSeqStates setObject:[self generateSteps:sectionCount] forKey:[NSNumber numberWithInt:i]];
    }
    
    totalBars = 1;
}

- (void) handleBarChangewithBars: (int)bars {
    
    switch (bars) {
            
        case 1:
            
            if (totalBars == 2) {
                
                totalBars = 1;
                
                [musicSeq setLoopDuration:16];
                
                for (int i = 0; i<12; i++) {
                    
                    NSMutableArray *rowAtNote = [_stepSeqStates objectForKey:[NSNumber numberWithInt:i]];
                    
                    [self removePureSteps:32 withStepstate:rowAtNote];
                    
                }
                
                [musicSeq populateMusicTrack:_stepSeqStates];
            }

            
            break;
            
        case 2:
            
            if (totalBars == 1) {
                
                totalBars = 2;
                
                [musicSeq setLoopDuration:32];

                for (int i = 0; i<12; i++) {
                    
                    NSMutableArray *rowAtNote = [_stepSeqStates objectForKey:[NSNumber numberWithInt:i]];

                    for (int j = 0; j<16; j++) {
                        
                        [rowAtNote addObject:[self generatePureStepswithPosition:16+j]];

                    }
                    
                }
                
                [musicSeq populateMusicTrack:_stepSeqStates];
            }
            
            break;
    
        default:
            break;
    }
    
}

- (void) setupKeys: (int) steps {
    
    musicSeq = [[MusicSequencerModel alloc] init];
    [musicSeq setUpSequencer];
    [musicSeq setInstrumentPreset:@"Keey-Guitarsoundfont" withPatch:0];
        
}

- (void) updateStepSeqForPosition: (int) stepPosition withlength: (int)keyLength withKeyNote: (NSUInteger) keyNote {

    NSMutableArray *rowAtNote = [_stepSeqStates objectForKey:[NSNumber numberWithInt:keyNote]];
    StepState *currentStepForNote = [rowAtNote objectAtIndex:stepPosition];
    
    currentStepForNote.length = keyLength;
    
    [musicSeq populateMusicTrack:_stepSeqStates];
    //[musicSeq addStepAtPosition:stepPosition withStepLength:keyLength withNoteKey:keyNote];
    
}

- (BOOL) isStateSelectedAt: (int)noteNumber positionInPianoRoll:(int) position {
    
    NSMutableArray *rowAtNote = [_stepSeqStates objectForKey:[NSNumber numberWithInteger:noteNumber]];
    StepState *currentStepForNote = [rowAtNote objectAtIndex:position];
    
    if (currentStepForNote.length) {
        
        return true;
        
    }
    
    return false;
}

- (void) handleOctaveChange: (OctaveType) octave {
    
    switch (octave) {
            
        case OctaveTypeHigh:
            [musicSeq setTracksOctave:71];
            break;
            
        case OctaveTypeMid:
            [musicSeq setTracksOctave:47];
            break;
            
        case OctaveTypeLow:
            [musicSeq setTracksOctave:23];
            break;
            
        default:
            break;
    }
    
    [musicSeq populateMusicTrack:_stepSeqStates];
    
}

- (void) handleSwitchPreset:(NSUInteger)presetIndex {

    switch (presetIndex) {
            
        case 1:
            [musicSeq setInstrumentPreset:@"Keey-Guitarsoundfont" withPatch:0];
            break;
            
        case 2:
            [musicSeq setInstrumentPreset:@"Keey-BassSoundFont" withPatch:0];
            break;
            
        case 3:
            [musicSeq setInstrumentPreset:@"Keey-BassSoundFont" withPatch:1];
            break;
            
        default:
            break;
    }
}

- (NSMutableArray*) generateSteps: (int)count {
    
    NSMutableArray *steps = [[NSMutableArray alloc] init];
    
    for (int i = 0; i<count; i++) {
        StepState *stepState = [[StepState alloc] init];
        stepState.position = i;
        stepState.length = 0;
        [steps addObject:stepState];
    }
    
    return steps;
}

- (StepState*) generatePureStepswithPosition: (int) position {
    
        StepState *stepState = [[StepState alloc] init];
        stepState.length = 0;
        stepState.position = position;
    
    return stepState;
}

- (NSMutableArray*) removePureSteps: (int) count withStepstate: (NSMutableArray*) stateSteps {
    
    for (int i = count-1; i > 15; i--) {
        
        [stateSteps removeObjectAtIndex:i];
    }
    
    //NSLog(@"%d", [stateSteps count]);

    return stateSteps;
}

- (void)handleMusicControl:(enum MusicPlayerControlType) playerControlType {
    
    switch (playerControlType) {
            
        case MusicPlayerControlTypeStop:
            
            MusicPlayerSetTime([musicSeq musicPlayer], 0);
            MusicPlayerStop([musicSeq musicPlayer]);
            
            break;
            
        case MusicPlayerControlTypeStart:
            
            MusicPlayerStart([musicSeq musicPlayer]);
            
            break;
            
        default:
            break;
    }
    
}

@end
