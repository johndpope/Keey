//
//  MusicSequencerModel.h
//  Keey
//
//  Created by Ipalibo Whyte on 09/03/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/MusicPlayer.h>

@interface MusicSequencerModel : NSObject

typedef enum MidiEventType : NSUInteger {
    MidiEventTypeAdd,
    MidiEventTypeClear,
    
} MidiEventType;

typedef enum PianoRollKeyType : NSUInteger {
    PianoRollKeyTypeB = 0,
    PianoRollKeyTypeASharp = 1,
    PianoRollKeyTypeA = 2,
    PianoRollKeyTypeGSharp = 3,
    PianoRollKeyTypeG = 4,
    PianoRollKeyTypeFSharp = 5,
    PianoRollKeyTypeF = 6,
    PianoRollKeyTypeE = 7,
    PianoRollKeyTypeDSharp = 8,
    PianoRollKeyTypeD = 9,
    PianoRollKeyTypeCSharp = 10,
    PianoRollKeyTypeC = 11,
    
} PianoRollKeyType;

- (void) setUpSequencer;

- (void) populateMusicTrack: (NSDictionary*)tracksDic;

- (void) setInstrumentPreset : (NSString *)name withPatch: (int) patchNumber;

- (void) handleMidiEvent: (int) index withType: (MidiEventType) eventType forDrumInstrument: (NSString*)drumType;

- (void) addStepAtPosition: (int) stepPosition withStepLength: (int)stepLength withNoteKey:(PianoRollKeyType) pianoRollKey;

- (void) setLengthForStepAtPosition: (int) stepPosition withStepLength: (int) stepLength forNote: (PianoRollKeyType) noteKey;

- (void) setLoopDuration :(int) duration;

- (void) setTracksOctave :(NSUInteger) octaveKey;

@property NSDictionary *soundfontPresets;

@end
