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

- (void) setUpSequencer;

//- (void) addNodeToAugraph;

- (void) setInstrumentPreset;
-(void) handleMidiEvent: (int) index withType: (MidiEventType) eventType forDrumInstrument: (NSString*)drumType;

@property NSDictionary *soundfontPresets;

@end
