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
    
    MusicTrack musicTrackForKeyB;
    MusicTrack musicTrackForASharp;
    MusicTrack musicTrackForKeyA;
    MusicTrack musicTrackForGSharp;
    MusicTrack musicTrackForKeyG;
    MusicTrack musicTrackForFSharp;
    MusicTrack musicTrackForKeyF;
    MusicTrack musicTrackForKeyE;
    MusicTrack musicTrackForDSharp;
    MusicTrack musicTrackForKeyD;
    MusicTrack musicTrackForCSharp;
    MusicTrack musicTrackForKeyC;
    
    MusicPlayer musicPlayer;
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
    NewMusicPlayer(&(musicPlayer));
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
    
    [self setInstrumentPreset :@"KeeyDrumkitsoundfont" withPatch:0];
    
    MusicSequenceSetAUGraph(sequence, graph);
    MusicTrackSetDestNode(musicTrackForKeyB, samplerNode);
    MusicTrackSetDestNode(musicTrackForASharp, samplerNode);
    MusicTrackSetDestNode(musicTrackForKeyA, samplerNode);
    MusicTrackSetDestNode(musicTrackForGSharp, samplerNode);
    MusicTrackSetDestNode(musicTrackForKeyG, samplerNode);
    MusicTrackSetDestNode(musicTrackForFSharp, samplerNode);
    MusicTrackSetDestNode(musicTrackForKeyF, samplerNode);
    MusicTrackSetDestNode(musicTrackForKeyE, samplerNode);
    MusicTrackSetDestNode(musicTrackForDSharp, samplerNode);
    MusicTrackSetDestNode(musicTrackForKeyD, samplerNode);
    MusicTrackSetDestNode(musicTrackForCSharp, samplerNode);
    MusicTrackSetDestNode(musicTrackForKeyC, samplerNode);
    
    MusicPlayerSetSequence(musicPlayer, sequence);
    MusicPlayerStart(musicPlayer);
    
}

- (void) setupMusicTracks {

    
    MusicSequenceNewTrack(sequence, &(musicTrackForKeyB));
    MusicSequenceNewTrack(sequence, &(musicTrackForASharp));
    MusicSequenceNewTrack(sequence, &(musicTrackForKeyA));
    MusicSequenceNewTrack(sequence, &(musicTrackForGSharp));
    MusicSequenceNewTrack(sequence, &(musicTrackForKeyG));
    MusicSequenceNewTrack(sequence, &(musicTrackForFSharp));
    MusicSequenceNewTrack(sequence, &(musicTrackForKeyF));
    MusicSequenceNewTrack(sequence, &(musicTrackForKeyE));
    MusicSequenceNewTrack(sequence, &(musicTrackForDSharp));
    MusicSequenceNewTrack(sequence, &(musicTrackForKeyD));
    MusicSequenceNewTrack(sequence, &(musicTrackForCSharp));
    MusicSequenceNewTrack(sequence, &(musicTrackForKeyC));
    
    
    [self setLoopDuration:16];
    currentOctaveNumber = 71;
}

- (void) setLoopDuration :(int) duration {
    
    MusicTimeStamp trackLen = 0;
    UInt32 trackLenLen = sizeof(trackLen);
    
    MusicTrackLoopInfo loopInfo;
    
    MusicTrackGetProperty(musicTrackForKeyB, kSequenceTrackProperty_TrackLength, &trackLen, &trackLenLen);
    loopInfo.loopDuration = timeDiff*duration;
    loopInfo.numberOfLoops = 0;
    
    MusicTrackSetProperty(musicTrackForKeyB, kSequenceTrackProperty_LoopInfo, &loopInfo, sizeof(loopInfo));
    MusicTrackSetProperty(musicTrackForASharp, kSequenceTrackProperty_LoopInfo, &loopInfo, sizeof(loopInfo));
    MusicTrackSetProperty(musicTrackForKeyA, kSequenceTrackProperty_LoopInfo, &loopInfo, sizeof(loopInfo));
    MusicTrackSetProperty(musicTrackForGSharp, kSequenceTrackProperty_LoopInfo, &loopInfo, sizeof(loopInfo));
    MusicTrackSetProperty(musicTrackForKeyG, kSequenceTrackProperty_LoopInfo, &loopInfo, sizeof(loopInfo));
    MusicTrackSetProperty(musicTrackForFSharp, kSequenceTrackProperty_LoopInfo, &loopInfo, sizeof(loopInfo));
    MusicTrackSetProperty(musicTrackForKeyF, kSequenceTrackProperty_LoopInfo, &loopInfo, sizeof(loopInfo));
    MusicTrackSetProperty(musicTrackForKeyE, kSequenceTrackProperty_LoopInfo, &loopInfo, sizeof(loopInfo));
    MusicTrackSetProperty(musicTrackForDSharp, kSequenceTrackProperty_LoopInfo, &loopInfo, sizeof(loopInfo));
    MusicTrackSetProperty(musicTrackForKeyD, kSequenceTrackProperty_LoopInfo, &loopInfo, sizeof(loopInfo));
    MusicTrackSetProperty(musicTrackForCSharp, kSequenceTrackProperty_LoopInfo, &loopInfo, sizeof(loopInfo));
    MusicTrackSetProperty(musicTrackForKeyC, kSequenceTrackProperty_LoopInfo, &loopInfo, sizeof(loopInfo));
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

- (void) handleMidiEvent: (int) index withType: (MidiEventType) eventType forDrumInstrument: (NSString*)drumType {
    
    MusicTimeStamp timestamp = timeDiff*index;
    MIDINoteMessage notemessage;

    switch (eventType) {
            
        case MidiEventTypeAdd:
            
            notemessage.channel = 0;
            notemessage.velocity = 90;
            notemessage.releaseVelocity = 0;
            notemessage.duration = timeDiff;
            
            notemessage.note = [[drumBank objectForKey:[drumType lowercaseString]] intValue];
            
            //MusicTrackNewMIDINoteEvent(musicTrack, timestamp, &notemessage);

            break;
            
        case MidiEventTypeClear:
            
            //MusicTrackClear(musicTrack, timestamp, timestamp+timeDiff);
            
        default:
            break;
    }

}

- (void) addStepAtPosition: (int) stepPosition withStepLength: (int)stepLength withNoteKey:(PianoRollKeyType) pianoRollKey {
    
    MusicTimeStamp timeStamp = timeDiff*stepPosition;
    MIDINoteMessage notemessage;
    
    notemessage.channel = 0;
    notemessage.velocity = 90;
    notemessage.releaseVelocity = 0;
    notemessage.duration = timeDiff*stepLength;
    notemessage.note = (12 - pianoRollKey)+47;
    
    switch (pianoRollKey) {
            
        case PianoRollKeyTypeB:
            
            MusicTrackNewMIDINoteEvent(musicTrackForKeyB, timeStamp, &notemessage);
            
            break;
            
        case PianoRollKeyTypeASharp:

            MusicTrackNewMIDINoteEvent(musicTrackForASharp, timeStamp, &notemessage);
            
            break;
            
        case PianoRollKeyTypeA:
            
            MusicTrackNewMIDINoteEvent(musicTrackForKeyA, timeStamp, &notemessage);
            
            break;
            
        case PianoRollKeyTypeGSharp:
            
            MusicTrackNewMIDINoteEvent(musicTrackForGSharp, timeStamp, &notemessage);
            
            break;
            
        case PianoRollKeyTypeG:
            
            MusicTrackNewMIDINoteEvent(musicTrackForKeyG, timeStamp, &notemessage);
            
            break;
            
        case PianoRollKeyTypeFSharp:
            
            MusicTrackNewMIDINoteEvent(musicTrackForFSharp, timeStamp, &notemessage);
            
            break;
            
        case PianoRollKeyTypeF:
            
            MusicTrackNewMIDINoteEvent(musicTrackForKeyF, timeStamp, &notemessage);
            
            break;
            
        case PianoRollKeyTypeE:
            
            MusicTrackNewMIDINoteEvent(musicTrackForKeyE, timeStamp, &notemessage);
            
            break;
            
        case PianoRollKeyTypeDSharp:
            
            MusicTrackNewMIDINoteEvent(musicTrackForDSharp, timeStamp, &notemessage);
            
            break;
            
        case PianoRollKeyTypeD:
            
            MusicTrackNewMIDINoteEvent(musicTrackForKeyD, timeStamp, &notemessage);
            
            break;
            
        case PianoRollKeyTypeCSharp:
            
            MusicTrackNewMIDINoteEvent(musicTrackForCSharp, timeStamp, &notemessage);
            
            break;
            
        case PianoRollKeyTypeC:
            
            MusicTrackNewMIDINoteEvent(musicTrackForKeyC, timeStamp, &notemessage);
            
            break;
            
        default:
            break;
            
    }
    
}

- (void) setLengthForStepAtPosition: (int) stepPosition withStepLength: (int) stepLength forNote: (PianoRollKeyType) pianoRollKey {
    
    switch (pianoRollKey) {
            
        case PianoRollKeyTypeB:

            NewMusicEventIterator(musicTrackForKeyB, &(eventIterator));
            
            break;
            
        case PianoRollKeyTypeASharp:
            
            [self resetMusicTracksFor:musicTrackForKeyB];
            NewMusicEventIterator(musicTrackForASharp, &(eventIterator));

            break;
            
        case PianoRollKeyTypeA:
            
            NewMusicEventIterator(musicTrackForKeyA, &(eventIterator));
            
            break;
            
        case PianoRollKeyTypeGSharp:
            
            NewMusicEventIterator(musicTrackForGSharp, &(eventIterator));
            
            break;
            
        case PianoRollKeyTypeG:
            
            NewMusicEventIterator(musicTrackForKeyG, &(eventIterator));
            
            break;
            
        case PianoRollKeyTypeFSharp:
            
            NewMusicEventIterator(musicTrackForFSharp, &(eventIterator));
            
            break;
            
        case PianoRollKeyTypeF:
            
            NewMusicEventIterator(musicTrackForKeyF, &(eventIterator));
            
            break;
            
        case PianoRollKeyTypeE:
            
            NewMusicEventIterator(musicTrackForKeyE, &(eventIterator));
            
            break;
            
        case PianoRollKeyTypeDSharp:
            
            NewMusicEventIterator(musicTrackForDSharp, &(eventIterator));
            
            break;
            
        case PianoRollKeyTypeD:
            
            NewMusicEventIterator(musicTrackForKeyD, &(eventIterator));
            
            break;
            
        case PianoRollKeyTypeCSharp:
            
            NewMusicEventIterator(musicTrackForCSharp, &(eventIterator));
            
            break;
            
        case PianoRollKeyTypeC:
            
            NewMusicEventIterator(musicTrackForKeyC, &(eventIterator));
            
            break;
            
        default:
            
            break;
            
    }
    
    MusicEventIteratorSeek(eventIterator, stepPosition*timeDiff);
    if (stepLength) {
        
        MusicDeviceNoteParams params;
        params.argCount = 2;
        params.mPitch = (12 - pianoRollKey)+71;
        params.mVelocity = 90;
    
        ExtendedNoteOnEvent notemessage;
        notemessage.extendedParams = params;
        notemessage.groupID = 0;
        notemessage.instrumentID = 0;
        notemessage.duration = stepLength * timeDiff;
    
        MusicEventIteratorSetEventInfo(eventIterator, kMusicEventType_ExtendedNote, &notemessage);
        
    } else {
        
         MusicEventIteratorDeleteEvent(eventIterator);
        
    }
    
    DisposeMusicEventIterator(eventIterator);

    
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
        notemessage.note = (12 - (int)[key integerValue])+currentOctaveNumber;
            
            if (step.length) {
                
                [self addStepToTrack:(int)[key integerValue] withTimeStamp:timeStamp noteMessage:notemessage];
                
            }
            
        }

    }
}

- (void) addStepToTrack: (PianoRollKeyType) pianoRollKeyType withTimeStamp: (MusicTimeStamp)timeStamp noteMessage:(MIDINoteMessage) notemessage {
    
    switch (pianoRollKeyType) {
            
        case PianoRollKeyTypeB:
            
            MusicTrackNewMIDINoteEvent(musicTrackForKeyB, timeStamp, &notemessage);
            
            break;
            
        case PianoRollKeyTypeASharp:
            
            MusicTrackNewMIDINoteEvent(musicTrackForASharp, timeStamp, &notemessage);
            
            break;
            
        case PianoRollKeyTypeA:
            
            MusicTrackNewMIDINoteEvent(musicTrackForKeyA, timeStamp, &notemessage);
            
            break;
            
        case PianoRollKeyTypeGSharp:
            
            MusicTrackNewMIDINoteEvent(musicTrackForGSharp, timeStamp, &notemessage);
            
            break;
            
        case PianoRollKeyTypeG:
            
            MusicTrackNewMIDINoteEvent(musicTrackForKeyG, timeStamp, &notemessage);
            
            break;
            
        case PianoRollKeyTypeFSharp:
            
            MusicTrackNewMIDINoteEvent(musicTrackForFSharp, timeStamp, &notemessage);
            
            break;
            
        case PianoRollKeyTypeF:
            
            MusicTrackNewMIDINoteEvent(musicTrackForKeyF, timeStamp, &notemessage);
            
            break;
            
        case PianoRollKeyTypeE:
            
            MusicTrackNewMIDINoteEvent(musicTrackForKeyE, timeStamp, &notemessage);
            
            break;
            
        case PianoRollKeyTypeDSharp:
            
            MusicTrackNewMIDINoteEvent(musicTrackForDSharp, timeStamp, &notemessage);
            
            break;
            
        case PianoRollKeyTypeD:
            
            MusicTrackNewMIDINoteEvent(musicTrackForKeyD, timeStamp, &notemessage);
            
            break;
            
        case PianoRollKeyTypeCSharp:
            
            MusicTrackNewMIDINoteEvent(musicTrackForCSharp, timeStamp, &notemessage);
            
            break;
            
        case PianoRollKeyTypeC:
            
            MusicTrackNewMIDINoteEvent(musicTrackForKeyC, timeStamp, &notemessage);
            
            break;
            
        default:
            break;
            
    }

    
}

- (void) resetMusicTracksFor: (MusicTrack)musicTrack {

    MusicTrackClear(musicTrack, 0, 16);

}

- (void) clearAllMusicTracks {
    
    [self resetMusicTracksFor:musicTrackForKeyA];
    [self resetMusicTracksFor:musicTrackForKeyB];
    [self resetMusicTracksFor:musicTrackForKeyC];
    [self resetMusicTracksFor:musicTrackForKeyD];
    [self resetMusicTracksFor:musicTrackForKeyE];
    [self resetMusicTracksFor:musicTrackForKeyF];
    [self resetMusicTracksFor:musicTrackForKeyG];
    [self resetMusicTracksFor:musicTrackForASharp];
    [self resetMusicTracksFor:musicTrackForCSharp];
    [self resetMusicTracksFor:musicTrackForDSharp];
    [self resetMusicTracksFor:musicTrackForFSharp];
    [self resetMusicTracksFor:musicTrackForGSharp];
    
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
    MusicPlayerSetSequence(musicPlayer, sequence);
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
    insdata.bankLSB  = kAUSampler_DefaultBankLSB;
    insdata.presetID = (UInt8) 0;
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
