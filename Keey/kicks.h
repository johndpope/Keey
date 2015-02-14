//
//  kicks.h
//  Keey
//
//  Created by Ipalibo Whyte on 01/02/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface kicks : NSObject
    
@property SystemSoundID soundID;

-(void) playSound;

@end
