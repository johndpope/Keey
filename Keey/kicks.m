//
//  kicks.m
//  Keey
//
//  Created by Ipalibo Whyte on 01/02/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import "kicks.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@implementation kicks {
    AVAudioPlayer *player;
}

-(instancetype)init{
    
    /*
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"Kick" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((CFURLRef)CFBridgingRetain([NSURL fileURLWithPath: soundPath]), &_soundID);
    */
    
    NSString *soundFilePath = [NSString stringWithFormat:@"%@/buffkick.wav",
                               [[NSBundle mainBundle] resourcePath]];
    
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
    [player prepareToPlay];
    
    return self;
}

-(void) playSound {
    
    [player play];
    //AudioServicesPlaySystemSound (_soundID);
}

@end
