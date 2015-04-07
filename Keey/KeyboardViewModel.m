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

- (void) setupKeys :(int) steps withInstrument:(InstrumentType)type {
    
    _config = [[PianoRollConfig alloc] init];
    _config.currentOctave = OctaveTypeMid;
    [_config setInstrumentType:type];
    _config.currentMeasure = 1;
    
    musicSeq = [[MusicSequencerModel alloc] init];
    [musicSeq setUpSequencer];
    //[musicSeq setInstrumentPreset:@"Keey-Guitarsoundfont" withPatch:0];
    [musicSeq setInstrumentPreset:@"Keey-BassSoundFont" withPatch:0];
    
        
}

- (void) updateStepSeqForPosition: (int) stepPosition withlength: (int)keyLength withKeyNote: (NSUInteger) keyNote {

    NSMutableArray *rowAtNote = [_stepSeqStates objectForKey:[NSNumber numberWithInteger:keyNote]];
    StepState *currentStepForNote = [rowAtNote objectAtIndex:stepPosition];
    
    currentStepForNote.length = keyLength;
    
    [musicSeq populateMusicTrack:_stepSeqStates];
    
}

- (void) updateNoteOctaveForNoteAt: (NSUInteger) stepPosition withOctave: (OctaveType) octaveType withKeyNote: (NSUInteger) keyNote {
    
    NSMutableArray *rowAtNote = [_stepSeqStates objectForKey:[NSNumber numberWithInteger:keyNote]];
    StepState *currentStepForNote = [rowAtNote objectAtIndex:stepPosition];
    //NSLog(@"current step octave is:%d desire is: %lu", currentStepForNote.octave, octaveType);

    currentStepForNote.octave = octaveType;
    
    
    switch (octaveType) {
        case OctaveTypeHigh:
            currentStepForNote.octave = 5;
            break;
            
        case OctaveTypeMid:
            currentStepForNote.octave = 4;
            break;
            
        case OctaveTypeLow:
            currentStepForNote.octave = 3;
            break;
            
        default:
            break;
    }
    
    [musicSeq populateMusicTrack:_stepSeqStates];
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
            [musicSeq setTracksOctave:59];
            break;
            
        case OctaveTypeMid:
            [musicSeq setTracksOctave:47];
            break;
            
        case OctaveTypeLow:
            [musicSeq setTracksOctave:35];
            break;
            
        default:
            break;
    }
    
    [musicSeq populateMusicTrack:_stepSeqStates];
    
}

- (void) handleSwitchPreset:(NSInteger)presetIndex {
    
    switch (presetIndex) {
            
        case 1:
            [self swapPresetForInstrument:_config.instrumentType withPreset:0];
            break;
            
        case 2:
            [self swapPresetForInstrument:_config.instrumentType withPreset:1];
            
            break;
            
        case 3:
            [self swapPresetForInstrument:_config.instrumentType withPreset:2];
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
        stepState.octave = 4;
        [steps addObject:stepState];
    }
    
    return steps;
}

- (StepState*) generatePureStepswithPosition: (int) position {
    
        StepState *stepState = [[StepState alloc] init];
        stepState.length = 0;
        stepState.position = position;
        stepState.octave = 4;

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

- (void) swapPresetForInstrument: (InstrumentType)instrument withPreset:(NSInteger) presetNumber {
    
    switch (instrument) {
            
        case InstrumentTypeDrums:
            //[musicSeq setInstrumentPreset:@"Keey-DrumsSoundFont" withPatch:presetNumber];
            break;
            
        case InstrumentTypePiano:
            //[musicSeq setInstrumentPreset:@"Keey-BassSoundFont" withPatch:presetNumber];
            break;
            
        case InstrumentTypeGuitar:
            //[musicSeq setInstrumentPreset:@"Keey-GuitarSoundFont" withPatch:presetNumber];
            break;
            
        case InstrumentTypeSynth:
            [musicSeq setInstrumentPreset:@"Keey-BassSoundFont" withPatch:presetNumber];
            break;
            
        case InstrumentTypeFlute:
            //[musicSeq setInstrumentPreset:@"Keey-FluteSoundFont" withPatch:presetNumber];
            break;
        
        case InstrumentTypeTrumpet:
            //[musicSeq setInstrumentPreset:@"Keey-BrassSoundFont" withPatch:presetNumber];
            break;
            
        case InstrumentTypeVox:
            //[musicSeq setInstrumentPreset:@"Keey-VoxSoundFont" withPatch:presetNumber];
            break;
            
        default:
            break;
    }
}

@end
