//
//  DrumViewModel.m
//  Keey
//
//  Created by Ipalibo Whyte on 08/03/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import "DrumViewModel.h"


@implementation DrumViewModel

- (void) setupDrumIntruments : (int)steps {
    
    musicSeq = [[MusicSequencerModel alloc] init];
    [musicSeq setUpSequencer];
    
    kickSteps = [[NSMutableArray alloc] init];
    clapsSteps = [[NSMutableArray alloc] init];
    snareSteps = [[NSMutableArray alloc] init];
    hiHatSteps = [[NSMutableArray alloc] init];
    
    for (int i = 0 ; i < steps; i++) {
        
        [kickSteps addObject:@FALSE];
        [clapsSteps addObject:@FALSE];
        [snareSteps addObject:@FALSE];
        [hiHatSteps addObject:@FALSE];
        
    }
    
}

- (void) updateStepAt : (int)index forInstrument :(enum DrumMood)drumMood {
    
    switch (drumMood) {
            
        case DrumMoodKick:
            
            kickSteps[index] = [NSNumber numberWithBool: ![[kickSteps objectAtIndex:index] boolValue]];

            if ([self shouldPlaySoundAt:index forIntrument:DrumMoodKick]) {
                [musicSeq handleMidiEvent:index withType:MidiEventTypeAdd forDrumInstrument:@"clap"];
            } else {
                NSLog(@"should clear");
                [musicSeq handleMidiEvent:index withType:MidiEventTypeClear forDrumInstrument:@"kick"];
            }
            
            break;
        
        case DrumMoodClap:
            clapsSteps[index] = [NSNumber numberWithBool: ![[clapsSteps objectAtIndex:index] boolValue]];

            break;
        
        case DrumMoodSnare:
            snareSteps[index] = [NSNumber numberWithBool: ![[snareSteps objectAtIndex:index] boolValue]];

            break;
            
        case DrumMoodHiHats:
            hiHatSteps[index] = [NSNumber numberWithBool: ![[hiHatSteps objectAtIndex:index] boolValue]];

            break;
            
        default:
            break;
    }
}

- (BOOL) shouldPlaySoundAt : (int)index forIntrument :(enum DrumMood)drumMood {
    
    switch (drumMood) {
            
        case DrumMoodKick:
            
            if([[kickSteps objectAtIndex:index]  isEqual: @TRUE]){
                return true;
            } else {
                return false;
            }
            break;
            
        case DrumMoodClap:
            
            if([[clapsSteps objectAtIndex:index]  isEqual: @TRUE]){
                return true;
            } else {
                return false;
            }
            
            break;
            
        case DrumMoodSnare:
            
            if([[snareSteps objectAtIndex:index]  isEqual: @TRUE]){
                return true;
            } else {
                return false;
            }
            
            break;
            
        case DrumMoodHiHats:
            
            if([[hiHatSteps objectAtIndex:index]  isEqual: @TRUE]){
                return true;
            } else {
                return false;
            }
            
            break;
            
        default:
            break;
    }
    
}


@end
