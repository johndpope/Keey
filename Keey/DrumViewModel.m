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
            //[kickSteps replaceObjectAtIndex:index withObject: [NSNumber numberWithBool: ![[kickSteps objectAtIndex:index] boolValue]]];
            break;
        
        case DrumMoodClap:
            clapsSteps[index] = [NSNumber numberWithBool: ![[clapsSteps objectAtIndex:index] boolValue]];

            //[clapsSteps replaceObjectAtIndex:index withObject:[NSNumber numberWithInt:1]];
            break;
        
        case DrumMoodSnare:
            snareSteps[index] = [NSNumber numberWithBool: ![[snareSteps objectAtIndex:index] boolValue]];

            //[snareSteps replaceObjectAtIndex:index withObject:[NSNumber numberWithInt:1]];
            break;
            
        case DrumMoodHiHats:
            hiHatSteps[index] = [NSNumber numberWithBool: ![[hiHatSteps objectAtIndex:index] boolValue]];

            //[hiHatSteps replaceObjectAtIndex:index withObject:[NSNumber numberWithInt:1]];
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
