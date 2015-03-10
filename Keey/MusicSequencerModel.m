//
//  MusicSequencerModel.m
//  Keey
//
//  Created by Ipalibo Whyte on 09/03/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import "MusicSequencerModel.h"
#define NUM_SAMPLER_UNITS 1

@implementation MusicSequencerModel {
    MusicSequence sequence;
    MusicTrack musicTrack;
    MusicPlayer musicPlayer;
    AUGraph graph;
    AudioUnit samplerUnit;
    AudioUnit outputUnit;
    AudioUnit mixerUnit;
    AUNode samplerNode;
    AUNode mixerNode;
    AUNode outputNode;
    
}

- (void) setUpSequencer {
    
    NewMusicSequence(&(sequence));
    NewMusicPlayer(&(musicPlayer));
    NewAUGraph(&(graph));
    
    [self setupMusicTracks];
    [self setupAudioUnitGraph];
    
    Boolean *outisinitialised = false;
    //AUGraphIsInitialized(graph, outisinitialised);
    
    if(!outisinitialised){
        AUGraphInitialize(graph);
    }
    
    Boolean *isrunning = false;
    AUGraphIsRunning(graph, isrunning);
    
    if (!isrunning) {
        AUGraphStart(graph);
    }
    
    [self setInstrumentPreset];
    
    
    MusicSequenceSetAUGraph(sequence, graph);
    MusicTrackSetDestNode(musicTrack, samplerNode);
    MusicPlayerSetSequence(musicPlayer, sequence);
    MusicPlayerStart(musicPlayer);
    
    

    
}

- (void) setupMusicTracks {
    
    MusicTimeStamp trackLen = 0;
    UInt32 trackLenLen = sizeof(trackLen);
    
    
    MusicTrackLoopInfo loopInfo;
    
    MusicSequenceNewTrack(sequence, &(musicTrack));
    
    MusicTimeStamp timestamp = 1;
    MusicTimeStamp timestampex = 3;
    
    MIDINoteMessage notemessage;
    notemessage.channel = 0;
    notemessage.velocity = 90;
    notemessage.releaseVelocity = 0;
    notemessage.duration = 2;
    notemessage.note = 60;
    
    MIDINoteMessage notemessaged;
    notemessaged.channel = 0;
    notemessaged.velocity = 90;
    notemessaged.releaseVelocity = 0;
    notemessaged.duration = 2;
    notemessaged.note = 55;
    
    MusicTrackNewMIDINoteEvent(musicTrack, timestamp, &notemessage);
    MusicTrackNewMIDINoteEvent(musicTrack, timestampex, &notemessaged);
    

    MusicTrackGetProperty(musicTrack, kSequenceTrackProperty_TrackLength, &trackLen, &trackLenLen);
    loopInfo.loopDuration = trackLen;
    loopInfo.numberOfLoops = 0;
    MusicTrackSetProperty(musicTrack, kSequenceTrackProperty_LoopInfo, &loopInfo, sizeof(loopInfo));
    NSLog(@"track length is %f", trackLen);

    

    
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

- (void) setInstrumentPreset {
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"BrassEnsembleSE" withExtension:@"sf2"];
    [self samplerUnit:samplerUnit loadFromDLSOrSoundFont:url withPatch:61];
    
}

- (void) playdemo {
    //NewAUGraph(&(graph));
    
    /*
     NewMusicSequence(&sequence);
     
     NSString *midiFilePath = [[NSBundle mainBundle]
     pathForResource:@"teddybear"
     ofType:@"mid"];
     
     // Create a new URL which points to the MIDI file
     NSURL * midiFileURL = [NSURL fileURLWithPath:midiFilePath];
     
     MusicSequenceFileLoad(sequence, (__bridge CFURLRef)(midiFileURL), 0, 0);
     
     // Create a new music player
     MusicPlayer  p;
     // Initialise the music player
     NewMusicPlayer(&p);
     
     // Load the sequence into the music player
     MusicPlayerSetSequence(p, sequence);
     // Called to do some MusicPlayer setup. This just
     // reduces latency when MusicPlayerStart is called
     //MusicPlayerPreroll(p);
     // Starts the music playing
     MusicPlayerStart(p);
     
     */
}

- (OSStatus)samplerUnit:(AudioUnit)sampler loadFromDLSOrSoundFont:(NSURL *)bankURL withPatch:(int)presetNumber
{
    OSStatus result = noErr;
    
    // Fill out the sampler instrument data structure
    AUSamplerInstrumentData insdata;
    insdata.fileURL = (__bridge CFURLRef) bankURL;
    insdata.bankMSB  = kAUSampler_DefaultMelodicBankMSB;
    insdata.bankLSB  = kAUSampler_DefaultBankLSB;
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