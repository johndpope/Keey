//
//  KeyboardViewModel.m
//  Keey
//
//  Created by Ipalibo Whyte on 12/03/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import "KeyboardViewModel.h"
#import "MusicSequencerModel.h"

@implementation KeyboardViewModel {
    MusicSequencerModel *musicSeq;
    bool switchVal;
}

- (void) setupKeys : (int) steps {
    
    musicSeq = [[MusicSequencerModel alloc] init];
    [musicSeq setUpSequencer];
    [musicSeq setInstrumentPreset:@"GeneralUser GS MuseScore v1.442"];
    
    switchVal = true;
    
}

- (void) updateStepSeqForPosition: (int) stepPosition withlength: (int)keyLength withKeyNote: (NSUInteger) keyNote {
    
    [musicSeq addStepAtPosition:stepPosition withStepLength:keyLength withNoteKey:keyNote];
    
}

- (void) setLengthForStepAtPosition: (int) stepPosition withStepLength: (int) stepLength forNote: (NSUInteger) noteKey {
    
    [musicSeq setLengthForStepAtPosition:stepPosition withStepLength:stepLength forNote:noteKey];
    
}

@end
