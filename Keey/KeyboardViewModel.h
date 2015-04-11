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

typedef enum MusicPlayerControlType : NSUInteger {
    MusicPlayerControlTypeStop,
    MusicPlayerControlTypeStart,
    MusicPlayerControlTypeMute
} MusicPlayerControlType;

@property NSMutableDictionary *stepSeqStates;
@property PianoRollConfig *config;


- (void) setupKeys : (int) steps withInstrument:(InstrumentType)type;

- (BOOL) isStateSelectedAt :(int)noteNumber positionInPianoRoll:(int) position;

- (int)  getNoteLengthforNoteRowAt:(int) noteNumber withStepPosition:(NSUInteger) position;

- (int) getOctaveOfStepInPosition: (int) noteNumber withStepPosition:(NSUInteger) position;

- (void) createStepStatesWithSections :(int) sectionCount withKeyNoteCount :(int)rowCount;

- (void) updateStepSeqForPosition: (int) stepPosition withlength: (int)keyLength withKeyNote: (NSUInteger) keyNote;

- (void) updateNoteOctaveForNoteAt: (NSUInteger) stepPosition withOctave: (OctaveType) octaveType withKeyNote: (NSUInteger) keyNote;

- (void) handleBarChangewithBars :(int)bars;

- (void) handleOctaveChange: (OctaveType) octave;

- (void) handleSwitchPreset: (NSInteger) presetIndex;

- (void) handleMusicControl: (enum MusicPlayerControlType) playerControlType;


@end
