//
//  KeyboardViewModel.h
//  Keey
//
//  Created by Ipalibo Whyte on 12/03/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PianoRollConfig.h"

@interface KeyboardViewModel : NSObject

typedef enum KeyType : NSUInteger {
    /*
    KeyTypeB = 0,
    KeyTypeASharp = 1,
    KeyTypeA = 2,
    KeyTypeGSharp = 3,
    KeyTypeG = 4,
    KeyTypeFSharp = 5,
    KeyTypeF = 6,
    KeyTypeE = 7,
    KeyTypeDSharp = 8,
    KeyTypeD = 9,
    KeyTypeCSharp = 10,
    KeyTypeC = 12,
     */
    KeyTypeAdd,
    keyTypeClear
    
} KeyType;

@property NSMutableDictionary *stepSeqStates;


- (void) setupKeys : (int) steps;

- (void) createStepStatesWithSections :(int) sectionCount withKeyNoteCount :(int)rowCount;

- (void) updateStepSeqForPosition: (int) stepPosition withlength: (int)keyLength withKeyNote: (NSUInteger) keyNote;

//- (void) setLengthForStepAtPosition: (int) stepPosition withStepLength: (int) stepLength forNote: (NSUInteger) noteKey;

- (BOOL) isStateSelectedAt :(int)noteNumber positionInPianoRoll:(int) position;

- (void) handleBarChangewithBars :(int)bars;

- (void) handleOctaveChange: (OctaveType) octave;

- (void) handleSwitchPreset: (NSUInteger) presetIndex;

@end
