//
//  kicks.m
//  Keey
//
//  Created by Ipalibo Whyte on 01/02/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import "kicks.h"

@implementation kicks

-(instancetype)init{
    
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"Kick" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((CFURLRef)CFBridgingRetain([NSURL fileURLWithPath: soundPath]), &_soundID);
    
    return self;
}

-(void) playSound {
    AudioServicesPlaySystemSound (_soundID);
}

@end
