//
//  MusicSequencerModel.m
//  Keey
//
//  Created by Ipalibo Whyte on 09/03/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import "MusicSequencerModel.h"
#import "StepState.h"


#define DEFAULT_TIME_DIFF 0.25
#define NUM_SAMPLER_UNITS 1

@implementation MusicSequencerModel {
    MusicSequence sequence;
    MusicEventIterator eventIterator;
    
    MusicTrack patternMusicTrack;
    
    AUGraph graph;
    AudioUnit samplerUnit;
    AudioUnit outputUnit;
    AudioUnit mixerUnit;
    AUNode samplerNode;
    AUNode mixerNode;
    AUNode outputNode;
    
    float timeDiff;
    
    NSDictionary *drumBank;
    NSUInteger currentOctaveNumber;
    
}

- (void) setUpSequencer {
    
    [self setupDrumBank];
    
    timeDiff = DEFAULT_TIME_DIFF;
    
    NewMusicSequence(&(sequence));
    NewMusicPlayer(&(_musicPlayer));
    NewAUGraph(&(graph));
    
    [self setupMusicTracks];
    [self setupIterator];
    [self setupAudioUnitGraph];
    
    Boolean *outisinitialised = false;
    AUGraphIsInitialized(graph, outisinitialised);
    
    if(!outisinitialised){
        AUGraphInitialize(graph);
    }
    
    Boolean *isrunning = false;
    AUGraphIsRunning(graph, isrunning);
    
    if (!isrunning) {
        AUGraphStart(graph);
    }
    
    //[self setInstrumentPreset :@"KeeyDrumkitsoundfont" withPatch:0];
    
    MusicSequenceSetAUGraph(sequence, graph);
    MusicTrackSetDestNode(patternMusicTrack, samplerNode);
    
    MusicPlayerSetSequence(_musicPlayer, sequence);
    MusicPlayerStart(_musicPlayer);
    
}

- (void) setupMusicTracks {
    
    MusicSequenceNewTrack(sequence, &(patternMusicTrack));
    
    [self setLoopDuration:16];
    currentOctaveNumber = 59;
}

- (void) setLoopDuration :(int) duration {
    
    MusicTimeStamp trackLen = 0;
    UInt32 trackLenLen = sizeof(trackLen);
    
    MusicTrackLoopInfo loopInfo;
    
    MusicTrackGetProperty(patternMusicTrack, kSequenceTrackProperty_TrackLength, &trackLen, &trackLenLen);
    loopInfo.loopDuration = timeDiff*duration;
    loopInfo.numberOfLoops = 0;
    
    MusicTrackSetProperty(patternMusicTrack, kSequenceTrackProperty_LoopInfo, &loopInfo, sizeof(loopInfo));
    
}

- (void) setupAudioUnitGraph {
    
    AudioComponentDescription samplerNodeDesc;
    samplerNodeDesc.componentManufacturer = (OSType)kAudioUnitManufacturer_Apple;
    samplerNodeDesc.componentType = (OSType)kAudioUnitType_MusicDevice;
    samplerNodeDesc.componentSubType = (OSType)kAudioUnitSubType_Sampler;
    samplerNodeDesc.componentFlags = 0;
    samplerNodeDesc.componentFlagsMask = 0;
    AUGraphAddNode(graph, &samplerNodeDesc, &(samplerNode));
    
    AudioComponentDescription outputNodeDesc;
    outputNodeDesc.componentManufacturer = (OSType)kAudioUnitManufacturer_Apple;
    outputNodeDesc.componentType = (OSType)kAudioUnitType_Output;
    outputNodeDesc.componentSubType = (OSType)kAudioUnitSubType_RemoteIO;
    outputNodeDesc.componentFlags         = 0;
    outputNodeDesc.componentFlagsMask     = 0;
    AUGraphAddNode(graph, &outputNodeDesc, &(outputNode));
    
    AUGraphOpen(graph);
    
    AUGraphNodeInfo(graph, samplerNode, 0, &(samplerUnit));
    AUGraphNodeInfo(graph, outputNode, 0, &(outputUnit));
    
    AUGraphConnectNodeInput(graph, samplerNode, 0, outputNode, 0);
}

- (void) setInstrumentPreset : (NSString *)name withPatch: (int) patchNumber {
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:name withExtension:@"sf2"];
    [self samplerUnit:samplerUnit loadFromDLSOrSoundFont:url withPatch:patchNumber];
    
}

- (void) handleMidiEvent: (NSUInteger) index withType: (MidiEventType) eventType forDrumInstrument: (NSString*)drumType {
    
    MusicTimeStamp timestamp = timeDiff*index;
    MIDINoteMessage notemessage;

    switch (eventType) {
            
        case MidiEventTypeAdd:
            
            notemessage.channel = 0;
            notemessage.velocity = 90;
            notemessage.releaseVelocity = 0;
            notemessage.duration = timeDiff;
            
            notemessage.note = [[drumBank objectForKey:[drumType lowercaseString]] intValue];
            
            MusicTrackNewMIDINoteEvent(patternMusicTrack, timestamp, &notemessage);

            break;
            
        case MidiEventTypeClear:
            
            MusicTrackClear(patternMusicTrack, timestamp, timestamp+timeDiff);
            
        default:
            break;
    }

}

- (void) setTracksOctave :(NSUInteger) octaveNumber {
    currentOctaveNumber = octaveNumber;
    NSLog(@"%lu", (unsigned long)currentOctaveNumber);
}

- (void) setupIterator {
    
}

- (void) setupDrumBank {
    
    drumBank = [[NSDictionary alloc] initWithObjectsAndKeys:
                [NSNumber numberWithInt:60],@"kick",
                [NSNumber numberWithInt:61],@"snare",
                [NSNumber numberWithInt:62],@"clap",
                [NSNumber numberWithInt:63],@"hihat",
                nil];
}

- (void) setOctaveNoteAtPosition: (NSUInteger) stepPosition ofOctave:(int)octaveIndex forNote: (NSUInteger) noteKey {
    
}

- (void) populateMusicTrack: (NSDictionary*)tracksDic {
    
    [self clearAllMusicTracks];
    
    for(id key in tracksDic) {
        
        NSMutableArray *stepsInRow = (NSMutableArray *)[tracksDic objectForKey:key];
        
        for (StepState *step in stepsInRow) {

        MusicTimeStamp timeStamp = timeDiff* step.position;
        MIDINoteMessage notemessage;
        notemessage.channel = 0;
        notemessage.velocity = 90;
        notemessage.releaseVelocity = 0;
        notemessage.duration = timeDiff*step.length;
        notemessage.note = (12 - (int)[key integerValue]) + (12 * step.octave) - 1 ;
            
            if (step.length) {
                
                //[self addStepToTrack:(int)[key integerValue] withTimeStamp:timeStamp noteMessage:notemessage];
                MusicTrackNewMIDINoteEvent(patternMusicTrack, timeStamp, &notemessage);
            }
            
        }

    }
}

- (void) addStepToTrack: (PianoRollKeyType) pianoRollKeyType withTimeStamp: (MusicTimeStamp)timeStamp noteMessage:(MIDINoteMessage) notemessage {
    
    MusicTrackNewMIDINoteEvent(patternMusicTrack, timeStamp, &notemessage);

}

- (void) resetMusicTracksFor: (MusicTrack)musicTrack {
    
        MusicTrackClear(musicTrack, 0, 16);
    
}

- (void) clearAllMusicTracks {
    
    [self resetMusicTracksFor:patternMusicTrack];
    
}

- (void) playdemo {
    //NewAUGraph(&(graph));
    
    //NewMusicSequence(&sequence);
    
    NSString *midiFilePath = [[NSBundle mainBundle]
                              pathForResource:@"teddybear"
                              ofType:@"mid"];
    
    // Create a new URL which points to the MIDI file
    NSURL * midiFileURL = [NSURL fileURLWithPath:midiFilePath];
    
    MusicSequenceFileLoad(sequence, (__bridge CFURLRef)(midiFileURL), 0, 0);
    
    // Create a new music player
    //MusicPlayer  p;
    // Initialise the music player
    //NewMusicPlayer(&p);
    
    // Load the sequence into the music player
    MusicPlayerSetSequence(_musicPlayer, sequence);
    // Called to do some MusicPlayer setup. This just
    // reduces latency when MusicPlayerStart is called
    //MusicPlayerPreroll(p);
    // Starts the music playing
    //MusicPlayerStart(p);
    
}

- (OSStatus)samplerUnit:(AudioUnit)sampler loadFromDLSOrSoundFont:(NSURL *)bankURL withPatch:(int)presetNumber{
    OSStatus result = noErr;
    
    // Fill out the sampler instrument data structure
    AUSamplerInstrumentData insdata;
    insdata.fileURL = (__bridge CFURLRef) bankURL;
    insdata.bankMSB  = kAUSampler_DefaultMelodicBankMSB;
    insdata.bankLSB  = (UInt8)0;
    insdata.presetID = (UInt8) presetNumber;
    insdata.instrumentType = kInstrumentType_DLSPreset; // DLS and SF2 are the same enum values
    
    // Load the instrument
    result = AudioUnitSetProperty(sampler,
                                  kAUSamplerProperty_LoadInstrument,
                                  kAudioUnitScope_Global,
                                  0,
                                  &insdata,
                                  sizeof(insdata));
    
    NSCAssert (result == noErr,
               @"Unable to set the preset property on the Sampler. Error code: %d",
               (int) result);
    
    return result;
}

@end
