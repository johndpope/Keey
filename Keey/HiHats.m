//
//  HiHats.m
//  Keey
//
//  Created by Ipalibo Whyte on 12/02/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import "HiHats.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@implementation HiHats {
    
    AVAudioPlayer *player;
    
}

-(instancetype)init {
    
    /*
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"HiHat" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((CFURLRef)CFBridgingRetain([NSURL fileURLWithPath: soundPath]), &_soundID);
    */
    
    NSString *soundFilePath = [NSString stringWithFormat:@"%@/Clap.wav",
                               [[NSBundle mainBundle] resourcePath]];
    
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
    [player prepareToPlay];
    
    return self;
}

-(void) playSound {
    [player play];
    AudioServicesPlaySystemSound (_soundID);
}

@end
