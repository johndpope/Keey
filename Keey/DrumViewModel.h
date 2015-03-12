//
//  DrumViewModel.h
//  Keey
//
//  Created by Ipalibo Whyte on 08/03/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MusicSequencerModel.h"

@interface DrumViewModel : NSObject {
    NSMutableArray *kickSteps;
    NSMutableArray *clapsSteps;
    NSMutableArray *snareSteps;
    NSMutableArray *hiHatSteps;
    MusicSequencerModel *musicSeq;
}

typedef enum DrumMood : NSUInteger {
    DrumMoodKick,
    DrumMoodClap,
    DrumMoodSnare,
    DrumMoodHiHats
    
} DrumMood;

- (void) setupDrumIntruments : (int)steps;
- (void) updateStepAt : (int)index forInstrument :(enum DrumMood) drumMood;
- (BOOL) shouldPlaySoundAt : (int)index forIntrument :(enum DrumMood)drumMood;

@end
