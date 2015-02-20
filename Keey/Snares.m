//
//  Snares.m
//  Keey
//
//  Created by Ipalibo Whyte on 12/02/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import "Snares.h"

@implementation Snares

-(instancetype) init {
    
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"Snare" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((CFURLRef)CFBridgingRetain([NSURL fileURLWithPath: soundPath]), &_soundID);
    
    return self;
}

-(void) playSound {
    AudioServicesPlaySystemSound (_soundID);
}

@end
